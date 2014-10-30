From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Thu, 30 Oct 2014 09:11:11 +0100 (CET)
Message-ID: <4c95e688-d8cd-42b4-b414-535764fb80fc@mailpro>
References: <alpine.DEB.2.00.1410290800080.13498@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50990 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758216AbaJ3ILT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 04:11:19 -0400
In-Reply-To: <alpine.DEB.2.00.1410290800080.13498@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christoph Hellwig <hch@infradead.org>, Ceph Devel <ceph-devel@vger.kernel.org>

>>Hmm, this is probably the messenger.c worker then that is feeding mes=
sages=20
>>to the network. How many OSDs do you have? It should be able to scale=
=20
>>with the number of OSDs.=20

Thanks Sage for your reply.

Currently 6 OSD (ssd) on the test platform.

But I can reach 2x 50000iops on same rbd volume with 2 clients on 2 dif=
ferents host.
Do you think messenger.c worker can be the bottleneck in this case ?


I'll try to add more OSD next week, if it's scale it's a very good news=
 !







----- Mail original -----=20

De: "Sage Weil" <sage@newdream.net>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Christoph Hellwig" <hch@infradead.org>, "Ceph Devel" <ceph-devel@v=
ger.kernel.org>=20
Envoy=C3=A9: Mercredi 29 Octobre 2014 16:00:56=20
Objet: Re: krbd blk-mq support ?=20

On Wed, 29 Oct 2014, Alexandre DERUMIER wrote:=20
> >>Oh, that's without the blk-mq patch?=20
>=20
> Yes, sorry, I don't how to use perf with a custom compiled kernel.=20
> (Usualy I'm using perf from debian, with linux-tools package provided=
 with the debian kernel package)=20
>=20
> >>Either way the profile doesn't really sum up to a fully used up cpu=
=2E=20
>=20
> But I see mostly same behaviour with or without blk-mq patch, I have =
always 1 kworker at around 97-100%cpu (1core) for 50000iops.=20
>=20
> I had also tried to map the rbd volume with nocrc, it's going to 6000=
0iops with same kworker at around 97-100%cpu=20

Hmm, this is probably the messenger.c worker then that is feeding messa=
ges=20
to the network. How many OSDs do you have? It should be able to scale=20
with the number of OSDs.=20

sage=20


>=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Christoph Hellwig" <hch@infradead.org>=20
> ?: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
> Envoy?: Mardi 28 Octobre 2014 19:07:25=20
> Objet: Re: krbd blk-mq support ?=20
>=20
> On Mon, Oct 27, 2014 at 11:00:46AM +0100, Alexandre DERUMIER wrote:=20
> > >>Can you do a perf report -ag and then a perf report to see where =
these=20
> > >>cycles are spent?=20
> >=20
> > Yes, sure.=20
> >=20
> > I have attached the perf report to this mail.=20
> > (This is with kernel 3.14, don't have access to my 3.18 host for no=
w)=20
>=20
> Oh, that's without the blk-mq patch?=20
>=20
> Either way the profile doesn't really sum up to a fully used up=20
> cpu. Sage, Alex - are there any ordring constraints in the rbd client=
?=20
> If not we could probably aim for per-cpu queues using blk-mq and a=20
> socket per cpu or similar.=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
