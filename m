From: Jaze Lee <jazeltq@gmail.com>
Subject: Only client.admin can mount cephfs by ceph-fuse
Date: Mon, 2 Nov 2015 12:28:42 +0800
Message-ID: <CAKZcxgeKr4m=Yvj4nyzwzkot8gS-dLip6qyx5fX4S+hbvpkXoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34239 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbbKBE2n convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Nov 2015 23:28:43 -0500
Received: by lfgh9 with SMTP id h9so9711159lfg.1
        for <ceph-devel@vger.kernel.org>; Sun, 01 Nov 2015 20:28:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,
   I find only ceph.client.admin can mount cephfs.

[root@ceph-base-0 ceph]# ceph auth get client.cephfs_user
exported keyring for client.cephfs_user
[client.cephfs_user]
key =3D AQDZ3DZWR7nqBxAAzSoU/yRz1oJsOYdYrTAzcw=3D=3D
caps mds =3D "allow *"
caps mon =3D "allow *"
caps osd =3D "allow *"

[root@cephfs-client ~]# cat ceph.client.cephfs_user
[client.cephfs_user]
key =3D AQDZ3DZWR7nqBxAAzSoU/yRz1oJsOYdYrTAzcw=3D=3D

But when i mount fuse, it throw an exception.
[root@cephfs-client ~]# ceph-fuse -k ceph.client.cephfs_user -m
10.12.12.10:6789 -m 10.12.12.6:6789 -m 10.12.12.5:6789 ./test_ceph_fs
2015-11-02 12:23:17.938470 7f9d63f9b760 -1 did not load config file,
using default settings.
ceph-fuse[15325]: starting ceph client
2015-11-02 12:23:17.973134 7f9d63f9b760 -1 init, newargv =3D 0x2c33f30 =
newargc=3D11
ceph-fuse[15325]: ceph mount failed with (1) Operation not permitted
ceph-fuse[15323]: mount failed: (1) Operation not permitted

But when i use client.admin
[root@ceph-base-0 ceph]# ceph auth get client.admin
exported keyring for client.admin
[client.admin]
key =3D AQCMrhxWhRFBBhAA+f1yZXyjzF2eBrUt1UMdFA=3D=3D
auid =3D 0
caps mds =3D "allow *"
caps mon =3D "allow *"
caps osd =3D "allow *"

[root@cephfs-client ~]# ceph-fuse -k ceph.client.admin.keyring -m
10.12.12.10:6789 -m 10.12.12.6:6789 -m 10.12.12.5:6789 ./test_ceph_fs
2015-11-02 12:25:03.038526 7f66e0957760 -1 did not load config file,
using default settings.
ceph-fuse[15360]: starting ceph client
2015-11-02 12:25:03.073797 7f66e0957760 -1 init, newargv =3D 0x3035f30 =
newargc=3D11
ceph-fuse[15360]: starting fuse

It is ok.

So i want to know.
Dose ceph's fuse only allow admin to mount fs?





--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
