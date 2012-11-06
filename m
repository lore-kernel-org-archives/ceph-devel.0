From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: BUG: kvm crashing in void librbd::AioCompletion::complete_request
Date: Tue, 06 Nov 2012 10:07:00 +0100 (CET)
Message-ID: <3de2d3a8-8e11-4a68-9198-7f25bbf8fd49@mailpro>
References: <509824D9.60503@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50679 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab2KFJHb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 04:07:31 -0500
In-Reply-To: <509824D9.60503@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

>>Most mem get used while doing a lot of small reads.=20

I see same problem with my test and wip-rbd-read.

I got also strange fio results, from 5k to 100K iops (increase and incr=
ease in time during the bench).




----- Mail original -----=20

De: "Stefan Priebe" <s.priebe@profihost.ag>=20
=C3=80: "Sage Weil" <sage@inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 5 Novembre 2012 21:43:05=20
Objet: Re: BUG: kvm crashing in void librbd::AioCompletion::complete_re=
quest=20

Am 05.11.2012 20:33, schrieb Stefan Priebe:=20
> Am 04.11.2012 15:12, schrieb Sage Weil:=20
>> On Sun, 4 Nov 2012, Stefan Priebe wrote:=20
>>> Can i merge wip-rbd-read into master?=20
>>=20
>> Yeah. I'm going to do a bit more testing first before I do it, but i=
t=20
>> should apply cleanly. Hopefully later today.=20
>=20
> Thanks - seems to be fixed with wip-rbd-read but i have a memory leak=
 now.=20
>=20
> kvm process raises and raises and raises which each new test around 5=
GB=20
> of memory. Should i write a new mail?=20

Most mem get used while doing a lot of small reads.=20

Stefan=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
