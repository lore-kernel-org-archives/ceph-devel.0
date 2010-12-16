From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Errors on compiling master-backport of ceph-client-standalone
Date: Thu, 16 Dec 2010 15:56:32 +0800
Message-ID: <1292486192.2484.42.camel@cephhost>
References: <AANLkTinJW=QHXpsq1K_arYW5goARdPV15UTpEi6hYz51@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:41870 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753679Ab0LPHyr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 02:54:47 -0500
In-Reply-To: <AANLkTinJW=QHXpsq1K_arYW5goARdPV15UTpEi6hYz51@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



=E5=9C=A8 2010-12-16=E5=9B=9B=E7=9A=84 15:39 +0800=EF=BC=8CHenry C Chan=
g=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> Just tried to compile master-backport of ceph-client-standalone and g=
ot errors.
> I did two modifications to fix the errors:
>=20
> 1. include <linux/smp_lock.h> in ceph/mds_client.c for lock_kernel()
> 2. Revert commit "convert ceph"
> (ff8a8d2006dca58f71b5dc5df0c95b8f837a0a4e) because mount operation
> does not exist before 2.6.37.
I also compiled fail for ceph-client-standalone : master &&
master-backport.
 LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 36),
struct file_system_type added  "mount".

---------
static struct file_system_type ceph_fs_type =3D {
        .owner          =3D THIS_MODULE,
         .name           =3D "ceph",
         .mount          =3D ceph_mount,
         .kill_sb        =3D ceph_kill_sb,
         .fs_flags       =3D FS_RENAME_DOES_D_MOVE,
};
=20



>=20
> Henry
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
