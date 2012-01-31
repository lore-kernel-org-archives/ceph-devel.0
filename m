From: madhusudhan <madhusudhana.u.acharya@gmail.com>
Subject: Re: Ceph behavior in case of network failure
Date: Tue, 31 Jan 2012 05:13:29 +0000 (UTC)
Message-ID: <loom.20120131T060749-554@post.gmane.org>
References: <loom.20120129T054836-318@post.gmane.org> <CAF3hT9A6JZPUdWxbeixdpbCQEuEZfDLzD4EvjASG0+6U3EV_Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59098 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2AaFNn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jan 2012 00:13:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Rs62G-0003ze-JP
	for ceph-devel@vger.kernel.org; Tue, 31 Jan 2012 06:13:40 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 06:13:40 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 06:13:40 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Gregory Farnum <gregory.farnum <at> dreamhost.com> writes:

>=20
> On Sat, Jan 28, 2012 at 8:52 PM, Madhusudhan
> <madhusudhana.u.acharya <at> gmail.com> wrote:
> > I have configured ceph in centos5.6 after a
> > very long fight. Now, i am in the way
> > to evaluate the Ceph. Forget me if my
> > question looks amateur. If we consider a
> > situation where my core switch fails,
> > resulting in n/w failure in entire data
> > center. What happens to ceph cluster ?
> > will it sustain this n/w failure and comes
> > online when the n/w is restored ?
>=20
> Hmmm. If your network breaks horribly, you will probably need to
> restart the daemons =E2=80=94=C2=A0once their communication breaks th=
ey'll start
> marking each other down and the monitors will probably accept those
> reports once the network starts working again. (Actually, maybe we
> should update that so the monitors reject sufficiently old reports.)
> But it will be a transient effect; restarting your machines will be
> enough to restore service. :)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
Thank you Greg for the reply. Do we have to start both osd/mon=20
deamons on all the nodes ? I one of the case, i rebooted my=20
osd node (when it wan running to check the fault tolerance)=20
and when it came online, its journal got corrupted. I had to=20
reinitialize the node by erasing all data in it. And rebooting
 the entire cluster (in case of n/w failure) doesn't seems to
 be a good idea for me as clients will start mounting the=20
cluster immediately and start writing or reading =20
from the cluster.=20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
