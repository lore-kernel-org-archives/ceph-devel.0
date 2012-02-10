From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/6] Understanding delays due to
 throttling under very heavy write load
Date: Fri, 10 Feb 2012 08:32:27 -0700
Message-ID: <4F35388B.4070601@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
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
 <4F3019E9.80607@sandia.gov>
 <CAF3hT9CW7_CF4iT0cY858kgkke7Wu=TK7ULzPhFj-AW9jycyZA@mail.gmail.com>
 <4F343239.2010907@sandia.gov>
 <CAGnVnB=beb2XMB55FfG7TgBeqa4gmb=O1S54=s+V6rANeoq3ug@mail.gmail.com>
 <4F3453A7.9000408@sandia.gov>
 <CAGnVnBm1hyXfk4Wnb57j3EYTwUwjSDYtHg_zPQ86B8vorgJ4Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:35040 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab2BJPcy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 10:32:54 -0500
In-Reply-To: <CAGnVnBm1hyXfk4Wnb57j3EYTwUwjSDYtHg_zPQ86B8vorgJ4Cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sridhar basam <sri@basam.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/09/2012 06:26 PM, sridhar basam wrote:
> Do you mind capturing to a pcap file and providing that. Makes it
> easier to analyse things. If not, i understand. If you can make do the
> capture on both ends, do it with a snaplen of 68 so that you get all
> of the headers and there shouldn't be too much payload information in
> the file.

I've got a pcap file for this run for this client, with snaplen 128
(I thought I might need to look for ceph message headers).  It's 13 MB
compressed.  How shall I get it to you?

In the meantime, I'll try to capture this from both sides.

>
> I will take a look at the additional output and see if anything pops
> out. I am assuming the below output was immediately after what you
> posted in your earlier email.

Yes.

Thanks -- Jim

>
>
>   Sridhar
>


