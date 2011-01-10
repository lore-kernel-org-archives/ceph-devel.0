From: Sage Weil <sage@newdream.net>
Subject: v0.24.1 released
Date: Sun, 9 Jan 2011 21:42:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101092141550.28455@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55811 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1AJFgP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Jan 2011 00:36:15 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 22A52BC75B
	for <ceph-devel@vger.kernel.org>; Sun,  9 Jan 2011 21:42:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D482FBC75B
	for <ceph-devel@vger.kernel.org>; Sun,  9 Jan 2011 21:42:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

v0.24.1 has been released, with a number of bug fixes from v0.24.  These 
include:

 * msgr: fix races during connection teardown
 * mds: fix bug during directory removal
 * mds: fix replay issue when mds restarts immediately after mkfs
 * filestore: fix journal ordering problem (triggered under load)
 * osd: fix recovery issue
 * osd: several scrub bug fixes

This is also the first time I've built Ubuntu packages (for lucid and 
maverick), as the libcrypto++ dependency resolves to a different library 
version on Ubuntu and Debian sid.  If anyone has any problems there, 
please let us know.  libcrypto++ is unfortunately also a hassle under 
Redhat, as it is not included in RHEL and was only recently added to 
Fedora.  We plan to start building RHEL/CentOS and Fedora packages soon, 
and will be updating the wiki with information on gathering all the 
dependencies to build from source shortly.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.24.1.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian

sage
