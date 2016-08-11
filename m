From: Loic Dachary <loic@dachary.org>
Subject: separating transient rados job errors
Date: Thu, 11 Aug 2016 11:24:41 +0200
Message-ID: <57AC4459.6030108@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46319 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbcHKJZP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 05:25:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sam,

I propose that rados jobs known to experience occasional errors[1] are temporarily excluded from the nightlies while they are being fixed. And the nightlies could be green unless a new issue shows up. A wiki page listing the unreliable jobs[2] could be used to --filter-out the jobs it contains. When the problem is fixed, the job is removed from the wiki page and is no longer excluded from the nightlies.

--filter-out <(curl -s http://tracker.ceph.com/projects/ceph/wiki/Rados-jewel.txt?key=$redmine_key |  cut -f2- -d' ' | perl -n0e 'print join(",", split(/\S*\n/))')

What do you think ?

Cheers

[1] http://tracker.ceph.com/issues/15785 fails 30% of the time
[2] http://tracker.ceph.com/projects/ceph/wiki/Rados-jewel

-- 
Loïc Dachary, Artisan Logiciel Libre
