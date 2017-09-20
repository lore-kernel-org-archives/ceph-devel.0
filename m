From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: fix for "crash in rocksdb LRUCache destructor with tcmalloc"
Date: Wed, 20 Sep 2017 09:19:33 -0400
Message-ID: <1505913573.4766.9.camel@poochiereds.net>
References: <CAJE9aOPgjk-u66vLezpq+TUxD-YJM4z-7vVGmLzQt9=5=2r2=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:54466 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdITNTh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Sep 2017 09:19:37 -0400
Received: by mail-qk0-f176.google.com with SMTP id d70so2629549qkc.11
        for <ceph-devel@vger.kernel.org>; Wed, 20 Sep 2017 06:19:37 -0700 (PDT)
In-Reply-To: <CAJE9aOPgjk-u66vLezpq+TUxD-YJM4z-7vVGmLzQt9=5=2r2=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 2017-09-20 at 10:58 +0800, kefu chai wrote:
> hi gperf-tools v2.5.93 (or fc25 users),
> 
> we sync'ed rocksdb to the recent upstream version in master last
> week-end. if you are using gperf-tools 2.5.93 (which is shipped with
> fc25), then you are likely to hit
> http://tracker.ceph.com/issues/21422. the root cause is that tcmalloc
> is offered by gperf-tools. but gperf-tools v2.5.93 didn't implement
> aligned_alloc(), and the recent version of rocksdb is using it. so
> what gets called is the glibc's aligned_alloc(), and when rocksdb
> frees that memory chunk allocated by aligned_alloc(), the free() from
> tcmalloc is used. so it panic'ed. for more details, please refer to
> the tracker ticket[0] and the pull request[1] to address it.
> 
> if you compile the latest master of ceph using gperf-tools 2.5.93, you will get
> 
> Incompatible tcmalloc v2.5.93 and rocksdb v5.8.0, please install
> gperf-tools 2.5 or > 2.6.2".
> 
> since the latest release of gperf-tools is 2.6.1, and it has not yet
> cut a release after including the for the aligned_alloc(), currently
> the suggested way to fix it is to upgrade your gperf-tools to the
> latest master by installing it[3] manually. and point cmake to it:
> 
> $ ./configure --prefix=$HOME/local # under gperftools
> $ make install
> $ GPERF_ROOT=$HOME/local cmake .. # under ceph/build
> 
> 
> 
> ---
> [0] http://tracker.ceph.com/issues/21422
> [1] https://github.com/ceph/ceph/pull/17788
> [3] https://github.com/gperftools/gperftools/tree/master
> 

...or if you're too lazy for all that, you can tell cmake to use a
different allocator. Something like:

    $ cmake -DALLOCATOR="libc" ..

YMMV of course, and it may have an impact on performance.
-- 
Jeff Layton <jlayton@poochiereds.net>
