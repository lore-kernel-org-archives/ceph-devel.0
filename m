From: <Eric_YH_Chen@wistron.com>
Subject: Ceph based on ext4
Date: Thu, 29 Dec 2011 17:42:22 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49DB0E5A3@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw5.wistron.com ([220.128.89.25]:63565 "EHLO
	TWNHUMSW5.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab1L2Jm2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2011 04:42:28 -0500
Received: from twnhufe3.whq.wistron (unverified [10.37.31.103]) by TWNHUMSW5.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta197550e65c0a8167315b8@TWNHUMSW5.wistron.com> for <ceph-devel@vger.kernel.org>;
 Thu, 29 Dec 2011 17:44:28 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all:

    We want to test the stability and performance of ceph with ext4 file
system.
    Here is the information from `mount`,  do we set all attributes
correct?
	
    /dev/sda1 on /srv/osd.0 type ext4
(rw,noatime,nodiratime,errors=remount-ro,data=writeback,user_xattr)

	And from the tutorial at
http://ceph.newdream.net/wiki/Creating_a_new_file_system
	We also disable the journal functionality by ` tune2fs -O
^has_journal /dev/sda1`
     
    Any extra comment to get better performance? Thanks!
