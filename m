From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: qemu : rbd block driver internal snapshot and vm_stop is
 hanging forever
Date: Mon, 9 Nov 2015 04:23:10 +0100 (CET)
Message-ID: <2016579078.2834222.1447039390275.JavaMail.zimbra@oxygem.tv>
References: <310812067.2785504.1447038645014.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:44657 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbbKIDXM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Nov 2015 22:23:12 -0500
In-Reply-To: <310812067.2785504.1447038645014.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>

Some other infos:

I can reproduce it too with manual snapshot with rbd command


#rbd --image myrbdvolume snap create --snap snap1

qemu monitor:

#stop


This is with ceph hammer 0.94.5.


in qemu vm_stop, the only thing related to block driver are

    bdrv_drain_all();
    ret =3D bdrv_flush_all();


----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>, "qemu-devel" <qemu-d=
evel@nongnu.org>
Envoy=C3=A9: Lundi 9 Novembre 2015 04:10:45
Objet: qemu : rbd block driver internal snapshot and vm_stop is hanging=
 forever

Hi,=20

with qemu (2.4.1), if I do an internal snapshot of an rbd device,=20
then I pause the vm with vm_stop,=20

the qemu process is hanging forever=20


monitor commands to reproduce:=20


# snapshot_blkdev_internal drive-virtio0 yoursnapname=20
# stop=20




I don't see this with qcow2 or sheepdog block driver for example.=20


Regards,=20

Alexandre=20
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
