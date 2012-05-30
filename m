From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 08:29:02 +0200
Message-ID: <4FC5BE2E.3080900@profihost.ag>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag> <4FC50C4A.4090101@inktank.com> <4FC53AC4.5020600@profihost.ag> <4FC54020.8040603@univ-nantes.fr> <4FC540DA.2050601@profihost.ag> <4FC5436D.3090606@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42424 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab2E3G26 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 02:28:58 -0400
In-Reply-To: <4FC5436D.3090606@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

Am 29.05.2012 23:45, schrieb Yann Dupont:
> Le 29/05/2012 23:34, Stefan Priebe a =C3=A9crit :
>> Am 29.05.2012 23:31, schrieb Yann Dupont:
>>> on the contrary, pool data is jumping up & down, no matter how much
>>> thread involved :)
>>>
>>> Maybe this is because journal is too tight ? Or because 2 of the 8 =
nodes
>>> have slower disks ?
>> Can you try with 3.0.X? I would be really interested what happens in
>> this case.
>>
>> Stefan
> hum...
> probably not directly. Older btrfs won't like big metadata, I think.
> This is quite a recent feature.
That's absolutely correct. If you test 3.0.X i think its better to use
XFS. I'm just interested if the problem we both see is gone for you too
with 3.0.X.

> I'll take the latest 3.0 kernel - or do you have a particular 3.0 ker=
nel
> version to test ?
I've used the latest 3.0.X stable (.32 right now)

> And Do you want a particular xfs/btrfs format ?
mkfs.xfs is enough ;-)

Thanks!

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
