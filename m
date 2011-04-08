From: Wido den Hollander <wido@widodh.nl>
Subject: RE: PGs Degraded
Date: Fri, 08 Apr 2011 22:14:25 +0200
Message-ID: <1302293665.1597.2.camel@Nokia-N900-02-8>
References: <B828A4C02BE12543ACDFCF7EB0C693C6788452CCA2@NC-SVR-09.netelligent.com>
	 <1302287897.2444.4.camel@wido-laptop.pcextreme.nl>
	  <B828A4C02BE12543ACDFCF7EB0C693C6788452CCBA@NC-SVR-09.netelligent.com>
Reply-To: Wido den Hollander <wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48795 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757779Ab1DHUP6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2011 16:15:58 -0400
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C6788452CCBA@NC-SVR-09.netelligent.com>
Content-ID: <1302293665.1597.1.camel@Nokia-N900-02-8>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: ceph-devel@vger.kernel.org

Hi,
----- Original message -----
> Here is the output from ceph osd dump -o -
>=20
> epoch 19
> fsid c2ae7ab2-d1b2-a467-be6e-f9a0031840f5
> created 2011-04-04 13:27:06.857950
> modifed 2011-04-08 14:11:05.899596
> flags
>=20
> pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash
> rjenkins pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 owne=
r
> 0) pg_pool 1 'metadata' pg_pool(rep pg_size 2 crush_ruleset 1
> object_hash rjenkins pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2
> last_change 1 owner 0) pg_pool 2 'casdata' pg_pool(rep pg_size 2
> crush_ruleset 2 object_hash rjenkins pg_num 64 pgp_num 64 lpg_num 2
> lpgp_num 2 last_change 1 owner 0) pg_pool 3 'rbd' pg_pool(rep pg_size=
 2
> crush_ruleset 3 object_hash rjenkins pg_num 64 pgp_num 64 lpg_num 2
> lpgp_num 2 last_change 1 owner 0)
>=20
> max_osd 6

Did you change the max_osd yourself? The replication size seem correct.

> I have not removed any OSDs from the cluster. I created the cluster w=
ith
> a single mds/mon and they have been adding osd slowly.

Did you start with one osd initially? Did you add the new OSD's to the =
crushmap after adding them to the cluster.

Wido

>=20
> Mark Nigh
> Systems Architect
> mnigh@netelligent.com
>=C2=A0  (p) 314.392.6926
>=20
>=20
>=20
> -----Original Message-----
> From: Wido den Hollander [mailto:wido@widodh.nl]
> Sent: Friday, April 08, 2011 1:38 PM
> To: Mark Nigh
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: PGs Degraded
>=20
> Hi Mark,
>=20
> On Fri, 2011-04-08 at 12:09 -0500, Mark Nigh wrote:
> > I have recently built a ceph cluster with the following nodes:
> >=20
> > 2011-04-08 11:54:08.038841=C2=A0 =C2=A0 =C2=A0  pg v3661: 264 pgs: =
264
> > active+clean+degraded; 9079 MB data, 9234 MB used, 811 GB / 820 GB
> > avail; 2319/4638 degraded (50.000%) 2011-04-08 11:54:08.039492=C2=A0=
 =C2=A0  mds
> > e17: 2/2/2 up {0=3Dup:active,1=3Dup:active} 2011-04-08 11:54:08.039=
529=C2=A0 =20
> > osd e18: 4 osds: 4 up, 4 in 2011-04-08 11:54:08.039592=C2=A0 =C2=A0=
  log
> > 2011-04-08 10:08:09.135994 mds0 10.6.1.90:6800/16761 4 : [INF] clos=
ing
> > stale session client4142 10.6.1.62:0/667143763 after 304.524869
> > 2011-04-08 11:54:08.039673=C2=A0 =C2=A0  mon e1: 1 mons at {0=3D10.=
6.1.90:6789/0}
> >=20
>=20
> That seems odd, your=C2=A0  "data" is only 200MB less then "used". Wh=
at is the
> replication size for the "data" and "metadata" pool?
>=20
> $ ceph osd dump -o - (rep pg_size)
>=20
> > I have a few files in the cluster (not much data) but have noticed
> > from the beginning of the build (after the 2 osd) that some of my P=
Gs
> > are degraded.
> >=20
> > How do I fix this and is there a tool/command to assist in determin=
ing
> > what PGs are degraded?
>=20
> You can view your degraded pg's with:
>=20
> $ ceph pg dump -o -
>=20
> This will tell you the degraded PG's and on which OSD's they are.
>=20
> Did you remove any OSD's from this cluster? It seems very odd that th=
e
> cluster is in a 50% degraded state.
>=20
> Wido
>=20
> >=20
> > Ceph -v is as follows:
> >=20
> > ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
> >=20
> > I appreciate the help.
> >=20
> > Mark Nigh
> >=20
> > This transmission and any attached files are privileged, confidenti=
al
> > or otherwise the exclusive property of the intended recipient or
> > Netelligent Corporation. If you are not the intended recipient, any
> > disclosure, copying, distribution or use of any of the information
> > contained in or attached to this transmission is strictly prohibite=
d.
> > If you have received this transmission in error, please contact us
> > immediately by responding to this message or by telephone
> > (314-392-6900) and promptly destroy the original transmission and i=
ts
> > attachments. -- To unsubscribe from this list: send the line
> > "unsubscribe ceph-devel" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at=20
> > http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> This transmission and any attached files are privileged, confidential=
 or
> otherwise the exclusive property of the intended recipient or
> Netelligent Corporation. If you are not the intended recipient, any
> disclosure, copying, distribution or use of any of the information
> contained in or attached to this transmission is strictly prohibited.=
 If
> you have received this transmission in error, please contact us
> immediately by responding to this message or by telephone (314-392-69=
00)
> and promptly destroy the original transmission and its attachments.
> NrybX=C7=A7v^)=DE=BA{.n+z]z{ay=1D=CA=87=DA=99,jfhz=1Ew j:+vwjmzZ+=DD=A2=
j"!

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
