From: Sage Weil <sweil@redhat.com>
Subject: v0.67.10 Dumpling released
Date: Tue, 12 Aug 2014 12:40:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408121235040.32576@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49425 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbaHLTkH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 15:40:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This stable update release for Dumpling includes primarily fixes for RGW, 
including several issues with bucket listings and a potential data 
corruption problem when multiple multi-part uploads race.  There is also 
some throttling capability added in the OSD for scrub that can mitigate 
the performance impact on production clusters.

We recommend that all Dumpling users upgrade at their convenience.

Notable Changes
---------------

* ceph-disk: partprobe befoere settle, fixing dm-crypt (#6966, Eric 
  Eastman)
* librbd: add invalidate cache interface (Josh Durgin)
* librbd: close image if remove_child fails (Ilya Dryomov)
* librbd: fix potential null pointer dereference (Danny Al-Gaaf)
* librbd: improve writeback checks, performance (Haomai Wang)
* librbd: skip zeroes when copying image (#6257, Josh Durgin)
* mon: fix rule(set) check on 'ceph pool set ... crush_ruleset ...' 
  (#8599, John Spray)
* mon: shut down if mon is removed from cluster (#6789, Joao Eduardo Luis)
* osd: fix filestore perf reports to mon (Sage Weil)
* osd: force any new or updated xattr into leveldb if E2BIG from XFS 
  (#7779, Sage Weil)
* osd: lock snapdir object during write to fix race with backfill (Samuel 
  Just)
* osd: option sleep during scrub (Sage Weil)
* osd: set io priority on scrub and snap trim threads (Sage Weil)
* osd: 'status' admin socket command (Sage Weil)
* rbd: tolerate missing NULL terminator on block_name_prefix (#7577, Dan 
  Mick)
* rgw: calculate user manifest (#8169, Yehuda Sadeh)
* rgw: fix abort on chunk read error, avoid using extra memory (#8289, 
  Yehuda Sadeh)
* rgw: fix buffer overflow on bucket instance id (#8608, Yehuda Sadeh)
* rgw: fix crash in swift CORS preflight request (#8586, Yehuda Sadeh)
* rgw: fix implicit removal of old objects on object creation (#8972, 
  Patrycja Szablowska, Yehuda Sadeh)
* rgw: fix MaxKeys in bucket listing (Yehuda Sadeh)
* rgw: fix race with multiple updates to a single multipart object (#8269, 
  Yehuda Sadeh)
* rgw: improve bucket listing with delimiter (Yehuda Sadeh)
* rgw: include NextMarker in bucket listing (#8858, Yehuda Sadeh)
* rgw: return error early on non-existent bucket (#7064, Yehuda Sadeh)
* rgw: set truncation flag correctly in bucket listing (Yehuda Sadeh)
* sysvinit: continue starting daemons after pre-mount error (#8554, Sage 
  Weil)

For more detailed information, see:

  http://ceph.com/docs/master/_downloads/v0.67.10.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.67.10.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
