From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Upgrading ceph cluster from 0.39 to 0.43
Date: Tue, 13 Mar 2012 06:50:51 +0000 (UTC)
Message-ID: <loom.20120313T074801-277@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55632 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab2CMGvG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Mar 2012 02:51:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7LZU-0003Kk-G5
	for ceph-devel@vger.kernel.org; Tue, 13 Mar 2012 07:51:00 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 07:51:00 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 07:51:00 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I am seeing serious delay in data copying in my ceph cluster. I would 
like to know if upgrding ceph cluster from 0.39 to 0.43 will resolve
this issue ? if yes, then what the correct procedure for upgrading 
the cluster without affecting the existing data ?

Thanks
Madhusudhan

