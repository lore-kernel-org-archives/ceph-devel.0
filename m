From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: leveldb build issues in 0.44
Date: Sun, 25 Mar 2012 08:18:11 -0600
Message-ID: <4F6ED4C302000099000DD8BD@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:55855 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755425Ab2CYOSO convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Sun, 25 Mar 2012 10:18:14 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q2PFEMOq001567
	for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 09:14:22 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 370AF44C5F
	for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 08:18:13 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: oliva@lsd.ic.unicamp.br, sage@newdream.net
Cc: ceph-devel@vger.kernel.org

Sorry for the delay - just now got back to trying out this patch.  It seems to work - leveldb compiles correctly.  I have not finished the build process, yet, so once it is completed I will respond and you know for sure.

-Nick

>>> Sage Weil  03/23/12 6:28 PM >>>
Hey Nick-

Can you confirm this fixes your problem?  If so I can apply this to the 
stable branch (for 0.44.1).

Thanks!
sage


On Thu, 22 Mar 2012, Alexandre Oliva wrote:

> On Mar 22, 2012, "Nick Couchman"  wrote:
> 
> > ./db/builder.h:8:28: fatal error: leveldb/status.h: No such file or directory
> > compilation terminated.
> 
> > This is an RPM build
> 
> This patch fixed it for me.
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
