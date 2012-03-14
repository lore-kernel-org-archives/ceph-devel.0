From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: ls -l not listing file attributes inside ceph directory
Date: Wed, 14 Mar 2012 04:22:22 +0000 (UTC)
Message-ID: <loom.20120314T052053-42@post.gmane.org>
References: <loom.20120313T100729-291@post.gmane.org> <CAORUGqCdDzaeAw61AJo5=BzYoAsmqd4FZp0wVxBw-w24iyNG8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39748 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab2CNEZE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Mar 2012 00:25:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7fln-0000tL-Lj
	for ceph-devel@vger.kernel.org; Wed, 14 Mar 2012 05:25:03 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 05:25:03 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 05:25:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Tommi Virtanen <tommi.virtanen <at> dreamhost.com> writes:

>=20
> On Tue, Mar 13, 2012 at 02:13, madhusudhana
> <madhusudhana.u.acharya <at> gmail.com> wrote:
> > Hi all
> > When I run ls -l command inside a folder coming from ceph cluster,
> > sometime it will not list file properties. when I run again, it
> > will list for some files and not for some. Any idea why this happen=
s ?
> >
> >
> > [root <at> ceph-node-9 test35]# ll
> > total 0
> > ?--------- =C2=A0? ? =C2=A0 =C2=A0 =C2=A0? =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? a=
rrays
>=20
> Is that with the kernel client or FUSE?
>=20
> What's the version number of Ceph?
>=20
> What's the kernel version on the client?

its kernel client. I mounted using mount -t ceph

ceph version :
[root@ceph-node-1 tmp]# ceph -v
ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d

kernel version in client:
[root@ceph-node-9 ~]# uname -a
Linux ceph-node-9 3.0.9 #3 SMP Tue Feb 21 16:59:41 IST 2012 x86_64 x86_=
64 x86_64=20
GNU/Linux



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
