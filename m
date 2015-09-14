From: Sage Weil <sage@newdream.net>
Subject: RE: Backfill
Date: Mon, 14 Sep 2015 11:58:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509141158110.23022@cobra.newdream.net>
References: <BLU175-W33B6417CFB278EA9EC4092DF500@phx.gbl>, <alpine.DEB.2.00.1509110556430.7527@cobra.newdream.net> <BLU175-W241EDB4AD159856222D39ADF5D0@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2135008205-1442257102=:23022"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46523 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbbINS6X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 14:58:23 -0400
In-Reply-To: <BLU175-W241EDB4AD159856222D39ADF5D0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sjust@redhat.com" <sjust@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2135008205-1442257102=:23022
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2015, GuangYang wrote:
> Thanks Sage. That makes sense. Just would like to confirm my understand=
ing:
>=20
> Let's say the map for the PG changes from [1, 2, 3] to [1, 2, 4] and 4 =
is the backfill target (4 may or may not have the info for the PG, which =
should not matter as long as it is not eligible for log based recovery), =
here the PG's last_backfill and backfill_info.begin would reset to MIN, s=
ame for 4, and the flow would be something like:
> =A0 1. 1 scan_range starting from backfill_info.begin for a configured =
number of entries
> =A0 2. 1 query the digest from 4 for the range
> =A0 3. Once the digest is back from 4, fill the to_push and to_remove l=
ist by comparing the local and remote entries (here we also consider the =
PG log to capture most recent updates)
> =A0 4. If either to_push or to_remove is not empty, push the objects (o=
r remove) to the backfill target.
> =A0 5. Move the lack_backfill pointer and continue with step 1.

Yep!

sage
--557981400-2135008205-1442257102=:23022--
