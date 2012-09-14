From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: safe to defrag XFS on live system?
Date: Fri, 14 Sep 2012 12:56:19 -0600
Message-ID: <5053297302000099000EA41C@collaborate.seakr.com>
References: <CACkq2moNPAopPQ1KRSd_v0Dm6wrkV3xS-2X-qWgu=BP98rSKCg@mail.gmail.com>
 <CADvuQREvqUG0Xe7gf_LMtXsvZMxX88TT7imi8Cfj2ihA0s+VeQ@mail.gmail.com>
 <505311CD02000099000EA409@collaborate.seakr.com>
 <50537C21.2060001@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:45316 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759901Ab2INS4W convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Fri, 14 Sep 2012 14:56:22 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q8EIohNT010289
	for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 12:50:44 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 3E1D044D0C
	for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 12:56:21 -0600 (MDT)
In-Reply-To: <50537C21.2060001@inktank.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Travis Rhoden <trhoden@gmail.com>, Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

> 
> Hi Guys,
> 
> There was a change 2.6.38 to the way that speculative preallocation 
> works that basically lets small writes behave like allocsize is not set, 
> and large writes behave like a large one is set:
> 
> http://permalink.gmane.org/gmane.comp.file-systems.xfs.general/38403
> 
> Having said that, I had my test gear all ready to go so I decided to 
> give it a try:
> 
> Setup:
> 
> - 1 node
> - 6 OSDs with 7200rpm data disks.
> - Journals on 2 Intel 520 SSDs (3 per SSD)
> - LSI SAS2008 Controller (9211-8i)
> - Network: Localhost
> - Ceph 0.50
> - Ubuntu 12.04
> - Kernel 3.4
> - XFS mkfs options: -f -i size=2048
> - Common XFS mount options: -o noatime
> - No replication
> - 8 concurrent rados bench instances.
> - 32 concurrent 4MB ops per instance (256 concurrent ops total)
> 
> Without allocsize=4M:
> 
> 781.454MB/s
> 
> With allocsize=4M:
> 
> 453.335MB/s
> 
> I'm guessing that it's perhaps slower as we've told XFS to optimize for 
> large files, but the metadata in /meta is very small, and we were 
> already getting benefits from the new speculative preallocation patches 
> that were introduced in 2.6.38 to combat fragmentation of the 4MB objects.
> 
> Mark

Interesting, thanks for the results, Mark.  So, I guess don't tune unless you have a very good reason to do so?  Or, if you're really going to try to squeeze all the performance possible, put your metadata on a separate FS with a different alloc size (or no alloc size specified) so that metadata access isn't adversely impacted by trying to tune data access?

-Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
