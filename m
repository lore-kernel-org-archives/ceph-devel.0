From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Designing a cluster guide
Date: Tue, 22 May 2012 08:20:59 +0200
Message-ID: <4FBB304B.2050709@profihost.ag>
References: <4FABAFE9.5060202@profihost.ag>	<4FABC15C.3030500@profihost.ag>	<CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>	<4FB75BAD.3080709@profihost.ag> <CAPYLRzj8Ozv_L1FSONbR0Kovn_hdXz9YN5bXnAskgdv0s4COvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40085 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab2EVGU5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 02:20:57 -0400
In-Reply-To: <CAPYLRzj8Ozv_L1FSONbR0Kovn_hdXz9YN5bXnAskgdv0s4COvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 21.05.2012 20:13, schrieb Gregory Farnum:
> On Sat, May 19, 2012 at 1:37 AM, Stefan Priebe <s.priebe@profihost.ag=
> wrote:
>> So would you recommand a fast (more ghz) Core i3 instead of a single=
 xeon
>> for this system? (price per ghz is better).
>=20
> If that's all the MDS is doing there, probably? (It would also depend
> on cache sizes and things; I don't have a good sense for how that
> impacts the MDS' performance.)
As i'm only using KVM / rbd i don't have any MDS.

> Well, RAID1 isn't going to make it any faster than just the single
> SSD, is why I pointed that out.
>
> I wouldn't recommend using a ramdisk for the journal =97 that will
> guarantee local data loss in the event the server doesn't shut down
> properly, and if it happens to several servers at once you get a good
> chance of losing client writes.
Sure but it's the same WHEN NOT using a Raid 1 for the journal isn't it=
?

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
