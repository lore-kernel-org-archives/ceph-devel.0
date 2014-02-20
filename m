From: Sage Weil <sage@inktank.com>
Subject: v0.77 released
Date: Thu, 20 Feb 2014 09:32:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402200930510.28818@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42007 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaBTRcG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Feb 2014 12:32:06 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

This is the final development release before the Firefly feature
freeze.  The main items in this release include some additional
refactoring work in the OSD IO path (include some locking
improvements), per-user quotas for the radosgw, a switch to civetweb
from mongoose for the prototype radosgw standalone mode, and a
prototype leveldb-based backend for the OSD.  The C librados API also
got support for atomic write operations (read side transactions will
appear in v0.78).

Upgrading
~~~~~~~~~

* The 'ceph -s' or 'ceph status' command's 'num_in_osds' field in the
  JSON and XML output has been changed from a string to an int.

* The recently added 'ceph mds set allow_new_snaps' command's syntax
  has changed slightly; it is now 'ceph mds set allow_new_snaps true'.
  The 'unset' command has been removed; instead, set the value to
  'false'.

* The syntax for allowing snapshots is now 'mds set allow_new_snaps
  <true|false>' instead of 'mds <set,unset> allow_new_snaps'.

Notable Changes
~~~~~~~~~~~~~~~

* osd: client IO path changes for EC (Samuel Just)
* common: portability changes to support libc++ (Noah Watkins)
* common: switch to unordered_map from hash_map (Noah Watkins)
* rgw: switch from mongoose to civetweb (Yehuda Sadeh)
* osd: improve locking in fd lookup cache (Samuel Just, Greg Farnum)
* doc: many many updates (John Wilkins)
* rgw: user quotas (Yehuda Sadeh)
* mon: persist quorum features to disk (Greg Farnum)
* mon: MForward tests (Loic Dachary)
* mds: inline data support (Li Wang, Yunchuan Wen)
* rgw: fix many-part multipart uploads (Yehuda Sadeh)
* osd: new keyvaluestore-dev backend based on leveldb (Haomai Wang)
* rbd: prevent deletion of images with watchers (Ilya Dryomov)
* osd: avoid touching leveldb for some xattrs (Haomai Wang, Sage Weil)
* mailmap: affiliation updates (Loic Dachary)
* osd: new OSDMap encoding (Greg Farnum)
* osd: generalize scrubbing infrastructure to allow EC (David Zafman)
* rgw: several doc fixes (Alexandre Marangone)
* librados: add C API coverage for atomic write operations (Christian 
  Marie)
* rgw: improve swift temp URL support (Yehuda Sadeh)
* rest-api: do not fail when no OSDs yet exist (Dan Mick)
* common: check preexisting admin socket for active daemon before removing 
  (Loic Dachary)
* osd: handle more whitespace (newline, tab) in osd capabilities (Sage 
  Weil)
* mon: handle more whitespace (newline, tab) in mon capabilities (Sage 
  Weil)
* rgw: make multi-object delete idempotent (Yehuda Sadeh)
* crush: fix off-by-one error in recent refactor (Sage Weil)
* rgw: fix read_user_buckets 'max' behavior (Yehuda Sadeh)
* mon: change mds allow_new_snaps syntax to be more consistent (Sage Weil)

You can get v0.77 from the usual locations:

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.77.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy


