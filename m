From: Fyodor Ustinov <ufm@ufm.su>
Subject: rbd speed: write vs read
Date: Fri, 06 May 2011 16:58:21 +0300
Message-ID: <4DC3FE7D.3090903@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:48727 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753625Ab1EFN6X (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2011 09:58:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 1F2B060023E
	for <ceph-devel@vger.kernel.org>; Fri,  6 May 2011 16:58:22 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6AZA2xILl2va for <ceph-devel@vger.kernel.org>;
	Fri,  6 May 2011 16:58:22 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id A22C4600238
	for <ceph-devel@vger.kernel.org>; Fri,  6 May 2011 16:58:21 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

root@stb1:~# dd if=/dev/zero of=/dev/rbd0 bs=10240000
^C13217+0 records in
13217+0 records out
135342080000 bytes (135 GB) copied, 1135.75 s, 119 MB/s

root@stb1:~# dd if=/dev/rbd0 of=/dev/null bs=10240000
^C930+0 records in
929+0 records out
9512960000 bytes (9.5 GB) copied, 394.773 s, 24.1 MB/s

It's my misconfiguration?

P.S. 20 OSD servers, 2*1G ether.

WBR,
     Fyodor.
