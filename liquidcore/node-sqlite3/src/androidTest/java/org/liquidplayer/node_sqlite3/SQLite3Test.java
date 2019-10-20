package org.liquidplayer.node_sqlite3;

import android.content.Context;
import androidx.test.InstrumentationRegistry;
import androidx.test.runner.AndroidJUnit4;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.liquidplayer.javascript.JSContext;
import org.liquidplayer.javascript.JSException;
import org.liquidplayer.node.Process;
import org.liquidplayer.service.MicroService;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import static org.junit.Assert.*;

@RunWith(AndroidJUnit4.class)
public class SQLite3Test implements JSContext.IJSExceptionHandler, Process.EventListener {
    private final CountDownLatch waitForService = new CountDownLatch(1);

    @Test
    public void testModule() throws Exception {
        Context appContext = InstrumentationRegistry.getTargetContext();

        MicroService service = new MicroService(appContext,
            MicroService.DevServer(),
        new MicroService.ServiceStartListener() {
            @Override public void onStart(MicroService service) {
                service.getProcess().addEventListener(SQLite3Test.this);
            }
        }, new MicroService.ServiceErrorListener() {
            @Override public void onError(MicroService service, Exception e) {
                fail(e.getMessage());
                waitForService.countDown();
            }
        });
        service.start();
        waitForService.await(60L, TimeUnit.SECONDS);
    }

    @Override
    public void handle(JSException exception) {
        fail(exception.toString());
    }

    @Override
    public void onProcessStart(Process process, JSContext context) {
        context.setExceptionHandler(SQLite3Test.this);
    }
    @Override public void onProcessExit(Process process, int exitCode) {
        waitForService.countDown();
    }

    // Do nothing :- onProcessFailed will get captured in ServiceErrorListener
    @Override public void onProcessAboutToExit(Process process, int exitCode) {}
    @Override public void onProcessFailed(Process process, Exception error) {}
}
