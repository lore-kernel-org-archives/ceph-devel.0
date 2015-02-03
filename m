From: Samuel Just <sam.just@inktank.com>
Subject: Re: Confused about SnapMapper::get_prefix
Date: Tue, 3 Feb 2015 09:25:43 -0800
Message-ID: <CA+4uBUbAAKEX9YL2ZcgxumvzCkOYcCnT6CAC59ZBSN2kb7ygOA@mail.gmail.com>
References: <CANf+_kL0_tYtF+vDvLSTPP5LtP_4P6r9_M5qu7VeyP2GYfFw9Q@mail.gmail.com>
	<CAC6JEv8zKQZ8JVQrfo3bu=AW-xuHfOAC_NN260ywzboFVLuryA@mail.gmail.com>
	<CA+4uBUYP=eVxgQ0ur4x8kowfCf=uh+YETqL08WyY3an7QFfDZQ@mail.gmail.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:40357 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965461AbbBCRZp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 12:25:45 -0500
Received: by mail-la0-f50.google.com with SMTP id hs14so53486541lab.9
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 09:25:43 -0800 (PST)
In-Reply-To: <CA+4uBUYP=eVxgQ0ur4x8kowfCf=uh+YETqL08WyY3an7QFfDZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ding Dinghua <dingdinghua85@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Should probably be cast to long unsigned with lX conversion specifier?
-Sam

On Tue, Feb 3, 2015 at 9:21 AM, Samuel Just <sam.just@inktank.com> wrote:
> It looks like snapid_t is a uint64_t, but snprintf expects an unsigned there.
> -Sam
>
> On Tue, Feb 3, 2015 at 9:15 AM, Gregory Farnum <greg@gregs42.com> wrote:
>> On Tue, Feb 3, 2015 at 4:12 AM, Ding Dinghua <dingdinghua85@gmail.com> wrote:
>>> Hi all:
>>>       I don't understand why SnapMapper::get_prefix   static_cast snap
>>> to unsigned:
>>>
>>> string SnapMapper::get_prefix(snapid_t snap)
>>> {
>>>   char buf[100];
>>>   int len = snprintf(
>>>     buf, sizeof(buf),
>>>     "%.*X_", (int)(sizeof(snap)*2),
>>>     static_cast<unsigned>(snap));
>>>   return MAPPING_PREFIX + string(buf, len);
>>> }
>>>
>>> Will this limit snapshot count in pool to 2^32 -1 ?
>>>
>>> Could anyone clarify ? Thanks
>>
>> I think the code base is a little confused about whether snaps should
>> be 32 or 64 bits in various places. :( That said, the size of unsigned
>> can vary across architectures, so this should probably be sized more
>> explicitly as whatever it's supposed to be on the disk...
