From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: radosgw keeps dying
Date: Sat, 01 Sep 2012 23:34:10 -0600
Message-ID: <50429B7202000099000E95DE@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:60271 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab2IBFeO convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:1:1>);
	Sun, 2 Sep 2012 01:34:14 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q825W6La001422
	for <ceph-devel@vger.kernel.org>; Sat, 1 Sep 2012 23:32:06 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 9584044CFC
	for <ceph-devel@vger.kernel.org>; Sat,  1 Sep 2012 23:34:11 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

So, I'm running ceph 0.48.1, I have my mds, mon, and osds up and running, and now I'm trying to get radosgw working, as well.  However, I'm running into an issue where the radosgw daemon runs for a minute and then exits without any explanation - nothing in the log files, system output, etc., to indicate why it's quitting.  If I run "strace" ahead of radosgw I see some "Connection timed out" messages toward the end of the output, but there's no indication as to what it's trying to connect to and why it's failing.  Is there any way to get radosgw to actually log anything, or send some debug output to the console, so I can figure out why it's failing?

Thanks - Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
