From: liuchang0812 <liuchang0812@gmail.com>
Subject: question about cache-tier tool
Date: Mon, 19 Dec 2016 20:25:25 +0800
Message-ID: <CACKY0b-6+RxCyqRy-FKbXY88-n4Yt4mGBhVB_CUk5OzALmuLPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34035 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbcLSMZ1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2016 07:25:27 -0500
Received: by mail-qt0-f173.google.com with SMTP id n6so145237192qtd.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2016 04:25:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi, all

We have a tool called "rados", and provides following  functions:

"CACHE POOLS: (for testing/development only)\n"
" cache-flush <obj-name> flush cache pool object (blocking)\n"
" cache-try-flush <obj-name> flush cache pool object (non-blocking)\n"
" cache-evict <obj-name> evict cache pool object\n"
" cache-flush-evict-all flush+evict all objects\n"
" cache-try-flush-evict-all try-flush+evict all objects\n"

Why doesn't it provide cache-try-evict and cache-flush-evict?
