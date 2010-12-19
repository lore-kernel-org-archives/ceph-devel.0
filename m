From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: Example of RADOS AIO?
Date: Sun, 19 Dec 2010 20:05:50 +0900
Message-ID: <7D2A2270-AEE9-4FE2-810F-E84BC0B2BD6A@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56921 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062Ab0LSLFw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Dec 2010 06:05:52 -0500
Received: by pva4 with SMTP id 4so401860pva.19
        for <ceph-devel@vger.kernel.org>; Sun, 19 Dec 2010 03:05:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, 

Is there any example of asynchronous IO on RADOS (librados)? When I write some bytes to an object, I'm only interested on the ack, which means writes are applied to all the OSDs within the same placement group but not yet committed to the disks. I'll use this feature to write HBase journals. 

Thanks, 
Tatsuya 


--
Tatsuya Kawano (Mr.)
Tokyo, Japan

http://twitter.com/#!/tatsuya6502


