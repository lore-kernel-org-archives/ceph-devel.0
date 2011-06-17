From: Fyodor Ustinov <ufm@ufm.su>
Subject: inconsistent chunk
Date: Fri, 17 Jun 2011 08:20:54 +0300
Message-ID: <4DFAE436.9060606@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:34492 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab1FQFU6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Jun 2011 01:20:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 69CEF600485
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2011 08:20:56 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCfO9jSzblsE for <ceph-devel@vger.kernel.org>;
	Fri, 17 Jun 2011 08:20:56 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 4337B600483
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2011 08:20:55 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I have inconsistent chunk:

2011-06-17 08:11:33.844030    pg v26069: 2376 pgs: 2375 active+clean, 1 
active+clean+inconsistent; 285 GB data, 572 GB used, 24180 GB / 25494 GB 
avail

Questions:
1. What does this mean?
2. How to learn what kind of file is damaged?
3. Delete damaged file should fix it?
4. Can I recover the data without backup?


WBR,
     Fyodor.
