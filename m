From: Sage Weil <sweil@redhat.com>
Subject: hammer blueprints
Date: Fri, 10 Oct 2014 17:44:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410021643060.17153@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39121 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbaJKAo1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 20:44:27 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 879168004F
	for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 17:44:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 662518004F
	for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 17:44:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here's my list of possible blueprints for hammer.  And who might write 
them up.  This is just a brain dump of what I'm thinking about; please 
add, remove, object, suggest, etc.!

Some of these blueprints already exist, but I suspect they are in need up 
a refresh to make them reflect the current thinking.

I threw in several of the items we discussed in the performance calls.  I 
think most of the key areas of development are captured below.  What's 
missing is a lot of non-specific work around profiling and optimizing 
existing code paths that is also a key effort for hammer.

What else is missing (or unnecessary) here?

-- core --

osd: recovery performance: EC recovery offload (Sam)
osd: qos: unified priority queue (Sam)
osd: performance: transaction api changes, keyfilestore backend (Sage)
osd: performance: rados io hints (?)
osd: data integrity: opportunistic at-rest checksums (#9059 Sage)
osd: data integrity: scrub and repair (David)
performance: buffer encode/decode performance (Matt)
performance: AsyncMessenger (Haomai)
performance: XioMessenger update (Matt)
mon: performance: improve threading/locking (Joao, Sage)
mon: scalability: prepopulate pg_temp (#7173 Sage)
mon: data integrity: per-crush type down_out_interval (#7347)
mon: data integrity: usable mon scrub (Joao)
auth: kerberos support (Sage)
tracing roadmap discussion
crush: multi-type trees (ssd hdd) (Sage)

-- librados --

librados: data integrity: end-to-end checksums (expose csums to read/write) (Sage)
librados: threading and async ops vs python (Dan)

-- cephfs --

data integrity: forward scrub (Greg)
quotas vs subtrees
auth (kerberos) minimum requirements
hadoop: status, progress, roadmap (Noah)

-- rgw --

rgw: api fidelity: object versioning update (Yehuda)
rgw: scaling, performance: bucket index scaling update (Guang)
rgw: multi-dc status, roadmap (Yehuda)
rgw: librgw?
rgw: api fidelity: object expiration

-- rbd --

rbd: performance: object map (Jason)
rbd: mirroring (Josh)
rbd: HA iscsi gateways (Mike)
rbd: performance optimization discussion

-- calamari --

rpm/deb packaging update for calamari and deps (Boris, Tim, Dan?)
kerberos auth support (Dan)
calamari api gaps (e.g., rbd) (Gregory)

-- calamari-clients / romana --

localization update?
calamari vs romana roadmap discussion

-- teuthology --

teuthology: general roadmap discussion
paddles: queueing ?
automated performance tests

-- ceph-deploy --

?

-- build/ci --

build infrastructure roadmap



