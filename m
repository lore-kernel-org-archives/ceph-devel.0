From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 00/19] crush kernel update
Date: Mon, 23 Dec 2013 19:09:31 +0200
Message-ID: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:58584 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3LWRKk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:40 -0500
Received: by mail-ee0-f53.google.com with SMTP id b57so2416215eek.26
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Hello,

This series brings the kernel implementation of crush up to date with
recent changes in ceph.git.  Highlights:

- 01/19 pass osdmap->max_osd for weight_max param of crush_do_rule()
- 05/19 add crush_do_rule_ary() helper
- 10/19 fix build breakage introduced by "clarify numrep vs endpos"
        ceph.git commit
- 11/19 same as 10/19
- 12/19, 17/19 unsigned -> unsigned int, to comply with net/ rules
- 17/19 squash "crush: add set_choose_local_[fallback_]tries steps" and
        "crush/mapper: finish adding choose_local_[fallback_]tries"
        ceph.git commits into one, fix build breakage introduced by
        "crush/mapper: finish adding choose_local_[fallback_]tries"

Available from wip-crush-2 branch of ceph-client.git.

Thanks,

                Ilya


Ilya Dryomov (19):
  crush: pass weight vector size to map function
  crush: factor out (trivial) crush_destroy_rule()
  crush: reduce scope of some local variables
  crush: fix some comments
  crush: eliminate CRUSH_MAX_SET result size limitation
  crush: return CRUSH_ITEM_UNDEF for failed placements with indep
  crush: use breadth-first search for indep mode
  crush: add note about r in recursive choose
  crush: strip firstn conditionals out of crush_choose, rename
  crush: clarify numrep vs endpos
  crush: pass parent r value for indep call
  crush: new SET_CHOOSE_LEAF_TRIES command
  crush: apply chooseleaf_tries to firstn mode too
  crush: add SET_CHOOSE_TRIES rule step
  crush: CHOOSE_LEAF -> CHOOSELEAF throughout
  crush: generalize descend_once
  crush: add set_choose_local_[fallback_]tries steps
  crush: attempts -> tries
  crush: fix crush_choose_firstn comment

 include/linux/crush/crush.h  |   20 ++-
 include/linux/crush/mapper.h |    3 +-
 net/ceph/crush/crush.c       |    7 +-
 net/ceph/crush/mapper.c      |  336 +++++++++++++++++++++++++++++++++---------
 net/ceph/osdmap.c            |   16 +-
 5 files changed, 304 insertions(+), 78 deletions(-)

-- 
1.7.10.4

