From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: object class capability semantics
Date: Mon, 21 Mar 2016 12:54:50 -0700
Message-ID: <CAJ4mKGa=-Caw8uQ+MXhsM-qW8fywk7a+ULfHoYruBoWv47NA+A@mail.gmail.com>
References: <CAB2gnbVFypTbHREtJAb6od1bC9ZpRtCz04BHg=6Yqmi5eEtP2A@mail.gmail.com>
	<CAJ4mKGY4VMk+dbF59RWmY+LkvG_26d-X0xADHFpYyZqOJnkNqA@mail.gmail.com>
	<alpine.DEB.2.11.1603211527350.23875@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33633 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398AbcCUTyv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 15:54:51 -0400
Received: by mail-vk0-f49.google.com with SMTP id k1so228262360vkb.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 12:54:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603211527350.23875@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <noahwatkins@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sjust@redhat.com>

On Mon, Mar 21, 2016 at 12:30 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 21 Mar 2016, Gregory Farnum wrote:
>> On Mon, Mar 21, 2016 at 8:55 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
>> > # Class Execute Capabilities
>> >
>> > Purpose: wire up class capabilities and add an option to specify the
>> > names of object classes are allowed to be used without explicit
>> > capabilities.
>> >
>> > ## Default Object Class List
>> >
>> > Format: `osd class default list = * | [class[ class[ ...]]`
>> >    1) * any class may be loaded
>> >    2) list of class names allowed
>> >
>> > Interpretation of this option is described below.
>> >
>> > ## Enabling Class Capabilities
>> >
>> > It looks like currently in OSDCap::is_capable() that 'x' and class
>> > read/write capabilities are checked. The first change would be to
>> > cross reference these checks with the `osd class default list` to
>> > ensure that the class is on the allowed list.
>>
>> Woah, no way. These are capabilities, and are additive. We and our
>> users are going to be very unhappy if the security meaning of one cap
>> changes depending on others.
>
> I'm not following.  The meaning changes based on the config, not another
> cap.

Ah, that is tickling my memory a little more and sounds better. I
thought this was describing extra caps in the cephx ticket.

>
>> So I take it you mean for those execute and load capabilities to be
>> applied to clients, not the OSD or class methods or something? In that
>> case we can just stick them as additional clauses within the class
>> cap, and I guess take the missing clause to be "all" or the default
>> set or something.
>
> The problem is that 'x' means any class, but that was a bad idea on our
> part.  Users should really specify which classes they mean going forward,
> but for existing clusters that isn't being done, and we can't break
> those, nor should we give them access to any random new class
> that shows up on the system.
>
> This changes it to mean 'any class in the configured list of default
> classes, as specified by ceph.conf'...

Yeah.
