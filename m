From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] OSD state flipping when cluster-network in high
 utilization
Date: Tue, 14 May 2013 08:30:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305140828550.22973@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC0145EFF6@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-192194115-1368545454=:22973"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58895 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3ENPaz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 11:30:55 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC0145EFF6@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-192194115-1368545454=:22973
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 14 May 2013, Chen, Xiaoxi wrote:
>=20
> Hi
>=20
> =A0 We are suffering our OSD flipping between up and down ( OSD X be vo=
ted to
> down due to 3 missing ping, and after a while it tells the monitor ?map=
 xxx
> wrongly mark me down? ). Because we are running sequential write perfor=
mance
> test on top of RBDs, and the cluster network nics is really in high
> utilization (8Gb/s+ for a 10Gb network).
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 Is this a expected behavior ? or how can I pre=
vent this happen?

You an increase the heartbeat grace period.  The pings are handled by a=20
separate thread on the backside interface (if there is one).  If you are=20
missing pings then the network or scheduler is preventing those (small)=20
messages from being processed (there is almost no lock contention in that=
=20
path).  Which means it really is taking ~20 seconds or wahtever to handle=
=20
those messages.  It's really a questin of how unresponsive you want to=20
permit the OSDs to be before you consider it a failure..

sage
=20
--557981400-192194115-1368545454=:22973--
