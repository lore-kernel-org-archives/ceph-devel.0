From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Sun, 25 Mar 2012 08:05:01 -0600
Message-ID: <4F6ED1AD02000099000DD8B7@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:45950 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634Ab2CYOFF convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:2:1>);
	Sun, 25 Mar 2012 10:05:05 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q2PF1CE1001497
	for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 09:01:13 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 8AD6544C5E
	for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 08:05:03 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ajit@iitb.ac.in, wido@widodh.nl
Cc: ceph-devel@vger.kernel.org

Ajit,
Did you see my previous post to the list about leveldb build issues in 0.44?  This is an issue specifically with rpmbuild, with the spec file.  If you check out the list archives you'll see that Alexandre posted a patch for the spec file that fixes the rpmbuild (have not tried it, yet - just about to do that).

-Nick

>>> Ajit K Jena  03/25/12 4:47 AM >>>
Hi Wido,

Thanx for your response.

No. I just downloaded the bz2 compressed tar file and
tried rpmbuild. 

Just when and where do I run the git commands ? I had
never done this from version 0.20 till 0.31. Why now ?
In any case I get the following response when I run it:

fatal: Not a git repository (or any of the parent directories): .git

Regards.

--ajit

On Sun, 2012-03-25 at 12:14 +0200, Wido den Hollander wrote:
> Hi,
> 
> On 03/25/2012 10:57 AM, Ajit K Jena wrote:
> > Hello All,
> >
> > I have lost touch with the growth of ceph after version 0.30.
> > I am trying to compile version 0.43 and 0.44 on FC13 and FC15.
> > It does not build successfully. I get the following error:
> >
> >     make[3]: *** No rule to make target `leveldb/libleveldb.a', needed by
> > `ceph-osd'.  Stop.
> >     make[3]: *** Waiting for unfinished jobs....
> >
> > I have the following questions:
> >
> >    a) What is this error about ? Has CEPH dropped Fedora as a target
> >       OS platform ?
> >
> >    b) What is the best suited OS for building/testing CEPH prototypes ?
> >
> > Thanks for your attention.
> 
> Did you init the GIT submodules?
> 
> $ git submodule init
> $ git submodule update
> 
> Wido
> 
> >
> > --ajit
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
