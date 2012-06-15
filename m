From: Sage Weil <sage@inktank.com>
Subject: Re: MDS spinning wild after restart on all nodes
Date: Fri, 15 Jun 2012 09:44:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206150940460.4551@cobra.newdream.net>
References: <201206151143.25706.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1302635301-1339778663=:4551"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44078 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2FOQo0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 12:44:26 -0400
In-Reply-To: <201206151143.25706.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1302635301-1339778663=:4551
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 15 Jun 2012, Amon Ott wrote:
> Hello all,
>=20
> I have seen this for a long time, but never investigated further. After s=
table=20
> test runs for several days, this is our last known show stopper before us=
ing=20
> Ceph in production. We are running 0.47.2 on 32 Bit.
>=20
> If we restart MDS (or all ceph daemons) on all nodes, one after another o=
r all=20
> together, they first recover and then the active one starts to spin with =
full=20
> cpu and does not answer any more. After a while, the next takes over, sta=
rts=20
> to spin, etc., until the whole cluster is unusable. This is completely=20
> reproducable and happens even without any active client.
>=20
> As ecpected, ceph -w shows lots of
> "2012-06-15 11:35:28.588775   mds e959: 1/1/1 up {0=3D3=3Dup:active(laggy=
 or=20
> crashed)}"
>=20
> It does not help to stop all services on all nodes for minutes or longer =
and=20
> to restart them - MDS will restart spinning. But: If we reboot the whole=
=20
> cluster, everything goes back to work.
>=20
> Today's MDS log is available at=20
> https://download.m-privacy.de/homeuser-mds.0.log.gz
>=20
> Is this a known problem? It has been with us for a looong time now, but s=
ince=20
> rebooting used to help, we never tracked it down.

I haven't seen this before.  Can you attach to the spinning process with=20
gdb and send us a dump of what the threads are doing?  'thread apply all=20
bt'.  I opened #2596:

=09http://tracker.newdream.net/issues/2596

Thanks!
sage




>=20
> Amon Ott
> --=20
> Dr. Amon Ott
> m-privacy GmbH           Tel: +49 30 24342334
> Am K=F6llnischen Park 1    Fax: +49 30 24342336
> 10179 Berlin             http://www.m-privacy.de
>=20
> Amtsgericht Charlottenburg, HRB 84946
>=20
> Gesch=E4ftsf=FChrer:
>  Dipl.-Kfm. Holger Maczkowsky,
>  Roman Maczkowsky
>=20
> GnuPG-Key-ID: 0x2DD3A649
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1302635301-1339778663=:4551--
