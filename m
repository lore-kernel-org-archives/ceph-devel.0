From: Sage Weil <sage@newdream.net>
Subject: ceph build issues
Date: Mon, 31 Oct 2011 09:32:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110310923110.14820@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40355 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab1JaQcI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2011 12:32:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan.Fent@suse.com
Cc: ceph-devel@vger.kernel.org

Hi Stefan,

Here's a quick summary of the issues right now with ceph rpm builds:

- Inconsistent use of insserv vs pkgconfig throughout.  I'm not sure 
if/when/where the init scripts should be configured.  And the .spec file 
needs to do the right thing for non-suse dists as well.  I've gotten mixed 
messages about what the right thing to do is here.

- sles failes with -lcurses.  The weird thing is that -lcurses isn't part 
of our Makefile.  It's coming from a pkgconfig for something (i.e. the 
build environment).

- The fedora environments in build.opensuse.org don't have the 
redhat-rpm-config installed... see

	http://www.spinics.net/lists/ceph-devel/msg03793.html

There is a workaround/hack in the .spec file right now that should be 
removed at some point.

- There are a zillion rpmlint errors on the packages that do build 
successfully.  No idea how important those are.

The build results are at

	https://build.opensuse.org/package/show?package=ceph&project=home%3Aliewegas

if you haven't found them already.

Also, I should also mention that most of the stuff in the build.opensuse 
has been pulled back into the ceph.spec.in in git, but not everything.

Thanks!
sage

