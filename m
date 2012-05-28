From: chandrashekhar <chandubigc@gmail.com>
Subject: OSD per disk.
Date: Mon, 28 May 2012 06:19:17 +0000 (UTC)
Message-ID: <loom.20120528T080903-621@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49230 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409Ab2E1GUG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 May 2012 02:20:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SYtJD-0005aD-33
	for ceph-devel@vger.kernel.org; Mon, 28 May 2012 08:20:03 +0200
Received: from segment-124-30.sify.net ([segment-124-30.sify.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 28 May 2012 08:20:03 +0200
Received: from chandubigc by segment-124-30.sify.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 28 May 2012 08:20:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

      I want to setup a ceph cluster with 4 osds ( one OSD per disk), 2 mons, 1
mds. Please help me to configure this.

I have a machine with following hardware:

4 hard disks ( each 500GB).

/dev/sda - 500G ( OS )  
/dev/sdb - 500G
/dev/sdc - 500G
/dev/sdd - 500G


OS: ubuntu 12.O4 server ( 64 bit )




Thanks,
Chandra.

