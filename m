From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: qemu drive-mirror to rbd storage : no sparse rbd image
Date: Mon, 13 Oct 2014 10:08:51 +0200 (CEST)
Message-ID: <c5bbf8c8-6eb9-4cc9-836e-4f3f550e5bed@mailpro>
References: <543B79D9.2000806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:40315 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbaJMII7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 04:08:59 -0400
In-Reply-To: <543B79D9.2000806@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>

>>Ah, you're right.  We need to add an options field, or use a new
>>blockdev-mirror command.

Ok, thanks. Can't help to implement this, but I'll glad to help for tes=
ting.


----- Mail original -----=20

De: "Paolo Bonzini" <pbonzini@redhat.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>, "qemu-devel" <qemu-devel=
@nongnu.org>=20
Envoy=C3=A9: Lundi 13 Octobre 2014 09:06:01=20
Objet: Re: qemu drive-mirror to rbd storage : no sparse rbd image=20

Il 13/10/2014 08:06, Alexandre DERUMIER ha scritto:=20
>=20
> Also, about drive-mirror, I had tried with detect-zeroes with simple =
qcow2 file,=20
> and It don't seem to help.=20
> I'm not sure that detect-zeroes is implement in drive-mirror.=20
>=20
> also, the target mirrored volume don't seem to have the detect-zeroes=
 option=20
>=20
>=20
> # info block=20
> drive-virtio1: /source.qcow2 (qcow2)=20
> Detect zeroes: on=20
>=20
> #du -sh source.qcow2 : 2M=20
>=20
> drive-mirror source.qcow2 -> target.qcow2=20
>=20
> # info block=20
> drive-virtio1: /target.qcow2 (qcow2)=20
>=20
> #du -sh target.qcow2 : 11G=20
>=20

Ah, you're right. We need to add an options field, or use a new=20
blockdev-mirror command.=20

Paolo=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
