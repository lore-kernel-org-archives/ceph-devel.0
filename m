From: Sage Weil <sage@newdream.net>
Subject: Re: Problem with inconsistent PG
Date: Fri, 10 Feb 2012 14:30:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202101425500.2943@cobra.newdream.net>
References: <4F34CA99.6020905@filoo.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-379999940-1328913058=:2943"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56125 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab2BJWbA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 17:31:00 -0500
In-Reply-To: <4F34CA99.6020905@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, oliver.francke@filoo.de

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-379999940-1328913058=:2943
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Feb 2012, Jens Rehp=F6hler wrote:
> Hi Liste,
>=20
> today i've got another problem.
>=20
> ceph -w shows up with an inconsistent PG over night:
>=20
> 2012-02-10 08:38:48.701775    pg v441251: 1982 pgs: 1981 active+clean, 1
> active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
> GB avail
> 2012-02-10 08:38:49.702789    pg v441252: 1982 pgs: 1981 active+clean, 1
> active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
> GB avail
>=20
> I've identified it with "ceph pg dump - | grep inconsistent
>=20
> 109.6    141    0    0    0    463820288    111780    111780  =20
> active+clean+inconsistent    485'7115    480'7301    [3,4]    [3,4]  =20
> 485'7061    2012-02-10 08:02:12.043986
>=20
> Now I've tried to repair it with: ceph pg repair 109.6
>=20
> 2012-02-10 08:35:52.276325 mon <- [pg,repair,109.6]
> 2012-02-10 08:35:52.276776 mon.1 -> 'instructing pg 109.6 on osd.3 to
> repair' (0)
>=20
> but i only get the following result:
>=20
> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455420 osd.3
> 10.10.10.8:6801/25980 6913 : [ERR] 109.6 osd.4: soid
> 1ef398ce/rb.0.0.0000000000bd/headsize 2736128 !=3D known size 3145728
> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455426 osd.3
> 10.10.10.8:6801/25980 6914 : [ERR] 109.6 scrub 0 missing, 1 inconsistent
> objects
> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455799 osd.3
> 10.10.10.8:6801/25980 6915 : [ERR] 109.6 scrub 1 errors
>=20
> Can someone please explain me what to do in this case and how to recover
> the pg ?

So the "fix" is just to truncate the file to the expected size, 3145728,=20
by finding it in the current/ directory.  The name/path will be slightly=20
weird; look for 'rb.0.0.0000000000bd'.

The data is still suspect, though.  Did the ceph-osd restart or crash=20
recently?  I would do that, repair (it should succeed), and then fsck the=
=20
file system in that rbd image.

We just fixed a bug that was causing transactions to leak across=20
checkpoint/snapshot boundaries.  That could be responsible for causing all=
=20
sorts of subtle corruptions, including this one.  It'll be included in=20
v0.42 (out next week).

sage
--557981400-379999940-1328913058=:2943--
