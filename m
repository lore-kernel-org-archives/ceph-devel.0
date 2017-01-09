From: kefu chai <tchaikov@gmail.com>
Subject: Re: turn libcommon into a shared library and package it
Date: Mon, 9 Jan 2017 16:59:16 +0800
Message-ID: <CAJE9aOMbUjryq0ek4jhQgprY03_pSJTJC2M-ChmTp_ECkKGpFg@mail.gmail.com>
References: <CAJE9aONgX-d7ZBBRGh3gDfCAOM6uPjGANoAue993_-Ewbrf0+w@mail.gmail.com>
 <000e3136-5222-cdf2-6479-476f120dabc5@suse.com> <1483705239.2733.2.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37724 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757403AbdAII7T (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 03:59:19 -0500
Received: by mail-wm0-f44.google.com with SMTP id c206so21967212wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 00:59:18 -0800 (PST)
In-Reply-To: <1483705239.2733.2.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ricardo Dias <rdias@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

thanks guys. will rename it to libceph-common and package it in librados.

On Fri, Jan 6, 2017 at 8:20 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Fri, 2017-01-06 at 11:48 +0000, Ricardo Dias wrote:
>>
>> On 06-01-2017 11:38, kefu chai wrote:
>> >
>> > hi cephers,
>> >
>> > libcommon is a convenient library and is statically linked into
>> > librados, librbd and libcephfs. and there are some static variables
>> > living in libcommon, for instance, the ones defined in lockdep.cc. so,
>> > we will have multiple copies of these global variables if an
>> > application is linked against librados and (librbd | libcephfs).  the
>> > "ceph" cli does link against librados and libcephfs via the their
>> > python bindings.
>> >
>> > this incurs some problems:
>> >
>> > - cross reference each other's global variables: in my testbed, i ran
>> > into https://github.com/ceph/ceph/pull/12249#issuecomment-264105597.
>> > where libcephfs was referencing the lockdeps variables in librados
>> > when relinquishing a lock. when libcephfs tries to acquire this lock
>> > again, it found that this lock is *already* locked.
>> > - more memory foot print and disk space: apparently, libcommon is
>> > included by librados, librbd and libcephfs. so it's a waste to have
>> > multiple copies of libcommon if librbd and/or libcephfs are loaded
>> > into memory or installed onto disk.
>> >
>> > after turning libcommon into a shared library, these problems are solved.
>>
>> I agree with this approach. In RBD we also had the same problems
>> sometime ago, and we discussed the problem here
>> https://github.com/ceph/ceph/pull/8537
>>
>> >
>> >
>> > but yes, unlike librados and its friends, libcommon is not a user
>> > facing library, so we will not install it right under /usr/lib/.
>> > instead, it will be living in /usr/lib/ceph.  please note, the erasure
>> > plugins are installed into /usr/lib/ceph/erasure-code/ and rados
>> > classes are installed into /usr/lib/rados-classes/. this follows the
>> > related section of FHS [1].
>> >
>> > what do you think?
>>
>> +1 here. Please go forward with this :-)
>>
>> >
>> >
>> > --
>> > [1] http://www.pathname.com/fhs/pub/fhs-2.3.html#USRLIBLIBRARIESFORPROGRAMMINGANDPA
>> >
>>
>
> Sounds good to me.
>
> It might also not hurt to rename it. libcommon as a name is awfully
> generic and could run afoul of other libs on the machine that have
> nothing to do with ceph (regardless of whether you install it in this
> private location). Maybe libceph-common?
>
> --
> Jeff Layton <jlayton@redhat.com>



-- 
Regards
Kefu Chai
