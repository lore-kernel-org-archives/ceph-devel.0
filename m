From: Samuel Just <sjust@redhat.com>
Subject: Re: [ceph-users] Any librados C API users out there?
Date: Wed, 11 Jan 2017 09:42:46 -0800
Message-ID: <CAN=+7FXy1Thu56XCoBGAoQ1MZbUL0iPHfnD_f1w50X-_h+67=g@mail.gmail.com>
References: <8d5e71b7-c0f2-0f6f-b38e-03e72f441051@corp.ovh.com> <CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:32774 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765688AbdAKRms (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2017 12:42:48 -0500
Received: by mail-qk0-f174.google.com with SMTP id s140so193810797qke.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2017 09:42:47 -0800 (PST)
In-Reply-To: <CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dillaman, Jason" <dillaman@redhat.com>
Cc: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>, ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Jason: librbd itself uses the librados C++ api though, right?
-Sam

On Wed, Jan 11, 2017 at 9:37 AM, Jason Dillaman <jdillama@redhat.com> wrote:
> +1
>
> I'd be happy to tweak the internals of librbd to support pass-through
> of C buffers all the way to librados. librbd clients like QEMU use the
> C API and this currently results in several extra copies (in librbd
> and librados).
>
> On Wed, Jan 11, 2017 at 11:44 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
>> Hello,
>>
>> As the subject says - are here any users/consumers of librados C API? I'm
>> asking because we're researching if this PR:
>> https://github.com/ceph/ceph/pull/12216 will be actually beneficial for
>> larger group of users. This PR adds a bunch of new APIs that perform object
>> writes without intermediate data copy, which will reduce cpu and memory load
>> on clients. If you're using librados C API for object writes, feel free to
>> comment here or in the pull request.
>>
>>
>> --
>> Piotr Dałek
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
> --
> Jason
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
