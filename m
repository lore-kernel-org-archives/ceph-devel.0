From: Fyodor Ustinov <ufm@ufm.su>
Subject: different osds
Date: Sun, 22 May 2011 22:50:58 +0300
Message-ID: <4DD96922.2080409@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:35135 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab1EVTvE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 22 May 2011 15:51:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 9F9BB600485
	for <ceph-devel@vger.kernel.org>; Sun, 22 May 2011 22:51:00 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OBYigXUgaKSI for <ceph-devel@vger.kernel.org>;
	Sun, 22 May 2011 22:51:00 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 6C3B2600483
	for <ceph-devel@vger.kernel.org>; Sun, 22 May 2011 22:51:00 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Let's say I have 6 osd. 5 of them are the same, 6 - has twice the amount 
of disk size.

Should I somehow specifically describe it in CRUSH mapor seph will 
understand without it?

WBR,
    Fyodor.

P.S. I'd like to receive "secret knowledge" about the "weight" in crush 
map. :)
