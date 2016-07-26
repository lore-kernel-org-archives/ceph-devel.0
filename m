From: kefu chai <tchaikov@gmail.com>
Subject: static member variable in libcommon and double free
Date: Tue, 26 Jul 2016 17:32:34 +0800
Message-ID: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36242 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbcGZJcg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2016 05:32:36 -0400
Received: by mail-qk0-f181.google.com with SMTP id x1so865497qkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2016 02:32:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hey Cephers,

we are almost finished the transition to cmake. but we are also facing
some problems which did not exist in autotools.

last time i asked help on static library versus dynamic library in
this mailing list. and the consensus was we should just build and
package dynamic libraries. but this time, i ran into a more difficult
one: http://tracker.ceph.com/issues/16686.

a little bit background: we have a convenience library named libcommon
which wraps some of the class/methods shared across the Ceph project,
messenger among the other things. and in tracker#16686, i found that
in AsyncMessenger.cc, we have a static member variable named
WorkerPool::name. it is a std::string. see
https://github.com/ceph/ceph/blob/master/src/msg/async/AsyncMessenger.cc#L346

if we load both libceph.so and librados.so in the same process, when
the process exists, this variable will be destructed twice. hence the
double free. because the linker thinks that the symbols the two copies
of libcommon in libcephfs and librados are the same ones. while the
two libraries destruct the variable individually. that's why we have
this problem.

you might want to ask, "it works in autotools!". i asked myself the
same question. and i found that we don't pass
"-Wl,--exclude-libs=libcommon.a" or "-Wl,--exclude-libs,ALL" to linker
when linking libcephfs and librados, as we did in automake. this
confuses the run-time linker. yeah, we can do the same in cmake. but
this breaks the build. see
http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-amd64-basic/log.cgi?log=87ff7617bf2c07d43b6a6b7d116ea61f9ea6e905:

```
/srv/autobuild-ceph/gitbuilder.git/build/out~/ceph-11.0.0-902-g87ff761/src/common/Formatter.h:92:
undefined reference to `ceph::Formatter::~Formatter()'

error: collect2: ld returned 1 exit status

make[4]: *** [bin/ceph_test_rados_api_c_read_operations] Error 1
```

some librados tests (maybe more of them) are using the non-public
symbols. so we have two solutions:

- extract the .cc files which are used by these tests into a
convenience library and link the tests against it *and* librados. but
again this introduces the risk of double free. the extracted .cc files
should be non-POD static variable free.
- compile a static librados and link the tests against it. this
actually mimics the behavior of autotools. but this approach
complicates the cmake file, as we discussed before.


so, maybe we should just forbid the non-POD static variables in
libcommon? if you have  better solution, or i am completely wrong (i
wish so), please let me know.

thanks,

-- 
Regards
Kefu Chai
