package org.liquidplayer.addon;

import android.content.Context;

import org.liquidplayer.javascript.JSValue;
import org.liquidplayer.node_sqlite3.BuildConfig;
import org.liquidplayer.node_sqlite3.SQLite3Shim;
import org.liquidplayer.service.AddOn;
import org.liquidplayer.service.MicroService;

public class NodeSqlite3 implements AddOn {
    public NodeSqlite3(Context context) {}

    @Override
    public void register(String module) {
        if (BuildConfig.DEBUG && !module.equals("node_sqlite3")) {
            throw new AssertionError();
        }
        System.loadLibrary("node-sqlite3.node");

        SQLite3Shim.init();
    }

    @Override
    public void require(JSValue binding, MicroService service) {
        if (BuildConfig.DEBUG && (binding == null || !binding.isObject())) {
            throw new AssertionError();
        }
    }

    native static void register();
}