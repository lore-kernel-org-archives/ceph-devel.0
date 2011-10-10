From: Sage Weil <sage@newdream.net>
Subject: RPMs on build.opensuse.org
Date: Sun, 9 Oct 2011 21:39:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110092117360.26432@cobra.newdream.net>
References: <Pine.LNX.4.64.1110041025030.23052@cobra.newdream.net>
 <201110071216.12793.cndegen@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51223 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1JJEjT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2011 00:39:19 -0400
In-Reply-To: <201110071216.12793.cndegen@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Christian Degen <cndegen@suse.de>, PChadwick@suse.com, dona.holmberg@dreamhost.com, Bryan Bogensberger <bryan@newdream.net>

Hey everyone,

Over the last few days I've wasted far more hours than I care to 
remember/admit futzing around with the ceph.spec file.  The goal is to use 
build.opensuse.org (or maybe a private instance) to build RPMs for 
multiple platforms, including opensuse, sles, fedora, rhel, and centos.

	https://build.opensuse.org/package/show?package=ceph&project=home%3Aliewegas

A few things:
 - I can't build packages in the actual RHEL environments because some 
   legal thing makes the -devel packages unavailable, so you need to look 
   at the CentOS ones instead.
 - A bunch of debian targets are listed, but I didn't pull the debian/ dir 
   out of the tarball, so those show up as excluded currently.
 - The tarball that in the build.opensuse.org repo is a snapshot from 
   recent master, not the actual ceph-0.36.tar.gz.  The .spec file also 
   has several changes that aren't in ceph.git yet.  Work from the 
   openbuild versions and I'll integrate back into the upstream once 
   things actually work.
	https://build.opensuse.org/package/files?package=ceph&project=home%3Aliewegas 

Here is where things currently stand:

 - openSUSE_Tumbleweed, openSUSE_Factory, openSUSE_11.4, openSUSE_11.3
   - Seems to build fine...
   - ...but there are errors about insserv I have no idea how to fix:

insserv: FATAL: service network has to be enabled to use service ceph
insserv: exiting now!
/sbin/insserv failed, exit code 1

 - SLE_11, SLE_11_SP1:
   - The configure libedit check defines LIBEDIT_LIBS, which includes 
     -lcurses, and ncurses-devel gets installed, but

/usr/lib64/gcc/x86_64-suse-linux/4.3/../../../../x86_64-suse-linux/bin/ld: 
cannot find -lcurses

     This is annoying, because the configure macro is the one deciding to 
     link that in in the first place...  Do I need to list some other
     ncurses -devel package explicitly as a build depenency??


 - Fedora_14, 15 i586:
   - The atomic test and set stuff doesn't seem to work on a uint32_t:

/home/abuild/rpmbuild/BUILD/ceph-0.36/src/common/simple_spin.cc:42: 
undefined reference to `__sync_bool_compare_and_swap_4'


 - Suddenly build.opensuse.org isn't showing build logfiles anymore 
   ('remote error: no socket attached'), so I don't have details on the 
   others.  :(

In case it isn't obvious, I know next to nothing about writing spec 
files, and have probably made a mess of things trying to make it happy on
all of these platforms.  Any help here would be greatly appreciated!

sage

