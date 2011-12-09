From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH v2 0/6] OSD documentation improvements
Date: Fri,  9 Dec 2011 18:57:39 +0100
Message-ID: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4.gwdg.de ([134.76.10.17]:2291 "EHLO mx4.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979Ab1LIR6B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Dec 2011 12:58:01 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Patch 1 imports the documentation from the wiki to the new file
doc/doc/control.rst of the git repo. It is just the result of a cut &
paste operation. The other patches of the series aim for a complete
and up to date documentation for all osd subcommands.

Changes to V1:
	* Proper SOB for all patches,
	* Address Gregory Farnum's comment on Patch 5/6 of V1,
	* Put things in doc/control.rst rather than doc/ops/monitor.rst
	  and change title to Control commands on Tommi Virtanen's
	  request.

Some OSD subcommands still lack useful descriptions. For example
it's not clear (to me at least) what's the point of the osd "in"
and "out" commands.  But this can easily be improved later, so I'd
propose to merge this version of the patch series.

BTW: I tried to rebase against the current master branch. However, as
it turned out, ditaa is now required for building the documentation
and there is no package for my distribution (lucid). Ditaa from SVN
didn't like my java version, so I gave up and did not rebase.

Andre
