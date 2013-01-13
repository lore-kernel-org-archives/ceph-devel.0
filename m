From: =?iso-8859-1?Q?Harald_R=F6=DFler?= <Harald.Roessler@btd.de>
Subject: Re: rbd kernel driver on the osd server
Date: Sun, 13 Jan 2013 19:46:15 +0100
Message-ID: <20130113184615.GG27442@hro-mlt-02.local>
References: <20130113160840.GF27442@hro-mlt-02.local>
 <50F2F632.6060402@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from odm-dns-01.odmedia.net ([87.238.139.200]:33156 "EHLO
	odm-dns-01.odmedia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab3AMSqS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Jan 2013 13:46:18 -0500
In-Reply-To: <50F2F632.6060402@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>    Hi,
>=20
>    On 01/13/2013 05:08 PM, Harald R=F6=DFler wrote:
>    > Hi,
>    >
>    > couple of month ago I read about a limitation to run an RBD kern=
el
>    driver on the osd server. Is this limitation still valid? The reas=
on in
>    Ubuntu and Debian there is no support for the RBD devices in QEMU.=
 At the
>    moment, in our setup  the KVM's are running on the OSD servers.
>    >
>=20
>    I don't think so, but somebody might correct me here.

I am the same opinion, but I was not sure, I found this information on =
some websites including in the "old" CEPH wiki and in the CEPH IRC logs=
=2E=20


>=20
>    The OSDs nowadays use syncfs which leads them to only syncing thei=
r
>    filesystem instead of ALL the filesystems on that host.
>=20
>    It might however be that Qemu calls sync() instead of syncfs() whi=
ch
>    still causes everything to be synced, which can lead to problems I=
 guess.

Thank you for this information, If I got it right, use the kernel drive=
r on the host system I can expect more performance than via QEMU. I wil=
l test it on our development system.

>=20
>    Regarding your reason for doing this, RBD is supported in Ubuntu's=
 Qemu.
>=20
>    Under Ubuntu precise it already works:
>    http://packages.ubuntu.com/precise/qemu-kvm
>=20
>    The problem is that the shipped version of Ceph is 0.41, which mig=
ht be
>    too old.
>=20
>    I've been following the Blueprint for Ubuntu 13.04 and that will h=
ave
>    all the Ceph stuff (Qemu and libvirt) you want with version 0.56.1

I will keep this in mind. Thanks!!

>=20
>    I'd look into that.
>=20
>    Wido
>=20
>    > Best Regards
>    > Harald Roessler
>    > --
>    > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>    > the body of a message to majordomo@vger.kernel.org
>    > More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>    >
>    --
>    To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>    the body of a message to majordomo@vger.kernel.org
>    More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best Regards
Harald Roessler
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
