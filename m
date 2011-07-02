From: Fyodor Ustinov <ufm@ufm.su>
Subject: Read speed. again.
Date: Sat, 02 Jul 2011 21:03:59 +0300
Message-ID: <4E0F5D8F.6050000@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:53859 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab1GBSED (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 2 Jul 2011 14:04:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 69D15600484
	for <ceph-devel@vger.kernel.org>; Sat,  2 Jul 2011 21:04:00 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCFJsPNiQDOf for <ceph-devel@vger.kernel.org>;
	Sat,  2 Jul 2011 21:04:00 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 4DC0C600447
	for <ceph-devel@vger.kernel.org>; Sat,  2 Jul 2011 21:04:00 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

ceph 0.30

the rate of re-reading the file 10G. 13 OSD servers (ie the file is 
already in the cache in OSD servers).

cfuse: 118 MB/s

kenel (3.0.0-rc3): 84.0 MB/s

:(

WBR,
     Fyodor.
