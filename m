From: Sage Weil <sage@inktank.com>
Subject: v0.47 released
Date: Sun, 20 May 2012 21:38:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205202137430.843@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1752482405-1337575095=:843"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35320 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab2EUEiZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 00:38:25 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D06B0BC7C1
	for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 21:38:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9C8A5BC7C1
	for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 21:38:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1752482405-1337575095=:843
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

It's been another three weeks and v0.47 is ready. =A0The highlights include=
:

 * mon: admin tools to control unwieldy clusters (temporarily block osd=20
   boots, failures, etc.)
 * osd: reduced memory footprint for peering/thrashing
 * librbd: write-thru cache mode
 * librbd: improved error handling
 * osd: removal of ill-conceived 'localized pg' feature (those annoying=20
   PGs with 'p' in them)
 * rados-bench: simple tool to benchmark radosgw (or S3) (based on 'rados=
=20
   bench' command)

In truth it wasn't the most productive sprint because of the work that=20
went into the launch of the web sites, the launch party, and the=20
subsequent=A0inebriation. =A0However, the new RBD caching feature is lookin=
g=20
very good at this point, and patches are working their way upstream in=20
Qemu/KVM to enable it with the generic 'cache=3Dwritethrough' or=20
'cache=3Dwriteback' settings.

One other noteworthy item is that I generated a new PGP key to sign=20
releases with. =A0The key is now in ceph.git, and has been signed by my=20
personal key. =A0If you are installing debs from our repositories, you'll=
=20
want to add the new key to your APT keyring to avoid annoying security=20
warnings.

For v0.48, we are working on a ceph-osd refactor to improve threading and=
=20
performance, multi-monitor and OSD hotplugging support for upstart and=20
Chef, improvements to the OSD and monitor bootstrapping to make that=20
possible, and RBD groundwork for the much-anticipated layering feature.

You can get v0.47 from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at=A0http://ceph.newdream.net/download/ceph-0.47.tar.gz
 * For Debian/Ubuntu packages, see=A0http://ceph.newdream.net/docs/master/i=
nstall/debian
--557981400-1752482405-1337575095=:843--
