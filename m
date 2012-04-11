From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Can we have mutiple OSD in a single machine
Date: Wed, 11 Apr 2012 07:42:17 +0000 (UTC)
Message-ID: <loom.20120411T093935-734@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35106 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab2DKHmf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Apr 2012 03:42:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SHsCG-0004IU-4h
	for ceph-devel@vger.kernel.org; Wed, 11 Apr 2012 09:42:32 +0200
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 09:42:32 +0200
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 09:42:32 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I have a system with 2T SATA drive and I want to add it to my ceph 
cluster. I was thinking instead of creating one large OSD, can't
I have 44 osd's of 450G each ? Is this possible ? if possible, will 
this improve read/write performance ?

Thanks
__Madhusudhana

