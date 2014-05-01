From: Sage Weil <sage@inktank.com>
Subject: v0.67.8 released
Date: Thu, 1 May 2014 08:38:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405010837110.2601@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49283 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbaEAPio (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 May 2014 11:38:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

This Dumpling point release fixes several non-critical issues since 
v0.67.7.  The most notable bug fixes are an auth fix in librbd (observed 
as an occasional crash from KVM), an improvement in the network failure 
detection with the monitor, and several hard to hit OSD crashes or hangs.

We recommend that all users upgrade at their convenience.

Upgrading
---------

* The 'rbd ls' function now returns success and returns an empty when a pool
  does not store any rbd images.  Previously it would return an ENOENT 
  error.

* Ceph will now issue a health warning if the 'mon osd down out
  interval' config option is set to zero.  This warning can be
  disabled by adding 'mon warn on osd down out interval zero = false'
  to ceph.conf.

Notable Changes
---------------

* all: improve keepalive detection of failed monitor connections (#7888, 
  Sage Weil)
* ceph-fuse, libcephfs: pin inodes during readahead, fixing rare crash 
  (#7867, Sage Weil)
* librbd: make cache writeback a bit less aggressive (Sage Weil)
* librbd: make symlink for qemu to detect librbd in RPM (#7293, Josh 
  Durgin)
* mon: allow 'hashpspool' pool flag to be set and unset (Loic Dachary)
* mon: commit paxos state only after entire quorum acks, fixing rare race 
  where prior round state is readable (#7736, Sage Weil)
* mon: make elections and timeouts a bit more robust (#7212, Sage Weil)
* mon: prevent extreme pool split operations (Greg Farnum)
* mon: wait for quorum for get_version requests to close rare pool 
  creation race (#7997, Sage Weil)
* mon: warn on 'mon osd down out interval = 0' (#7784, Joao Luis)
* msgr: fix byte-order for auth challenge, fixing auth errors on 
  big-endian clients (#7977, Dan Mick)
* msgr: fix occasional crash in authentication code (usually triggered by 
  librbd) (#6840, Josh Durgin)
* msgr: fix rebind() race (#6992, Xihui He)
* osd: avoid timeouts during slow PG deletion (#6528, Samuel Just)
* osd: fix bug in pool listing during recovery (#6633, Samuel Just)
* osd: fix queue limits, fixing recovery stalls (#7706, Samuel Just)
* osd: fix rare peering crashes (#6722, #6910, Samuel Just)
* osd: fix rare recovery hang (#6681, Samuel Just)
* osd: improve error handling on journal errors (#7738, Sage Weil)
* osd: reduce load on the monitor from OSDMap subscriptions (Greg Farnum)
* osd: rery GetLog on peer osd startup, fixing some rare peering stalls 
  (#6909, Samuel Just)
* osd: reset journal state on remount to fix occasional crash on OSD 
  startup (#8019, Sage Weil)
* osd: share maps with peers more aggressively (Greg Farnum)
* rbd: make it harder to delete an rbd image that is currently in use 
  (#7076, Ilya Drymov)
* rgw: deny writes to secondary zone by non-system users (#6678, Yehuda 
  Sadeh)
* rgw: do'nt log system requests in usage log (#6889, Yehuda Sadeh)
* rgw: fix bucket recreation (#6951, Yehuda Sadeh)
* rgw: fix Swift range response (#7099, Julien Calvet, Yehuda Sadeh)
* rgw: fix URL escaping (#8202, Yehuda Sadeh)
* rgw: fix whitespace trimming in http headers (#7543, Yehuda Sadeh)
* rgw: make multi-object deletion idempotent (#7346, Yehuda Sadeh)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.67.8.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy

