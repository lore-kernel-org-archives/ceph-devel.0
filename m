From: Sage Weil <sage@newdream.net>
Subject: Re: osd heartbeat interval
Date: Tue, 27 Mar 2012 12:33:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203271232250.1271@cobra.newdream.net>
References: <20120327202744.4d062721.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-818980257-1332876832=:1271"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44194 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab2C0Td7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 15:33:59 -0400
In-Reply-To: <20120327202744.4d062721.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-818980257-1332876832=:1271
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Mar 2012, Cl=E1udio Martins wrote:
>=20
>  Hi,
>=20
>  While testing a cluster with 47 OSDs, we noticed that with that many
> OSDs there is considerable network traffic (around 2 Mbit/s), most of
> it apparently just from the OSD heartbeats alone (measured while no
> clients were generating I/O). Also, OSD CPU consumption was very
> measurable, constantly around 1~2% on a 3.2GHz Xeon CPU.
>=20
>  So we experimented by including
>=20
>  osd heartbeat interval =3D 10
>=20
>  on ceph.conf on all nodes and, as suspected, network traffic diminished
> and CPU usage from an idle OSD is not measurable on top anymore.
>=20
>  Since there is a considerable number of OSDs in this cluster, we think
> that even with a 10 sec heartbeat, detection of a down OSD by some
> other OSDs is likely to be reasonably quick. As a matter of fact we saw
> on the mon log that, when we stopped an OSD, it was flagged as "failed"
> by other OSDs in just a few seconds.
>=20
>  So, we would like to know the opinion of the list about increasing the
> heartbeat interval on large clusters (and perhaps suggesting that on
> the official documentation), namely if you think there might be some
> negative consequences that we haven't foreseen.

A long time ago the heatbeats were also exchanging load information that=20
was being used for fine-grained load balancing, but that didn't pan our=20
well so it really doesn't need to be as frequent as it is.  Given that the=
=20
default grace is 20 seconds, I'll change it to 6 seconds, so that we'll=20
miss a full 3 pings before failing a node.

The one thing to keep in mind is that if the grace period is adjusted, the=
=20
interval probably needs to be as well.

sage
--557981400-818980257-1332876832=:1271--
