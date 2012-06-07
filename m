From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: setting up virtual machines with ceph
Date: Thu, 07 Jun 2012 09:05:10 +0200 (CEST)
Message-ID: <bc51cfa5-48ae-4747-a61b-0f636fed04d1@mailpro>
References: <loom.20120607T085432-245@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:40526 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2FGHFc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 03:05:32 -0400
In-Reply-To: <loom.20120607T085432-245@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,=20
if you want the easy way,
I have done integration of rbd in proxmox 2.0 kvm distribution (current=
ly in proxmox testing repos).

you only need mon and osd, as kvm only use rbd and not ceph filesystem.


I think,you could also use libvirt, but you need to have a qemu-kvm pac=
kage with librbd support


- Alexandre

----- Mail original -----=20

De: "udit agarwal" <fzdudit@gmail.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Jeudi 7 Juin 2012 08:56:58=20
Objet: setting up virtual machines with ceph=20

Hi,=20
I have set up ceph system with a client, mon and mds on one system whic=
h is=20
connected to 2 osds. . The ceph setup worked fine and I did some tests =
on it and=20
they too worked fine. Now, I want to set up virtual machines on my syst=
em and=20
want to run multiple virtual machine instances in parallel . But I don=E2=
=80=99t know=20
about what are the exact installation steps that are needed to be done =
after the=20
ceph installation. I guess I need to install rdb and kvm to achieve the=
 same.=20
Please correct me if I am wrong.=20



Can anyone help me in this matter.=20

Thanks in advance.=20

--Udit Agarwal=20


--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
