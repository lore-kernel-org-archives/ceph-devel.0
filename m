From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: timed out in osd1 error in dmes
Date: Tue, 13 Mar 2012 07:35:35 +0000 (UTC)
Message-ID: <loom.20120313T083325-276@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38557 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595Ab2CMHfv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Mar 2012 03:35:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7MGp-00086B-EE
	for ceph-devel@vger.kernel.org; Tue, 13 Mar 2012 08:35:47 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 08:35:47 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 08:35:47 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
The server in which i have mounted file system using mount -t ceph
is showing below errors in dmesg.


libceph:  tid 79987 timed out on osd2, will reset osd
libceph:  tid 81516 timed out on osd0, will reset osd
libceph:  tid 81133 timed out on osd1, will reset osd
libceph: skipping osd1 10.25.12.127:6800 seq 1 expected 2
libceph:  tid 80108 timed out on osd2, will reset osd
libceph:  tid 81134 timed out on osd1, will reset osd
libceph:  tid 81641 timed out on osd1, will reset osd


Is is because of this, write/copy operation in my cluster
is slow ? is this a error which needs attention or can be
safely ignored ?

Thanks
Madhusudhan

