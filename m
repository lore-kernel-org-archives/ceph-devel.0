From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH/RFC 0/6]: Introduction
Date: Mon, 28 Nov 2011 15:04:30 +0100
Message-ID: <1322489076-31364-1-git-send-email-maan@systemlinux.org>
References: <20111121180656.GO13394@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3.gwdg.de ([134.76.10.16]:27882 "EHLO mx3.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489Ab1K1OOd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Nov 2011 09:14:33 -0500
In-Reply-To: <20111121180656.GO13394@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Here is what I have so far. This patch set imports the documentation
of the OSD subcommands from the wiki to the preciously emtpy file
doc/ops/monitor.rst of the git repo. The first patch is just the
result of a cut & paste operation of the corresponding wiki page
while the other patches try to improve on this. The aim is to have
a complete and up to date documentation for all osd subcommands.

I don't believe the series is ready for inclusion yet as some
subcommands (cluster_snap, lost, in, out, ...) still lack useful
descriptions. It would be nice to add one sentence to each such command
that explains its purpose and the circumstances under which one might
want to use this particular command.

So please review and comment. I will fold in your suggestions and
follow up with a re-rolled series provided there is substantial
feedback.

Thanks
Andre

