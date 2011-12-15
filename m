From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: ceph -w output
Date: Thu, 15 Dec 2011 09:35:24 -0800
Message-ID: <CACLRD_3v3t-6nrkEGjiKgpcy-ou_4FpSiRTYA_-tJiguV=dvEw@mail.gmail.com>
References: <4EE654A3.1040309@filoo.de>
	<CACLRD_3n6rCJNFVgmWesDjP3P7DY0bfZr_XGTtx9MC=r29uYRg@mail.gmail.com>
	<4EE8601F.90206@filoo.de>
	<CAORUGqB4ebxyumBdAjA=HcPyPhznfaFX43seoiNQVi32Rs8onw@mail.gmail.com>
	<4EE9C1AB.2010403@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42268 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758887Ab1LORfZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 12:35:25 -0500
Received: by wgbdr13 with SMTP id dr13so4419138wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2011 09:35:24 -0800 (PST)
In-Reply-To: <4EE9C1AB.2010403@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sorry for the delay.  It looks like you hit a corner case in our crush
implementation.  The short version is that this bug got fixed last
week in commit 14f8f00e579083db542568a60cd23d50055c92a3.

The long version is that you have osd.3 and osd.4, but not osd.0,
osd.1, or osd.2.  The pgs stuck in creating are the ones mapped
specifically to osds 0, 1, and 2.  A pg ending in p# (like pg1.0p0) is
supposed to map to osd.0 if possible.  With the above patch, those pgs
should remap to available osds.

-Sam

On Thu, Dec 15, 2011 at 1:45 AM, Jens Rehp=C3=B6hler
<jens.rehpoehler@filoo.de> wrote:
> Am 14.12.2011 17:43, schrieb Tommi Virtanen:
>> On Wed, Dec 14, 2011 at 00:36, Jens Rehp=C3=B6hler <jens.rehpoehler@=
filoo.de> wrote:
>>> Attached you will find the output you asked for. Is there any limit=
ation
>>> on the amount of pools ? We create
>>> pools for every customer and store their VM images in that pools. S=
o we
>>> will create a lot of pools over time.
>> Each pool gets its own set of PGs (Placement Groups). An OSD that
>> manages too many PGs will use a lot of RAM. What is "too many" is
>> debatable, and really up to benchmarks, but considering we recommend
>> about 100 PGs/OSD as a starting point, you probably don't want to go
>> two orders of magnitude above that.
> Ok .... that will serve our needs. Remains only the "creating" questi=
on.
>
> Any answers to that ?
>
> Thanks a lot !
>
> Jens
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
