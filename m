From: Sage Weil <sage@inktank.com>
Subject: v0.76 released
Date: Mon, 3 Feb 2014 22:05:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402032203160.20429@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35023 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaBDGFy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 01:05:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

This release includes another batch of updates for firefly
functionality.  Most notably, the cache pool infrastructure now
support snapshots, the OSD backfill functionality has been generalized
to include multiple targets (necessary for the coming erasure pools),
and there were performance improvements to the erasure code plugin on
capable processors.  The MDS now properly utilizes (and seamlessly
migrates to) the OSD key/value interface (aka omap) for storing directory
objects.  There continue to be many other fixes and improvements for
usability and code portability across the tree.

Upgrading
~~~~~~~~~

* 'rbd ls' on a pool which never held rbd images now exits with code
  0. It outputs nothing in plain format, or an empty list in
  non-plain format. This is consistent with the behavior for a pool
  which used to hold images, but contains none. Scripts relying on
  this behavior should be updated.

* The MDS requires a new OSD operation TMAP2OMAP, added in this release.  When
  upgrading, be sure to upgrade and restart the ceph-osd daemons before the
  ceph-mds daemon.  The MDS will refuse to start if any up OSDs do not support
  the new feature.

* The 'ceph mds set_max_mds N' command is now deprecated in favor of
  'ceph mds set max_mds N'.

Notable Changes
~~~~~~~~~~~~~~~

* build: misc improvements (Ken Dreyer)
* ceph-disk: generalize path names, add tests (Loic Dachary)
* ceph-disk: misc improvements for puppet (Loic Dachary)
* ceph-disk: several bug fixes (Loic Dachary)
* ceph-fuse: fix race for sync reads (Sage Weil)
* config: recursive metavariable expansion (Loic Dachary)
* crush: usability and test improvements (Loic Dachary)
* doc: misc fixes (David Moreau Simard, Kun Huang)
* erasure-code: improve buffer alignment (Loic Dachary)
* erasure-code: rewrite region-xor using vector operations (Andreas 
  Peters)
* librados, osd: new TMAP2OMAP operation (Yan, Zheng)
* mailmap updates (Loic Dachary)
* many portability improvements (Noah Watkins)
* many unit test improvements (Loic Dachary)
* mds: always store backtrace in default pool (Yan, Zheng)
* mds: store directories in omap instead of tmap (Yan, Zheng)
* mon: allow adjustment of cephfs max file size via 'ceph mds set 
  max_file_size' (Sage Weil)
* mon: do not create erasure rules by default (Sage Weil)
* mon: do not generate spurious MDSMaps in certain cases (Sage Weil)
* mon: do not use keyring if auth = none (Loic Dachary)
* mon: fix pg_temp leaks (Joao Eduardo Luis)
* osd: backfill to multiple targets (David Zafman)
* osd: cache pool support for snapshots (Sage Weil)
* osd: fix and cleanup misc backfill issues (David Zafman)
* osd: fix omap_clear operation to not zap xattrs (Sam Just, Yan, Zheng)
* osd: ignore num_objects_dirty on scrub for old pools (Sage Weil)
* osd: include more info in pg query result (Sage Weil)
* osd: track erasure compatibility (David Zafman)
* rbd: make 'rbd list' return empty list and success on empty pool (Josh 
  Durgin)
* rgw: fix object placement read op (Yehuda Sadeh)
* rgw: fix several CORS bugs (Robin H. Johnson)
* specfile: fix RPM build on RHEL6 (Ken Dreyer, Derek Yarnell)
* specfile: ship libdir/ceph (Key Dreyer)

You can get v0.75 from the usual locations:

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.76.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy

