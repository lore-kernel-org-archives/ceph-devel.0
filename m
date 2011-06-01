From: Fyodor Ustinov <ufm@ufm.su>
Subject: read vs write. Some tests.
Date: Wed, 01 Jun 2011 17:58:14 +0300
Message-ID: <4DE65386.90209@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:52033 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757985Ab1FAO6S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Jun 2011 10:58:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 860E7600485
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jun 2011 17:58:15 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LjsC8oQHsEq1 for <ceph-devel@vger.kernel.org>;
	Wed,  1 Jun 2011 17:58:15 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 5BAFB600484
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jun 2011 17:58:15 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


ceph - 0.28.2 from repository

client - linux 2.6.39/64

All osd servers have 4G RAM. Journal on 1G tempfs. 2*1G ethernet 
(etherchannel)

client server have 2G RAM. 2*1G ethernet (etherchannel)

In tests used "dd if=/dev/zero of=file bs=8M count=3000" for write and 
"dd if=file of=/dev/null bs=8M count=3000" for read. For rbd instead 
"file" used "/dev/rbd0".
In "ceph fs" additionaly used "iozone -a -y 8M -i 0 -i 1 -i 2 -n25g -g25g"

Tests results:

kernel ceph fs:
dd write:  149.748 s, 168 MB/s
dd read:  451.835 s, 55.7 MB/s
iozone write: 165 MB/s
iozone rewrite:  165 MB/s
iozone randow write: 165 MB/s
iozone read: 53 MB/s
iozone reread: 55 MB/s
iozone random read: 41 MB/s

rbd:
dd wite: 212.583 s, 118 MB/s
dd read: 480.374 s, 52.4 MB/s


Frankly I do not quite understand what was happening.

WBR,
     Fyodor.
