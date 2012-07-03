From: Sage Weil <sage@inktank.com>
Subject: v0.48 "argonaut" released
Date: Mon, 2 Jul 2012 21:29:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207022126090.28976@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1403585666-1341289764=:28976"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40063 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab2GCE31 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 00:29:27 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 612F2BC6FE
	for <ceph-devel@vger.kernel.org>; Mon,  2 Jul 2012 21:29:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 3B023BC6FE
	for <ceph-devel@vger.kernel.org>; Mon,  2 Jul 2012 21:29:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1403585666-1341289764=:28976
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

We're pleased to annouce the release of Ceph v0.48, code-named "argonaut."=
=20
This release will be the basis of our first long-term stable branch.=20
Although we will continue to make releases every 3-4 weeks, this stable=20
release will be maintained with bug fixes and select non-destabilizing=20
feature additions for much longer than that. =A0Argonaut is recommended for=
=20
production users of rados and librados, rbd and librbd, and radosgw.

The upgrade to v0.48 argonaut from previous versions includes a=20
disk-format upgrade. =A0Please note:

 * You will not be able to downgrade from v0.48 to a previous version.
 * Each ceph-osd will need some time to convert its local data before
   rejoining the cluster. =A0If you need to maintain availability, you will
   need to do a "rolling upgrade" by restarting daemons on each host or
   rack in sequence and allowing the cluster to recover before moving on
   to the next one. =A0Note that for non-btrfs file systems especially this=
=20
   can be slow (many hours); plan accordingly.
 * The ceph tool's -s and -w commands from previous version are incompatibl=
e=20
   with this version. =A0Upgrade your client tools with your monitor if you=
=20
   rely on those commands.

The highlights for this release include:

 * osd: stability improvements
 * osd: capability model simplification
 * osd: simpler/safer --mkfs (no longer removes all files; safe to re-run=
=20
   on active osd)
 * osd: potentially buggy FIEMAP behavior disabled by default
 * rbd: caching improvements
 * rbd: improved instrumentation
 * rbd: bug fixes
 * radosgw: new, scalable usage logging infrastructure
 * radosgw: per-user bucket limits
 * mon: streamlined process for setting up authentication keys
 * mon: stability improvements
 * mon: log message throttling
 * doc: improved documentation (ceph, rbd, radosgw, chef, etc.)
 * config: new default locations for daemon keyrings
 * config: arbitrary variable substitutions
 * improved 'admin socket' daemon admin interface (ceph --admin-daemon=20
   ...)
 * chef: support for multiple monitor clusters
 * upstart: basic support for monitors, mds, radosgw; osd support still a=
=20
   work in progress.

The new default keyring locations mean that when enabling authentication=20
('auth supported =3D cephx'), keyring locations do not need to be specified=
=20
if the keyring file is located inside the daemon's data directory=20
(/var/lib/ceph/$type/ceph-$id by default).

There is also a lot of librbd code in this release that is laying the=20
groundwork for the upcoming layering functionality, but is not actually=20
used. =A0Likewise, the upstart support is still incomplete and not=20
recommended; we will backport that functionality later if it turns out to=
=20
be non-disruptive.

For more information, please see the complete release notes:

=09http://ceph.com/docs/master/release-notes/

The current focus for upcoming development releases is on radosgw=20
stability, RBD stability, and RBD layering. =A0There is also ongoing=20
'devops' work on integration with management and provisioning tools like=20
upstart, Chef, Juju, and Crowbar. =A0A major refactor of the OSD code is=20
about to be merged which will improve performance and scalability, and our=
=20
testing coverage continues to improve.

You can get v0.48 argonaut from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at=A0http://ceph.newdream.net/download/ceph-0.48.tar.gz
 * For Debian/Ubuntu packages,=20
   see=A0http://ceph.newdream.net/docs/master/install/debian
--557981400-1403585666-1341289764=:28976--
