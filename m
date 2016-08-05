From: Loic Dachary <loic@dachary.org>
Subject: Merging rados related backports
Date: Fri, 5 Aug 2016 15:08:36 +0200
Message-ID: <57A48FD4.40401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35984 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbcHENIm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 09:08:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sam,

When running the rados suite on a given backport targetting jewel (or hammer for that matter, but it's less of an issue) I figured the smallest subset would be enough to guarantee there is no trivial regression, this is why we're routinely using X/2000. I understand this is not enough coverage to release jewel and we have the nightlies running X/14 for that. When jewel is eventually released, all of the rados suite should have been run.

If you think there are too many regressions merged in the jewel branch because X/2000 did not detect them, we will increase the size of the subset. This will slow down backporting when the lab is misbehaving, but that's less time consuming than chassing a regression long after the guilty commit has been merged.

Cheers

[1] http://tracker.ceph.com/projects/ceph-releases/wiki/Sepia/97

-- 
Loïc Dachary, Artisan Logiciel Libre
