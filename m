From: Steena Monteiro <steena.m@aggiemail.usu.edu>
Subject: Creating the filesystem and tweaking configurations
Date: Mon, 28 Mar 2011 19:54:13 +0000 (UTC)
Message-ID: <loom.20110328T213028-664@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47109 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab1C1Tyd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Mar 2011 15:54:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Q4IWC-00054u-Q1
	for ceph-devel@vger.kernel.org; Mon, 28 Mar 2011 21:54:28 +0200
Received: from 129.123.7.74 ([129.123.7.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 21:54:28 +0200
Received: from steena.m by 129.123.7.74 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 21:54:28 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

1) I used apt-get to procure and install Ceph excluding the standalone 
client on
Lucid Lynx. I obtained built the  client using instructions 
on the Ceph wiki and
it worked fine after I reverted certain commits. However, mkcephfs (from: $
/usr/sbin/mkcephfs -c /etc/ceph/ceph.conf --allhosts -v) has been breaking:

2011-03-28 13:23:23.596948 b77b16d0 OSD::mkfs: 
couldn't mount FileStore: error -95
2011-03-28 13:23:23.597008 b77b16d0  ** ERROR: 
error creating empty object store
in /data/osd0: error 95: Operation not supported
failed: '/usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
/tmp/mkcephfs.DZdhzxPY5k/monmap.24380 -i 0 --mkfs --osd-data /data/osd0'

Additionally, I checked and /data/osd0 does exist...

2) I want to be able to tune Ceph's configuration 
parameters (located in
config.cc within the Ceph source) and see how each 
configuration change impacts Ceph's performance.
However, I am not certain how changes in the ceph source
code will be reflected in the standalone-client in terms of 
Ceph's performance.
Is there a suggested way I could work to accomplish changing parameters in the
source in order to have the file system impacted by these changes?

I'd appreciate your help!

Thanks in advance,
Steena

