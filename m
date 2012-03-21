From: "Plaetinck, Dieter" <dieter@vimeo.com>
Subject: non-btrfs and checksumming, rados tutorial, planning wrt
 documentation
Date: Wed, 21 Mar 2012 19:23:26 +0100
Message-ID: <20120321192326.1d598442@dieter-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ny-iacmail.iac.com ([63.119.10.45]:56634 "EHLO
	ny-iacmail.iac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab2CUSZQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 14:25:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

1) if you don't use btrfs (i.e. xfs) will checksumming still be done? by the OSD's? does the checksumming happen on every data read, or do underused OSD's also checksum their data in the background? (like openstack swift does).  if checksum mismatch, what does the client see, and what actions are taken? for example if you use librados, will the librados api return the read data to the user (even if known to be invalid), throw an error, or will librados try to read from other nodes first to try to return the valid data?) will the disk be marked as failed, or will the system attempt to overwrite the bad file with a good copy?

2) I'm trying to set up basic rados distributed object storage cluster. I've successfully
followed http://ceph.newdream.net/wiki/Installing_on_RedHat_or_CentOS, but now I'm stuck trying to configure and actually run the thing.
(I didn't modify the prefix and the various *dir configure arguments, as I think /usr/local is the best location, for now)
I found http://ceph.newdream.net/wiki/Simple_test_setup but it's more than 2 years old, the workingdir.conf it refers to doesn't exist anymore.
is a matter of copying src/sample.ceph.conf to /usr/local/etc, modifying it, and then?
How to set up a basic rados cluster?

3) I saw in the "lords of ceph" footage somebody mentioning work would start on improving the docs.  Is there any concrete planning on this you can share?

thanks,
Dieter
