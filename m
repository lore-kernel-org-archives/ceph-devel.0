From: Fyodor Ustinov <ufm@ufm.su>
Subject: cluster status information
Date: Thu, 26 May 2011 15:18:57 +0300
Message-ID: <4DDE4531.6060703@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:34682 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757470Ab1EZMTB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2011 08:19:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id C6411600485
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 15:18:58 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xjxcrjc1XyJw for <ceph-devel@vger.kernel.org>;
	Thu, 26 May 2011 15:18:58 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 517DE600483
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 15:18:58 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

How to get information about status of each server in cluster?

#ceph osd stat
2011-05-26 15:07:05.103621 mon <- [osd,stat]
2011-05-26 15:07:05.104201 mon0 -> 'e413: 6 osds: 5 up, 5 in' (0)

I see - in cluster 6 osd servers and now up only 5.  How do I know which 
server is down?

More global question - how to monitor the state of servers in a cluster?

WBR,
     Fyodor.

P.S. JFYI: key "-s" do not described in manual page about ceph command.
