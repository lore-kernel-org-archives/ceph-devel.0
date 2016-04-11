From: Sage Weil <sage@redhat.com>
Subject: Deprecating ext4 support
Date: Mon, 11 Apr 2016 17:39:37 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52372 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbcDKVjk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 17:39:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Hi,

ext4 has never been recommended, but we did test it.  After Jewel is out, 
we would like explicitly recommend *against* ext4 and stop testing it.

Why:

Recently we discovered an issue with the long object name handling that is 
not fixable without rewriting a significant chunk of FileStores filename 
handling.  (There is a limit in the amount of xattr data ext4 can store in 
the inode, which causes problems in LFNIndex.)

We *could* invest a ton of time rewriting this to fix, but it only affects 
ext4, which we never recommended, and we plan to deprecate FileStore once 
BlueStore is stable anyway, so it seems like a waste of time that would be 
better spent elsewhere.

Also, by dropping ext4 test coverage in ceph-qa-suite, we can 
significantly improve time/coverage for FileStore on XFS and on BlueStore.

The long file name handling is problematic anytime someone is storing 
rados objects with long names.  The primary user that does this is RGW, 
which means any RGW cluster using ext4 should recreate their OSDs to use 
XFS.  Other librados users could be affected too, though, like users 
with very long rbd image names (e.g., > 100 characters), or custom 
librados users.

How:

To make this change as visible as possible, the plan is to make ceph-osd 
refuse to start if the backend is unable to support the configured max 
object name (osd_max_object_name_len).  The OSD will complain that ext4 
cannot store such an object and refuse to start.  A user who is only using 
RBD might decide they don't need long file names to work and can adjust 
the osd_max_object_name_len setting to something small (say, 64) and run 
successfully.  They would be taking a risk, though, because we would like 
to stop testing on ext4.

Is this reasonable?  If there significant ext4 users that are unwilling to 
recreate their OSDs, now would be the time to speak up.

Thanks!
sage

