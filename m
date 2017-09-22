From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: fix for "crash in rocksdb LRUCache destructor with tcmalloc"
Date: Fri, 22 Sep 2017 11:43:04 +1000
Message-ID: <CAF-wwdFwU5B327bvQHYXmH8v8+sa1ifVZjg00Aq36OxE15Z6wg@mail.gmail.com>
References: <CAJE9aOPgjk-u66vLezpq+TUxD-YJM4z-7vVGmLzQt9=5=2r2=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:44020 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdIVBnL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Sep 2017 21:43:11 -0400
Received: by mail-pg0-f50.google.com with SMTP id u18so4508140pgo.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 Sep 2017 18:43:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJE9aOPgjk-u66vLezpq+TUxD-YJM4z-7vVGmLzQt9=5=2r2=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On Wed, Sep 20, 2017 at 12:58 PM, kefu chai <tchaikov@gmail.com> wrote:

Thanks for posting this Kefu as well as taking the lead on diagnosing this.

Just want to clarify some details below.

> hi gperf-tools v2.5.93 (or fc25 users),

Think you mean fc26 users?

>
> we sync'ed rocksdb to the recent upstream version in master last
> week-end. if you are using gperf-tools 2.5.93 (which is shipped with
> fc25), then you are likely to hit

2.5.93 is shipped with fc26.

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

If you do not encounter dependency hell you can also remove
gperftools-devel-2.5.93-1.fc26.x86_64 and gperftools-libs-2.5.93-1.fc26.x86_64
and install gperftools-devel-2.5-2.fc25.x86_64 and
gperftools-libs-2.5-2.fc25.x86_64 from
http://download.bne.redhat.com/pub/fedora/linux/releases/25/Everything/x86_64/os/Packages/g/
as I have had success up to this point with those packages (YMMV). Of course as
Jeff pointed out you can also specify the libc allocator to cmake.

Alternatively, I have created an unofficial package that contains the required
patch here.

https://copr-be.cloud.fedoraproject.org/results/badone/misc/fedora-26-x86_64/00606401-gperftools/

So far this seems to work fine but it may cause problems so caveat emptor :)

This patch should allow you to build with my package.

diff --git a/cmake/modules/BuildRocksDB.cmake b/cmake/modules/BuildRocksDB.cmake
index 8c44098d6f..efbd97fab2 100644
--- a/cmake/modules/BuildRocksDB.cmake
+++ b/cmake/modules/BuildRocksDB.cmake
@@ -59,7 +59,8 @@ macro(build_rocksdb)
     # see http://tracker.ceph.com/issues/21422
     if(ROCKSDB_VERSION_STRING VERSION_GREATER 5.7 AND
         TCMALLOC_VERSION_STRING VERSION_GREATER 2.5 AND
-        TCMALLOC_VERSION_STRING VERSION_LESS 2.6.2)
+        TCMALLOC_VERSION_STRING VERSION_LESS 2.6.2 AND NOT
+        TCMALLOC_VERSION_STRING VERSION_EQUAL 2.5.93-x)
       message(SEND_ERROR
         "Incompatible tcmalloc v${TCMALLOC_VERSION_STRING} and rocksdb v${ROCKSDB_VERSION_STRING}, "
         "please install gperf-tools 2.5 or > 2.6.2")

I've also created a bug against fc26 here.

https://bugzilla.redhat.com/show_bug.cgi?id=1494309

>
>
>
> ---
> [0] http://tracker.ceph.com/issues/21422
> [1] https://github.com/ceph/ceph/pull/17788
> [3] https://github.com/gperftools/gperftools/tree/master
>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Cheers,
Brad
