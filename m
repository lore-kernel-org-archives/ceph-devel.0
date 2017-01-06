From: kefu chai <tchaikov@gmail.com>
Subject: turn libcommon into a shared library and package it
Date: Fri, 6 Jan 2017 19:38:12 +0800
Message-ID: <CAJE9aONgX-d7ZBBRGh3gDfCAOM6uPjGANoAue993_-Ewbrf0+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36939 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755106AbdAFLiO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 06:38:14 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so25448394wmt.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2017 03:38:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, rdias@suse.com, jlayton@redhat.com

hi cephers,

libcommon is a convenient library and is statically linked into
librados, librbd and libcephfs. and there are some static variables
living in libcommon, for instance, the ones defined in lockdep.cc. so,
we will have multiple copies of these global variables if an
application is linked against librados and (librbd | libcephfs).  the
"ceph" cli does link against librados and libcephfs via the their
python bindings.

this incurs some problems:

- cross reference each other's global variables: in my testbed, i ran
into https://github.com/ceph/ceph/pull/12249#issuecomment-264105597.
where libcephfs was referencing the lockdeps variables in librados
when relinquishing a lock. when libcephfs tries to acquire this lock
again, it found that this lock is *already* locked.
- more memory foot print and disk space: apparently, libcommon is
included by librados, librbd and libcephfs. so it's a waste to have
multiple copies of libcommon if librbd and/or libcephfs are loaded
into memory or installed onto disk.

after turning libcommon into a shared library, these problems are solved.

but yes, unlike librados and its friends, libcommon is not a user
facing library, so we will not install it right under /usr/lib/.
instead, it will be living in /usr/lib/ceph.  please note, the erasure
plugins are installed into /usr/lib/ceph/erasure-code/ and rados
classes are installed into /usr/lib/rados-classes/. this follows the
related section of FHS [1].

what do you think?

--
[1] http://www.pathname.com/fhs/pub/fhs-2.3.html#USRLIBLIBRARIESFORPROGRAMMINGANDPA

-- 
Regards
Kefu Chai
