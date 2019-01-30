/*
 * Copyright (c) 2019 Eric Lange
 *
 * Distributed under the MIT License.
 */
const sqlite3 = require('sqlite3');
const fs = require('fs');

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

function test(fname) {
  console.log('Testing ' + fname);
  var db = new sqlite3.Database(fname);

  db.serialize(function() {
    db.run("CREATE TABLE lorem (info TEXT)");

    var stmt = db.prepare("INSERT INTO lorem VALUES (?)");
    for (var i = 0; i < 10; i++) {
        stmt.run("Ipsum " + i);
    }
    stmt.finalize();

    db.all("SELECT Count(*) AS count FROM lorem", function(err, rows) {
      assert(rows.length == 1, "rows.length == " + rows.length + ", expected 1");
      assert(rows[0].count == 10, "count == " + rows[0].count + ", expected 10")
    });

    db.each("SELECT rowid AS id, info FROM lorem", function(err, row) {
        console.log(row.id + ": " + row.info);
        assert(row.info == 'Ipsum ' + String(row.id-1),
          'row.info == "Ipsum ' + String(row.id-1) +'"');
    });
  });

  db.close();
}

const tempdir = (global.LiquidCore === undefined) ? '/var/tmp/' : '/home/temp/';

if (fs.existsSync(tempdir + 'test.sqlite')) {
  fs.unlinkSync(tempdir + 'test.sqlite');
}

test(':memory:');
test('');
test(tempdir + 'test.sqlite');