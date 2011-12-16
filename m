From: =?UTF-8?B?SmVucyBSZWhww7ZobGVy?= <jens.rehpoehler@filoo.de>
Subject: Re: ceph -w output
Date: Fri, 16 Dec 2011 12:14:27 +0100
Message-ID: <4EEB2813.6060109@filoo.de>
References: <4EE654A3.1040309@filoo.de> <CACLRD_3n6rCJNFVgmWesDjP3P7DY0bfZr_XGTtx9MC=r29uYRg@mail.gmail.com> <4EE8601F.90206@filoo.de> <CAORUGqB4ebxyumBdAjA=HcPyPhznfaFX43seoiNQVi32Rs8onw@mail.gmail.com> <4EE9C1AB.2010403@filoo.de> <CACLRD_3v3t-6nrkEGjiKgpcy-ou_4FpSiRTYA_-tJiguV=dvEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:55128 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab1LPLOb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 06:14:31 -0500
In-Reply-To: <CACLRD_3v3t-6nrkEGjiKgpcy-ou_4FpSiRTYA_-tJiguV=dvEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Sam,

thanks for the answers.

We began with osd3 und osd4 for internal reasons. osd1 to 3 will be
addes in near future.

I will wait until the patch is in the stables branch.

Thanks again

Jens


Am 15.12.2011 18:35, schrieb Samuel Just:
> Sorry for the delay.  It looks like you hit a corner case in our crus=
h
> implementation.  The short version is that this bug got fixed last
> week in commit 14f8f00e579083db542568a60cd23d50055c92a3.
>
> The long version is that you have osd.3 and osd.4, but not osd.0,
> osd.1, or osd.2.  The pgs stuck in creating are the ones mapped
> specifically to osds 0, 1, and 2.  A pg ending in p# (like pg1.0p0) i=
s
> supposed to map to osd.0 if possible.  With the above patch, those pg=
s
> should remap to available osds.
>
> -Sam
>
> On Thu, Dec 15, 2011 at 1:45 AM, Jens Rehp=C3=B6hler
> <jens.rehpoehler@filoo.de> wrote:
>> Am 14.12.2011 17:43, schrieb Tommi Virtanen:
>>> On Wed, Dec 14, 2011 at 00:36, Jens Rehp=C3=B6hler <jens.rehpoehler=
@filoo.de> wrote:
>>>> Attached you will find the output you asked for. Is there any limi=
tation
>>>> on the amount of pools ? We create
>>>> pools for every customer and store their VM images in that pools. =
So we
>>>> will create a lot of pools over time.
>>> Each pool gets its own set of PGs (Placement Groups). An OSD that
>>> manages too many PGs will use a lot of RAM. What is "too many" is
>>> debatable, and really up to benchmarks, but considering we recommen=
d
>>> about 100 PGs/OSD as a starting point, you probably don't want to g=
o
>>> two orders of magnitude above that.
>> Ok .... that will serve our needs. Remains only the "creating" quest=
ion.
>>
>> Any answers to that ?
>>
>> Thanks a lot !
>>
>> Jens
>>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
