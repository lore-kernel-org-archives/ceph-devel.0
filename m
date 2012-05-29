From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 23:45:17 +0200
Message-ID: <4FC5436D.3090606@univ-nantes.fr>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag> <4FC50C4A.4090101@inktank.com> <4FC53AC4.5020600@profihost.ag> <4FC54020.8040603@univ-nantes.fr> <4FC540DA.2050601@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:43328 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751557Ab2E2VpW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 17:45:22 -0400
In-Reply-To: <4FC540DA.2050601@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

Le 29/05/2012 23:34, Stefan Priebe a =C3=A9crit :
> Am 29.05.2012 23:31, schrieb Yann Dupont:
>> on the contrary, pool data is jumping up & down, no matter how much
>> thread involved :)
>>
>> Maybe this is because journal is too tight ? Or because 2 of the 8 n=
odes
>> have slower disks ?
> Can you try with 3.0.X? I would be really interested what happens in=20
> this case.
>
> Stefan
hum...
probably not directly. Older btrfs won't like big metadata, I think.=20
This is quite a recent feature.

but as my ceph is not in production, I can stop it, use an older kernel=
=20
, format new volumes in btrfs or xfs, or whatever, and try.

It will be a totally fresh install then.

I can do that thursday.

Stefan, mark,
I'll take the latest 3.0 kernel - or do you have a particular 3.0 kerne=
l=20
version to test ?
And Do you want a particular xfs/btrfs format ?

cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
