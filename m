From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: radosgw keeps dying
Date: Sun, 02 Sep 2012 07:36:38 -0600
Message-ID: <50430C8602000099000E95E5@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:45391 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab2IBNgm convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:1:1>);
	Sun, 2 Sep 2012 09:36:42 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q82DYSdV001080
	for <ceph-devel@vger.kernel.org>; Sun, 2 Sep 2012 07:34:28 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 98A2B44CFE
	for <ceph-devel@vger.kernel.org>; Sun,  2 Sep 2012 07:36:39 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One additional piece of info...I did find the "-d" flag (documented in the radosgw-admin man page, but not in the radosgw man page) that keeps the daemon in the foreground and prints messages to stderr.  When I use this flag I get the following:
[root@desktop-ceph ~]# radosgw -c /etc/ceph/ceph.conf -n client.radosgw.gateway -d
2012-09-02 07:35:27.495864 423d6940 -1 Initialization timeout, failed to initialize

I'm not sure where it's timing out, though, what it's trying to contact that it cannot.  Any additional help in getting this going would be greatly appreciated!

-Nick


> So, I'm running ceph 0.48.1, I have my mds, mon, and osds up and running, and now I'm trying to get radosgw
> working, as well.  However, I'm running into an issue where the radosgw daemon runs for a minute and then exits 
> without any explanation - nothing in the log files, system output, etc., to indicate why it's quitting.  If I run "strace" 
> ahead of radosgw I see some "Connection timed out" messages toward the end of the output, but there's no 
> indication as to what it's trying to connect to and why it's failing.  Is there any way to get radosgw to actually log 
> anything, or send some debug output to the console, so I can figure out why it's failing?
> 
> Thanks - Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
