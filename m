From: sridhar basam <sri@basam.org>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/6] Understanding delays due to
 throttling under very heavy write load
Date: Fri, 10 Feb 2012 12:13:44 -0500
Message-ID: <CAGnVnBmv5HovMJjejKemJwjFrGOb77dnTqLpQzHtPFU4_nrvkg@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
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
	<CAF3hT9CW7_CF4iT0cY858kgkke7Wu=TK7ULzPhFj-AW9jycyZA@mail.gmail.com>
	<4F343239.2010907@sandia.gov>
	<CAGnVnB=beb2XMB55FfG7TgBeqa4gmb=O1S54=s+V6rANeoq3ug@mail.gmail.com>
	<4F3453A7.9000408@sandia.gov>
	<CAGnVnBm1hyXfk4Wnb57j3EYTwUwjSDYtHg_zPQ86B8vorgJ4Cw@mail.gmail.com>
	<4F35388B.4070601@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57052 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab2BJRNp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 12:13:45 -0500
Received: by vbjk17 with SMTP id k17so1920918vbj.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2012 09:13:45 -0800 (PST)
In-Reply-To: <4F35388B.4070601@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

On Fri, Feb 10, 2012 at 10:32 AM, Jim Schutt <jaschut@sandia.gov> wrote=
:
> On 02/09/2012 06:26 PM, sridhar basam wrote:
>>
>> Do you mind capturing to a pcap file and providing that. Makes it
>> easier to analyse things. If not, i understand. If you can make do t=
he
>> capture on both ends, do it with a snaplen of 68 so that you get all
>> of the headers and there shouldn't be too much payload information i=
n
>> the file.
>
>
> I've got a pcap file for this run for this client, with snaplen 128
> (I thought I might need to look for ceph message headers). =A0It's 13=
 MB
> compressed. =A0How shall I get it to you?
>

Can i grab it off some webserver you control? Or you can temporarily
drop it into docs.google.com and add accesss from my email account?

> In the meantime, I'll try to capture this from both sides.
>
>
>>
>> I will take a look at the additional output and see if anything pops
>> out. I am assuming the below output was immediately after what you
>> posted in your earlier email.

i don't see anything out of the ordinary once things recover, the
sender even starts to do TSO after a short while.

 Sridhar


>
>
> Yes.
>
> Thanks -- Jim
>
>
>>
>>
>> =A0Sridhar
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
