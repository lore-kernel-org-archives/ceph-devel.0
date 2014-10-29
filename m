From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Wed, 29 Oct 2014 10:09:24 +0100 (CET)
Message-ID: <670b829a-8568-44fa-97a1-1ced59d408ad@mailpro>
References: <20141028180725.GA1138@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:60668 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944AbaJ2JJb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 05:09:31 -0400
In-Reply-To: <20141028180725.GA1138@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

>>Oh, that's without the blk-mq patch?

Yes, sorry, I don't how to use perf with a custom compiled kernel.
(Usualy I'm using perf from debian, with linux-tools package provided w=
ith the debian kernel package)

>>Either way the profile doesn't really sum up to a fully used up cpu.

But I see mostly same behaviour with or without blk-mq patch, I have al=
ways 1 kworker at around 97-100%cpu (1core) for 50000iops.

I had also tried to map the rbd volume with nocrc, it's going to 60000i=
ops with same kworker at around 97-100%cpu



----- Mail original -----=20

De: "Christoph Hellwig" <hch@infradead.org>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mardi 28 Octobre 2014 19:07:25=20
Objet: Re: krbd blk-mq support ?=20

On Mon, Oct 27, 2014 at 11:00:46AM +0100, Alexandre DERUMIER wrote:=20
> >>Can you do a perf report -ag and then a perf report to see where th=
ese=20
> >>cycles are spent?=20
>=20
> Yes, sure.=20
>=20
> I have attached the perf report to this mail.=20
> (This is with kernel 3.14, don't have access to my 3.18 host for now)=
=20

Oh, that's without the blk-mq patch?=20

Either way the profile doesn't really sum up to a fully used up=20
cpu. Sage, Alex - are there any ordring constraints in the rbd client?=20
If not we could probably aim for per-cpu queues using blk-mq and a=20
socket per cpu or similar.=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
