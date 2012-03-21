From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Clocks Not Synchronized
Date: Wed, 21 Mar 2012 09:30:34 -0600
Message-ID: <4F699FBA02000099000DD40B@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:51228 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172Ab2CUPag convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:1:1>);
	Wed, 21 Mar 2012 11:30:36 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q2LGQJwr020856
	for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 10:26:19 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 7F2B844C59
	for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 09:30:35 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm setting up ceph and looking at the output of "ceph -w" and I'm seeing lots of warnings about messages from mon.X being stamped in the future (142 seconds), clocks not synchronized.  However, all of these systems use NTP, and if I use the "date" command to see the system time, they are definitely synchronized to within a second or so - definitely not out of sync 142 seconds.  What else should I check?

Thanks - Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
