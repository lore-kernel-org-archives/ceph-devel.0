From: xinren <tntinfo@hotmail.com>
Subject: =?utf-8?b?c2V0X2xheW91dA==?=
Date: Fri, 27 Apr 2012 17:25:31 +0000 (UTC)
Message-ID: <loom.20120427T181902-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52028 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757973Ab2D1CZG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 Apr 2012 22:25:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SNxLL-0002kW-Ro
	for ceph-devel@vger.kernel.org; Sat, 28 Apr 2012 04:25:04 +0200
Received: from c-98-221-149-4.hsd1.nj.comcast.net ([98.221.149.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 28 Apr 2012 04:25:03 +0200
Received: from tntinfo by c-98-221-149-4.hsd1.nj.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 28 Apr 2012 04:25:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All,

I try to use cephfs to set up 
various parameters, such as 

cephfs /cephdir set_layout -s 8388608 -c 1 -u 8388608 -o 1

In this case, the "preferred osd" will be 1. I then copy files to /cephdir. I 
found that stripe_unit is 8MByte. However, files are copies to different OSDs (I 
have 4 OSDs). Is there any way that I copy a file to a designate OSD? Thanks in 
advance.

Regards

Xinren



