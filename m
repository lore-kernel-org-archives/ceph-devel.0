From: kefu chai <tchaikov@gmail.com>
Subject: Re: Understanding some of the Cmake logics
Date: Tue, 10 Oct 2017 19:14:09 +0800
Message-ID: <CAJE9aONEKsSnh7De6-TcS_BwKsCnqav8MXkDR6aUFuMp2out6A@mail.gmail.com>
References: <b06780c7-13ce-1274-735f-806a1f4f8062@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:48574 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754416AbdJJLOL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Oct 2017 07:14:11 -0400
Received: by mail-oi0-f51.google.com with SMTP id m198so32074190oig.5
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 04:14:10 -0700 (PDT)
In-Reply-To: <b06780c7-13ce-1274-735f-806a1f4f8062@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

+ ceph-devel

On Tue, Oct 10, 2017 at 4:49 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi Kefu,
>
> Sort of wondering what in the current code below is the relation between
> gpertools and tcmalloc?

could you be more specific?

>
> Reason for the question is that once the gperf packages is installed,
> as a bonus the code below declares the allocator to be tcmalloc.
> But gperf under FreeBSD does not have tcmalloc.

please note gperf here is not GNU perf [1] but google-perftools. and
why do you claim the gperf under FreeBSD does not have tcmalloc? could
you elaborate this a little bit?

--
[1] http://portsmon.freebsd.org/portoverview.py?category=devel&portname=gperf
[2] http://portsmon.freebsd.org/portoverview.py?category=devel&portname=google-perftools

>
> So I guess I need to fix the code below the to prevent this implicit
> relation
> under FreeBSD.
>
> And the problem that arises from this all lies in compiling rocksdb,
> because
> under FreeBSD that also needs to be build with libc as allocator.
> The introduction of the new rocksdb building makes this clear.
>
> CMake Error at cmake/modules/BuildRocksDB.cmake:63 (message):
>   Incompatible tcmalloc v2.6.1 and rocksdb v5.8.0, please install
> gperf-tools
>   2.5 (not 2.5.93) or >= 2.6.2, or switch to another allocator using 'cmake
>   -DALLOCATOR=libc'.
> Call Stack (most recent call first):
>   src/CMakeLists.txt:825 (build_rocksdb)
>
>
> --WjW
>
>
> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 286)
> if(ALLOCATOR)
> ca9946d2b5a (Bassam Tabbara      2016-10-10 14:37:58 -0700 287)
> if(${ALLOCATOR} MATCHES "tcmalloc(_minimal)?")
> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 288)
> find_package(gperftools REQUIRED)
> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 289)
> set(HAVE_LIBTCMALLOC ON)
> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 290)
> elseif(${ALLOCATOR} STREQUAL "jemalloc")
> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 291)
> find_package(JeMalloc REQUIRED)
> 0ef09f32d46 (Ali Maredia         2016-05-02 18:21:32 -0400 292)
> set(HAVE_LIBJEMALLOC ${JEMALLOC_FOUND})
> 83b74f52501 (Matt Benjamin       2016-12-21 23:36:37 -0500 293)
> set(HAVE_JEMALLOC 1)
> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 294)   endif()
> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 295)
> else(ALLOCATOR)
> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 296)
> find_package(gperftools)
> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 297)
> set(HAVE_LIBTCMALLOC ${GPERFTOOLS_FOUND})
> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 298)   if(NOT
> GPERFTOOLS_FOUND)
> 0ef09f32d46 (Ali Maredia         2016-05-02 18:21:32 -0400 299)
> find_package(JeMalloc)
> 0ef09f32d46 (Ali Maredia         2016-05-02 18:21:32 -0400 300)
> set(HAVE_LIBJEMALLOC ${JEMALLOC_FOUND})
> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 301)
> endif(NOT GPERFTOOLS_FOUND)
> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 302)
> if(GPERFTOOLS_FOUND)
> 48a1f8eff5b (Kefu Chai           2016-06-08 11:34:44 +0800 303)
> set(ALLOCATOR tcmalloc)
> 48a1f8eff5b (Kefu Chai           2016-06-08 11:34:44 +0800 304)
> elseif(JEMALLOC_FOUND)
> 48a1f8eff5b (Kefu Chai           2016-06-08 11:34:44 +0800 305)
> set(ALLOCATOR jemalloc)
> 48a1f8eff5b (Kefu Chai           2016-06-08 11:34:44 +0800 306)   else()
> ce3b71acd20 (Willem Jan Withagen 2017-02-12 15:03:56 +0100 307)
> if(NOT FREEBSD)
> ce3b71acd20 (Willem Jan Withagen 2017-02-12 15:03:56 +0100 308)       #
> FreeBSD already has jemalloc as its default allocator
> ce3b71acd20 (Willem Jan Withagen 2017-02-12 15:03:56 +0100 309)
> message(WARNING "tcmalloc and jemalloc not found, falling back to libc")
> ce3b71acd20 (Willem Jan Withagen 2017-02-12 15:03:56 +0100 310)     endif()
> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 311)
> set(ALLOCATOR "libc")
> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 312)
> endif(GPERFTOOLS_FOUND)
> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 313)
> endif(ALLOCATOR)
>



-- 
Regards
Kefu Chai
