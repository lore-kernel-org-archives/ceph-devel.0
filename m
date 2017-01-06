From: John Spray <jspray@redhat.com>
Subject: Re: turn libcommon into a shared library and package it
Date: Fri, 6 Jan 2017 12:36:35 +0000
Message-ID: <CALe9h7dJwUGOnKVH+NigM_jijmHJQrwe-LhETEUMkVwV9fpdww@mail.gmail.com>
References: <CAJE9aONgX-d7ZBBRGh3gDfCAOM6uPjGANoAue993_-Ewbrf0+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36376 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161530AbdAFNGq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 08:06:46 -0500
Received: by mail-oi0-f46.google.com with SMTP id u143so22890814oif.3
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2017 05:06:46 -0800 (PST)
In-Reply-To: <CAJE9aONgX-d7ZBBRGh3gDfCAOM6uPjGANoAue993_-Ewbrf0+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, rdias@suse.com, Jeff Layton <jlayton@redhat.com>

On Fri, Jan 6, 2017 at 11:38 AM, kefu chai <tchaikov@gmail.com> wrote:
> hi cephers,
>
> libcommon is a convenient library and is statically linked into
> librados, librbd and libcephfs. and there are some static variables
> living in libcommon, for instance, the ones defined in lockdep.cc. so,
> we will have multiple copies of these global variables if an
> application is linked against librados and (librbd | libcephfs).  the
> "ceph" cli does link against librados and libcephfs via the their
> python bindings.
>
> this incurs some problems:
>
> - cross reference each other's global variables: in my testbed, i ran
> into https://github.com/ceph/ceph/pull/12249#issuecomment-264105597.
> where libcephfs was referencing the lockdeps variables in librados
> when relinquishing a lock. when libcephfs tries to acquire this lock
> again, it found that this lock is *already* locked.
> - more memory foot print and disk space: apparently, libcommon is
> included by librados, librbd and libcephfs. so it's a waste to have
> multiple copies of libcommon if librbd and/or libcephfs are loaded
> into memory or installed onto disk.
>
> after turning libcommon into a shared library, these problems are solved.
>
> but yes, unlike librados and its friends, libcommon is not a user
> facing library, so we will not install it right under /usr/lib/.
> instead, it will be living in /usr/lib/ceph.  please note, the erasure
> plugins are installed into /usr/lib/ceph/erasure-code/ and rados
> classes are installed into /usr/lib/rados-classes/. this follows the
> related section of FHS [1].
>
> what do you think?

+1

John

>
> --
> [1] http://www.pathname.com/fhs/pub/fhs-2.3.html#USRLIBLIBRARIESFORPROGRAMMINGANDPA
>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
