From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under very
 heavy write load
Date: Mon, 6 Feb 2012 10:35:56 -0800
Message-ID: <CAF3hT9CW7_CF4iT0cY858kgkke7Wu=TK7ULzPhFj-AW9jycyZA@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
	<CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
	<4F29CDAA.408@sandia.gov>
	<CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
	<4F2AABF5.6050803@sandia.gov>
	<CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
	<4F2ADEAE.8010403@sandia.gov>
	<CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
	<4F2AF085.6000405@sandia.gov>
	<CAF3hT9AcxxNtscFczP8fShSsaBm_4zhLQZ2F5c7h1YswVaXHkA@mail.gmail.com>
	<4F2C08A7.2050507@sandia.gov>
	<3032884323297001561@unknownmsgid>
	<4F2C6EE6.4050008@sandia.gov>
	<CAC-hyiHSNv_VgLcyVCrJ66HxTGFNBONrmmBddJk5326dLTKgkw@mail.gmail.com>
	<4F2FFDD3.1010100@sandia.gov>
	<CAC-hyiEdAd++dQFBjPDutqipQcMXZqh4RdEEyA=v12vs6ueDxA@mail.gmail.com>
	<4F3019E9.80607@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63642 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab2BFSf4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2012 13:35:56 -0500
Received: by iacb35 with SMTP id b35so8855964iac.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2012 10:35:56 -0800 (PST)
In-Reply-To: <4F3019E9.80607@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Feb 6, 2012 at 10:20 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 02/06/2012 10:22 AM, Yehuda Sadeh Weinraub wrote:
>>
>> On Mon, Feb 6, 2012 at 8:20 AM, Jim Schutt<jaschut@sandia.gov> =A0wr=
ote:
>
>
>>>
>>> The above suggests to me that the slowdown is a result
>>> of requests not getting submitted at the same rate as
>>> when things are running well.
>>>
>>
>> Yeah, it really looks like that. My suggestions wouldn't help there.
>>
>> I do see that when things go well the number of writes per device is
>> capped at ~200 writes per second and the throughput per device is
>> ~100MB/sec. Is 100MB/sec the expected device throughput?
>
>
> Pretty much, at least for the outer tracks on a drive. =A0I've seen
> ~108 MB/s with dd to a block device. =A0Also, I've got 8 drives per
> SAS adapter with 6 Gb/s links, so it seems unlikely to me that my
> disk subsystem is any sort of significant bottleneck.

Well, you might try changing your throttling settings on the OSDs.
ms_dispatch_throttle_bytes defaults to 100<<20 (100MB) and is used for
throttling dispatch; osd_max_client_bytes defaults to 500<<20 (500MB)
and is used to limit the amount of client data in memory (ie; messages
are included in this throttler for their entire lifetime, not just
while waiting for dispatch).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
