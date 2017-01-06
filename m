From: Ricardo Dias <rdias@suse.com>
Subject: Re: turn libcommon into a shared library and package it
Date: Fri, 6 Jan 2017 11:48:09 +0000
Message-ID: <000e3136-5222-cdf2-6479-476f120dabc5@suse.com>
References: <CAJE9aONgX-d7ZBBRGh3gDfCAOM6uPjGANoAue993_-Ewbrf0+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:32983 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754350AbdAFLsi (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 6 Jan 2017 06:48:38 -0500
In-Reply-To: <CAJE9aONgX-d7ZBBRGh3gDfCAOM6uPjGANoAue993_-Ewbrf0+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, jlayton@redhat.com



On 06-01-2017 11:38, kefu chai wrote:
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

I agree with this approach. In RBD we also had the same problems 
sometime ago, and we discussed the problem here
https://github.com/ceph/ceph/pull/8537

>
> but yes, unlike librados and its friends, libcommon is not a user
> facing library, so we will not install it right under /usr/lib/.
> instead, it will be living in /usr/lib/ceph.  please note, the erasure
> plugins are installed into /usr/lib/ceph/erasure-code/ and rados
> classes are installed into /usr/lib/rados-classes/. this follows the
> related section of FHS [1].
>
> what do you think?

+1 here. Please go forward with this :-)

>
> --
> [1] http://www.pathname.com/fhs/pub/fhs-2.3.html#USRLIBLIBRARIESFORPROGRAMMINGANDPA
>

-- 
Ricardo Dias
Senior Software Engineer - Storage Team
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, 
HRB 21284 (AG Nürnberg)
