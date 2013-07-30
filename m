From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Negative degradation?
Date: Tue, 30 Jul 2013 14:07:12 +0100
Message-ID: <51F7BA80.4040800@cam.ac.uk>
References: <CAN04cT7aidUFqHLPhQcT6s-A51KMQxY8hVNoOBYT9aobxTmjAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:57335 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab3G3NHO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 09:07:14 -0400
In-Reply-To: <CAN04cT7aidUFqHLPhQcT6s-A51KMQxY8hVNoOBYT9aobxTmjAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On 30/07/13 09:20, Roald van Loon wrote:
> Came across it this morning when booting my development environment,
> has anyone seen this before?
>=20
> It's with 0.67-rc2;
>=20
> 2013-07-30 08:09:09.230349 mon.0 [INF] pgmap v4172: 1216 pgs: 123
> active, 219 active+clean, 161 active+clean+replay, 713 peering; 241 M=
B
> data, 630 MB used, 5483 MB / 6114 MB avail; -2/588 degraded (-0.340%)

I saw similar negative values when updating my test OSD host to 0.67-rc=
2
from 0.66 this morning; however, I've seen such negative values being
reported at various times over a number of past releases.

I suspect there's a defect in signed-ness handling somewhere, or simila=
r
=E2=80=94 however, it appears to be cosmetic and disappears when the OS=
D replay
completes.

(I've likewise seen impossible values for other statistics being
reported =E2=80=94 a while back I saw multiple EBs being reported as be=
ing
read/written during a resync between 4 disks, for example.  I suspect
this is another manifestation of a similar problem.)

Cheers,
David
--=20
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Computing Service
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
