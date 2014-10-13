From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: qemu drive-mirror to rbd storage : no sparse rbd image
Date: Mon, 13 Oct 2014 08:06:29 +0200 (CEST)
Message-ID: <9fe0fedc-802d-4838-b738-c3d0932eeeda@mailpro>
References: <543A7BD4.4030601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:36720 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaJMGGh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 02:06:37 -0400
In-Reply-To: <543A7BD4.4030601@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>

>>Lack of bdrv_co_write_zeroes is why detect-zeroes does not work.=20
>>
>>Lack of bdrv_get_block_status is why sparse->sparse does not work=20
>>without detect-zeroes.

Ok, thanks Paolo !

Both are missing in rbd block driver. @ceph-devel . Could it be possibl=
e to implement them ?



Also, about drive-mirror, I had tried with detect-zeroes with simple qc=
ow2 file,=20
and It don't seem to help.
I'm not sure that detect-zeroes is implement in drive-mirror.

also, the target mirrored volume don't seem to have the detect-zeroes o=
ption


# info block
drive-virtio1: /source.qcow2 (qcow2)
    Detect zeroes:    on

#du -sh source.qcow2 : 2M

drive-mirror  source.qcow2 -> target.qcow2

# info block
drive-virtio1: /target.qcow2 (qcow2)

#du -sh target.qcow2 : 11G




----- Mail original -----=20

De: "Paolo Bonzini" <pbonzini@redhat.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, "qemu-devel" <qemu-=
devel@nongnu.org>=20
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Dimanche 12 Octobre 2014 15:02:12=20
Objet: Re: qemu drive-mirror to rbd storage : no sparse rbd image=20

Il 08/10/2014 13:15, Alexandre DERUMIER ha scritto:=20
> Hi,=20
>=20
> I'm currently planning to migrate our storage to ceph/rbd through qem=
u drive-mirror=20
>=20
> and It seem that drive-mirror with rbd block driver, don't create a s=
parse image. (all zeros are copied to the target rbd).=20
>=20
> Also note, that it's working fine with "qemu-img convert" , the rbd v=
olume is sparse after conversion.=20
>=20
>=20
> Could it be related to the "bdrv_co_write_zeroes" missing features in=
 block/rbd.c ?=20
>=20
> (It's available in other block drivers (scsi,gluster,raw-aio) , and I=
 don't have this problem with theses block drivers).=20

Lack of bdrv_co_write_zeroes is why detect-zeroes does not work.=20

Lack of bdrv_get_block_status is why sparse->sparse does not work=20
without detect-zeroes.=20

Paolo=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
