From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: qemu : rbd block driver internal snapshot and
 vm_stop is hanging forever
Date: Mon, 9 Nov 2015 04:54:23 +0100 (CET)
Message-ID: <1561927996.3022026.1447041263817.JavaMail.zimbra@oxygem.tv>
References: <310812067.2785504.1447038645014.JavaMail.zimbra@oxygem.tv>
	<2016579078.2834222.1447039390275.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <2016579078.2834222.1447039390275.JavaMail.zimbra@oxygem.tv>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: ceph-devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-Id: ceph-devel.vger.kernel.org

Also,=20

this occur only with rbd_cache=3Dfalse or qemu drive cache=3Dnone.


If I use rbd_cache=3Dtrue or qemu drive cache=3Dwriteback, I don't have thi=
s bug.


----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>, "qemu-devel" <qemu-devel=
@nongnu.org>
Envoy=C3=A9: Lundi 9 Novembre 2015 04:23:10
Objet: Re: qemu : rbd block driver internal snapshot and vm_stop is hanging=
 forever

Some other infos:=20

I can reproduce it too with manual snapshot with rbd command=20


#rbd --image myrbdvolume snap create --snap snap1=20

qemu monitor:=20

#stop=20


This is with ceph hammer 0.94.5.=20


in qemu vm_stop, the only thing related to block driver are=20

bdrv_drain_all();=20
ret =3D bdrv_flush_all();=20


----- Mail original -----=20
De: "aderumier" <aderumier@odiso.com>=20
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>, "qemu-devel" <qemu-devel=
@nongnu.org>=20
Envoy=C3=A9: Lundi 9 Novembre 2015 04:10:45=20
Objet: qemu : rbd block driver internal snapshot and vm_stop is hanging for=
ever=20

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
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
