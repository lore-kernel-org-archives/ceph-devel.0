From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: inconsistent rados semantics between automake/cmake builds
Date: Thu, 21 Jan 2016 09:13:22 -0800
Message-ID: <CAB2gnbUG6kJF40kcDTcHHjXS5TeLALnTBfF1wFVCGE8PTxeSeg@mail.gmail.com>
References: <CAB2gnbUxzE7z6ec39=cPg2sqNOtMc6cS8_GN9ybxxdvB7zXW+g@mail.gmail.com>
	<CADRKj5RFKdLWWAaWg1EtTtJB+g3FigoEm3=xJ2+FCostq7fp4A@mail.gmail.com>
	<20160121170305.GA32590@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34188 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933293AbcAURNX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jan 2016 12:13:23 -0500
Received: by mail-ig0-f182.google.com with SMTP id ik10so128376806igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jan 2016 09:13:23 -0800 (PST)
In-Reply-To: <20160121170305.GA32590@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Noah Watkins <noahwatkins@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>, Orit Wasserman <owasserm@redhat.com>

It's easy for me to reproduce. What would you like me to run?

On Thu, Jan 21, 2016 at 9:03 AM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 21/01/2016, Yehuda Sadeh-Weinraub wrote:
> [snip]
>> This sounds somewhat like an issue Casey and Orit had seen, one that I
>> wasn't able to replicate (both of them are using cmake, I'm using
>> automake). I think they tracked it to Adam's c++11 time change.
> [snip]
>
> I was thinking about this the other night. There doesn't seem to be any problem
> with the actual /read/ that I can find. (There'd be failures in stat all over
> the place.)
>
> But I recalled that Objecter allows you to specify the mtime for operations and
> thought perhaps that might be where the problem is. If we know what operation is
> creating/last touching these objects, can someone who's able to reproduce the
> problem run a cycle or two of it through valgrind? It might be feeding in a
> not-properly-initialized time value, and if this shows up under one build system
> but not another that feels like it could be a touch more likely.
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
