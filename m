From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: safe to defrag XFS on live system?
Date: Fri, 14 Sep 2012 14:01:05 -0600
Message-ID: <505338A102000099000EA428@collaborate.seakr.com>
References: <CACkq2moNPAopPQ1KRSd_v0Dm6wrkV3xS-2X-qWgu=BP98rSKCg@mail.gmail.com>
 <CADvuQREvqUG0Xe7gf_LMtXsvZMxX88TT7imi8Cfj2ihA0s+VeQ@mail.gmail.com>
 <505311CD02000099000EA409@collaborate.seakr.com>
 <50537C21.2060001@inktank.com>
 <5053297302000099000EA41C@collaborate.seakr.com>
 <50538A9A.70609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:44471 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932443Ab2INUBJ convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Fri, 14 Sep 2012 16:01:09 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q8EJtTla011523
	for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 13:55:30 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 54A6F44D0B
	for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 14:01:06 -0600 (MDT)
In-Reply-To: <50538A9A.70609@inktank.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Travis Rhoden <trhoden@gmail.com>, Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

>>
>> Interesting, thanks for the results, Mark.  So, I guess don't tune unless 
> you have a very good reason to do so?  Or, if you're really going to try to 
> squeeze all the performance possible, put your metadata on a separate FS with 
> a different alloc size (or no alloc size specified) so that metadata access 
> isn't adversely impacted by trying to tune data access?
>>
>> -Nick
> 
> Well, the XFS guys certainly suggest default tuning in most cases... :)
> 
> http://xfs.org/index.php/XFS_FAQ#Q:_I_want_to_tune_my_XFS_filesystems_for_.3
> Csomething.3E
> 
> I think there is value in investigating things when you suspect a 
> problem though!
> 
> We've tried putting the meta directory on alternate partitions (note: 
> this isn't a good idea with btrfs). It hasn't really done much in some 
> of the tests we've done, but we weren't looking at testing this specific 
> scenario.
> 
> I think the bigger question is, what problem are you trying to solve? 
> Are you noticing lots of fragmentation?  Slow performance with 4MB 
> writes?  slow performance with small IO?
> 

Agreed...and, since there's not really a problem I'm addressing at this point, sticking with the defaults is my best bet.  I was merely curious as to how to get the maximum performance.  If I see problems, maybe I'll dig into it a big, but, at this point, there's no reason to mess with the defaults, at least in my scenarios.

-Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
