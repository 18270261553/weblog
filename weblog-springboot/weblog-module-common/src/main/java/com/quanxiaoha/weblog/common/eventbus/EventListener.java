package com.quanxiaoha.weblog.common.eventbus;

import org.springframework.stereotype.Component;

/**
 * @author: dgq   
 * @date: 2023-07-02 9:20
 * @description: TODO
 **/
@Component
public interface EventListener {
    void handleEvent(ArticleEvent weblogEvent);
}
