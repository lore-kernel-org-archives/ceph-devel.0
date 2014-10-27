From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Mon, 27 Oct 2014 08:53:35 +0100 (CET)
Message-ID: <72547b0d-973c-4df7-834d-2e581007ac91@mailpro>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282365C1@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:35942 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbaJ0Hxn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 03:53:43 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282365C1@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>

>>Have you tried mapping different images on the same m/c with 'noshare=
' map option ?

Oh, I didn't known about his option.

I found 1 reference here:

http://lists.ceph.com/pipermail/ceph-users-ceph.com/2013-September/0342=
13.html

"With noshare each mapped image will appear as a separate client instan=
ce,=20
which means it will have it's own session with teh monitors and own TCP=
=20
connections to the OSDs.  It may be a viable workaround for now but in=20
general I would not recommend it."

So it should help with multiple rbd.
Do you known why Sage don't recommend it in this mail ?





----- Mail original -----=20

De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, "Christoph Hellwig"=
 <hch@infradead.org>=20
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Dimanche 26 Octobre 2014 20:08:42=20
Objet: RE: krbd blk-mq support ?=20

Alexandre,=20
Have you tried mapping different images on the same m/c with 'noshare' =
map option ?=20
If not, it will not scale with increasing number of images (and thus ma=
pped rbds) on a single m/c as they will share the same connection to cl=
uster.=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER=20
Sent: Sunday, October 26, 2014 6:46 AM=20
To: Christoph Hellwig=20
Cc: Ceph Devel=20
Subject: Re: krbd blk-mq support ?=20

Hi,=20

some news:=20

I have applied patches succefully on top of 3.18-rc1 kernel.=20

But don't seem to help is my case.=20
(I think that blk-mq is working because I don't see any io schedulers o=
n rbd devices, as blk-mq don't support them actually).=20

My main problem is that I can't reach more than around 50000iops on 1 m=
achine,=20

and the problem seem to be the kworker process stuck at 100% of 1core.=20

I had tried multiple fio process, on differents rbd devices at the same=
 time, and I'm always limited =C3=A0 50000iops.=20

I'm sure that the ceph cluster is not the bottleneck, because if I laun=
ch another fio on another node at the same time,=20

I can reach 50000iops on each node, and both are limited by the kworker=
 process.=20


That's why I thinked that blk-mq could help, but it don't seem to be th=
e case.=20


Is this kworker cpu limitation a known bug ?=20

Regards,=20

Alexandre=20

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

If you're willing to experiment give the patches below a try, not that =
I don't have a ceph test cluster available, so the conversion is untest=
ested.=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
