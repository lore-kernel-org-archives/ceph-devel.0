From: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Subject: Ceph behavior in case of network failure
Date: Sun, 29 Jan 2012 04:52:40 +0000 (UTC)
Message-ID: <loom.20120129T054836-318@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60330 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab2A2FS3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 29 Jan 2012 00:18:29 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1RrMrz-0001C3-97
	for ceph-devel@vger.kernel.org; Sun, 29 Jan 2012 06:00:03 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 29 Jan 2012 06:00:03 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 29 Jan 2012 06:00:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have configured ceph in centos5.6 after a 
very long fight. Now, i am in the way 
to evaluate the Ceph. Forget me if my 
question looks amateur. If we consider a 
situation where my core switch fails, 
resulting in n/w failure in entire data 
center. What happens to ceph cluster ? 
will it sustain this n/w failure and comes 
online when the n/w is restored ? 

