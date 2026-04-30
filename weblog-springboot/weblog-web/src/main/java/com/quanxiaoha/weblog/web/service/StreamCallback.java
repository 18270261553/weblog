package com.quanxiaoha.weblog.web.service;

/**
 * Stream response callback interface
 */
public interface StreamCallback {
    void onNext(String chunk);
    void onComplete();
    void onError(Throwable error);
}
