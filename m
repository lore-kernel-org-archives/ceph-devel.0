From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling
 under very heavy write load
Date: Mon, 6 Feb 2012 11:20:25 -0700
Message-ID: <4F3019E9.80607@sandia.gov>
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
 <4F2C08A7.2050507@sandia.gov> <3032884323297001561@unknownmsgid>
 <4F2C6EE6.4050008@sandia.gov>
 <CAC-hyiHSNv_VgLcyVCrJ66HxTGFNBONrmmBddJk5326dLTKgkw@mail.gmail.com>
 <4F2FFDD3.1010100@sandia.gov>
 <CAC-hyiEdAd++dQFBjPDutqipQcMXZqh4RdEEyA=v12vs6ueDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:37850 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab2BFSUy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2012 13:20:54 -0500
In-Reply-To: <CAC-hyiEdAd++dQFBjPDutqipQcMXZqh4RdEEyA=v12vs6ueDxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/06/2012 10:22 AM, Yehuda Sadeh Weinraub wrote:
> On Mon, Feb 6, 2012 at 8:20 AM, Jim Schutt<jaschut@sandia.gov>  wrote:

>>
>> The above suggests to me that the slowdown is a result
>> of requests not getting submitted at the same rate as
>> when things are running well.
>>
>
> Yeah, it really looks like that. My suggestions wouldn't help there.
>
> I do see that when things go well the number of writes per device is
> capped at ~200 writes per second and the throughput per device is
> ~100MB/sec. Is 100MB/sec the expected device throughput?

Pretty much, at least for the outer tracks on a drive.  I've seen
~108 MB/s with dd to a block device.  Also, I've got 8 drives per
SAS adapter with 6 Gb/s links, so it seems unlikely to me that my
disk subsystem is any sort of significant bottleneck.

-- Jim


