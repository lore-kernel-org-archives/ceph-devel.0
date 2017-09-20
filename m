From: kefu chai <tchaikov@gmail.com>
Subject: fix for "crash in rocksdb LRUCache destructor with tcmalloc"
Date: Wed, 20 Sep 2017 10:58:20 +0800
Message-ID: <CAJE9aOPgjk-u66vLezpq+TUxD-YJM4z-7vVGmLzQt9=5=2r2=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:45950 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdITC6V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 22:58:21 -0400
Received: by mail-oi0-f42.google.com with SMTP id z73so755236oia.2
        for <ceph-devel@vger.kernel.org>; Tue, 19 Sep 2017 19:58:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi gperf-tools v2.5.93 (or fc25 users),

we sync'ed rocksdb to the recent upstream version in master last
week-end. if you are using gperf-tools 2.5.93 (which is shipped with
fc25), then you are likely to hit
http://tracker.ceph.com/issues/21422. the root cause is that tcmalloc
is offered by gperf-tools. but gperf-tools v2.5.93 didn't implement
aligned_alloc(), and the recent version of rocksdb is using it. so
what gets called is the glibc's aligned_alloc(), and when rocksdb
frees that memory chunk allocated by aligned_alloc(), the free() from
tcmalloc is used. so it panic'ed. for more details, please refer to
the tracker ticket[0] and the pull request[1] to address it.

if you compile the latest master of ceph using gperf-tools 2.5.93, you will get

Incompatible tcmalloc v2.5.93 and rocksdb v5.8.0, please install
gperf-tools 2.5 or > 2.6.2".

since the latest release of gperf-tools is 2.6.1, and it has not yet
cut a release after including the for the aligned_alloc(), currently
the suggested way to fix it is to upgrade your gperf-tools to the
latest master by installing it[3] manually. and point cmake to it:

$ ./configure --prefix=$HOME/local # under gperftools
$ make install
$ GPERF_ROOT=$HOME/local cmake .. # under ceph/build



---
[0] http://tracker.ceph.com/issues/21422
[1] https://github.com/ceph/ceph/pull/17788
[3] https://github.com/gperftools/gperftools/tree/master

-- 
Regards
Kefu Chai
