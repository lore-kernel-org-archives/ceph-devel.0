From: Wido den Hollander <wido@42on.com>
Subject: Blocking rados_* calls
Date: Thu, 10 Oct 2013 13:50:48 +0200
Message-ID: <52569498.2090109@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:39704 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab3JJLuu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Oct 2013 07:50:50 -0400
Received: from [192.168.9.107] (unknown [109.72.87.204])
	by websrv.42on.com (Postfix) with ESMTPSA id C132FC9A1A
	for <ceph-devel@vger.kernel.org>; Thu, 10 Oct 2013 13:50:48 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Currently librados blocks all calls when something is not working inside 
the Ceph cluster.

This is common practice for fopen(), fread() and fwrite(), but I'm 
running into a use-case where I think the rados_connect() should not 
block indefinitely.

The use-case here is the RBD storage pool in libvirt. When for whatever 
reason libvirt is not able to connect to the Ceph cluster libvirt will 
simply block and wait on rados_connect() to complete.

This causes libvirt not being able to report new statistics about the 
RBD storage pool, which causes issues again for the applications using it.

Would it be an idea that you can configure librados not to block 
indefinitely and return for example ETIMEDOUT?

By default librados could stay blocking like it's now so nothing changes 
for existing users.

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
