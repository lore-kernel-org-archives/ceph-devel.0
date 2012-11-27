From: brady <brady@lamphost.com>
Subject: Character limit for rbd block device
Date: Mon, 26 Nov 2012 16:10:02 -0800
Message-ID: <50B404DA.50805@lamphost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tux2.lamphost.net ([69.43.195.67]:40570 "EHLO tux2.lamphost.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab2K0AjZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 26 Nov 2012 19:39:25 -0500
Received: from rrcs-64-183-4-86.west.biz.rr.com ([64.183.4.86]:57792 helo=[192.168.1.17])
	by tux2.lamphost.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <brady@lamphost.com>)
	id 1Td8o1-000448-9y
	for ceph-devel@vger.kernel.org; Mon, 26 Nov 2012 16:13:41 -0800
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,
     I have a general question. Is there a specific character limit for 
rbd block devices? In attempting to map a block device with a name that 
is 36 characters or more, I am getting the following error:

rbd map (36+ character name) --user admin --secret /etc/ceph/keyring.key
add failed: (2) No such file or directory

     When using the same command to map a device with 35 characters or 
less, the device is mapped as expected. Any insight into this issue 
would be greatly appreciated.

-Brady
