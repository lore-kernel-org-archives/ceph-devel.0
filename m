From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Sun, 26 Oct 2014 14:46:03 +0100 (CET)
Message-ID: <42753caf-adc1-48f7-bc34-83ed48845061@mailpro>
References: <8dd75b6c-f026-466d-baa4-fa4d11f8800a@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38993 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbaJZNqK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Oct 2014 09:46:10 -0400
In-Reply-To: <8dd75b6c-f026-466d-baa4-fa4d11f8800a@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Hi,

some news:

I have applied patches succefully on top of 3.18-rc1 kernel.

But don't seem to help is my case.=20
(I think that blk-mq is working because I don't see any io schedulers o=
n rbd devices, as blk-mq don't support them actually).

My main problem is that I can't reach more than around 50000iops on 1 m=
achine,

and the problem seem to be the kworker process stuck at 100% of 1core.

I had tried multiple fio process, on differents rbd devices at the same=
 time, and I'm always limited =C3=A0 50000iops.

I'm sure that the ceph cluster is not the bottleneck, because if I laun=
ch another fio on another node at the same time,

I can reach 50000iops on each node, and both are limited by the kworker=
 process.


That's why I thinked that blk-mq could help, but it don't seem to be th=
e case.


Is this kworker cpu limitation a known bug ?

Regards,

Alexandre

----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Christoph Hellwig" <hch@infradead.org>=20
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Vendredi 24 Octobre 2014 14:27:47=20
Objet: Re: krbd blk-mq support ?=20

>>If you're willing to experiment give the patches below a try, not tha=
t=20
>>I don't have a ceph test cluster available, so the conversion is=20
>>untestested.=20

Ok, Thanks ! I'll try them and see If I can improve qemu performance on=
 a single drive with multiqueues.=20

----- Mail original -----=20

De: "Christoph Hellwig" <hch@infradead.org>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Vendredi 24 Octobre 2014 12:55:01=20
Objet: Re: krbd blk-mq support ?=20

If you're willing to experiment give the patches below a try, not that=20
I don't have a ceph test cluster available, so the conversion is=20
untestested.=20
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
