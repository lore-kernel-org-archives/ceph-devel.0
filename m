From: proguest <proguest1942@hotmail.com>
Subject: rados gateway
Date: Wed, 17 Apr 2013 14:54:03 +0000 (UTC)
Message-ID: <loom.20130417T164538-81@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39300 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966592Ab3DQOyR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Apr 2013 10:54:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1USTkV-0003ki-Lk
	for ceph-devel@vger.kernel.org; Wed, 17 Apr 2013 16:54:16 +0200
Received: from 114-44-219-144.dynamic.hinet.net ([114.44.219.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 16:54:15 +0200
Received: from proguest1942 by 114-44-219-144.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 16:54:15 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,
I really need some help for my ceph radosgw.
stuck on it for a really long time.

I followed by the ceph document
http://ceph.com/docs/master/start/quick-rgw/

without any error or warnimg.

i can even use radosgw-admin to create user successfully.

But, I cant get into cephfs neither S3 nor swift.

#swift -A http://<radosgw-host>/auth -U <user> -K <key> post test

only responded Auth GET failed: http://<radosgw-host>:80 404 Not Found 

How can I solve this problem...? I really need a help 

thanks a lot

