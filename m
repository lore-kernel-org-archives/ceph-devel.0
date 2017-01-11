From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [ceph-users] Any librados C API users out there?
Date: Wed, 11 Jan 2017 12:46:51 -0500
Message-ID: <CA+aFP1ByFPk0Dh7Ba7i243Z+asJw4N+NXDDJos0av3iYZm4CjA@mail.gmail.com>
References: <8d5e71b7-c0f2-0f6f-b38e-03e72f441051@corp.ovh.com>
 <CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg@mail.gmail.com> <CAN=+7FXy1Thu56XCoBGAoQ1MZbUL0iPHfnD_f1w50X-_h+67=g@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33645 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756594AbdAKRqy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2017 12:46:54 -0500
Received: by mail-lf0-f49.google.com with SMTP id k86so141911652lfi.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2017 09:46:53 -0800 (PST)
In-Reply-To: <CAN=+7FXy1Thu56XCoBGAoQ1MZbUL0iPHfnD_f1w50X-_h+67=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>, ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

It does internally -- which requires the extra copy from C array to a
bufferlist. I had a PR for wrapping the C array into a bufferlist (w/o
the copy), but Sage pointed out a potential issue with such
implementations (which might still be an issue w/ this PR).

[1] https://github.com/yuyuyu101/ceph/commit/794b49b5b860c538a349bdadb16bb6ae97ad9c20

On Wed, Jan 11, 2017 at 12:42 PM, Samuel Just <sjust@redhat.com> wrote:
> Jason: librbd itself uses the librados C++ api though, right?
> -Sam
>
> On Wed, Jan 11, 2017 at 9:37 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>> +1
>>
>> I'd be happy to tweak the internals of librbd to support pass-through
>> of C buffers all the way to librados. librbd clients like QEMU use the
>> C API and this currently results in several extra copies (in librbd
>> and librados).
>>
>> On Wed, Jan 11, 2017 at 11:44 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
>>> Hello,
>>>
>>> As the subject says - are here any users/consumers of librados C API? I'm
>>> asking because we're researching if this PR:
>>> https://github.com/ceph/ceph/pull/12216 will be actually beneficial for
>>> larger group of users. This PR adds a bunch of new APIs that perform object
>>> writes without intermediate data copy, which will reduce cpu and memory load
>>> on clients. If you're using librados C API for object writes, feel free to
>>> comment here or in the pull request.
>>>
>>>
>>> --
>>> Piotr Dałek
>>>
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>>
>> --
>> Jason
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Jason
