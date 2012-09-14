From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: safe to defrag XFS on live system?
Date: Fri, 14 Sep 2012 11:15:25 -0600
Message-ID: <505311CD02000099000EA409@collaborate.seakr.com>
References: <CACkq2moNPAopPQ1KRSd_v0Dm6wrkV3xS-2X-qWgu=BP98rSKCg@mail.gmail.com>
 <CADvuQREvqUG0Xe7gf_LMtXsvZMxX88TT7imi8Cfj2ihA0s+VeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:45233 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757023Ab2INRPd convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Fri, 14 Sep 2012 13:15:33 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q8EH9pWk008713
	for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 11:09:52 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 14FAE44D0C
	for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 11:15:28 -0600 (MDT)
In-Reply-To: <CADvuQREvqUG0Xe7gf_LMtXsvZMxX88TT7imi8Cfj2ihA0s+VeQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>, Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

> 
>> While I'm talking about XFS...  I know that RBD's use a default object
>> size of 4MB.  I've stuck with that so far..  Would it be beneficial to
>> mount XFS with -o allocsize=4M ?  What is the object size that gets
>> used for non-RBD cases -- i.e. just dumping objects into data pool?
> 
> Don't know about -o allocsize -- benchmark it!

...and let us know what you come up with!  I'm also using XFS for the underlying filesystem on which CEPH runs (and using RBD), and would be really interested to know if changing the alloc size improves performance!

-Nick




--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
