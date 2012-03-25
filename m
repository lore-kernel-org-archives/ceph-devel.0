From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Sun, 25 Mar 2012 16:17:08 +0530
Message-ID: <1332672428.9164.7.camel@indica.cc.iitb.ac.in>
References: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
	 <4F6EEFF7.4020901@widodh.nl>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:34589 "EHLO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755622Ab2CYKrK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 25 Mar 2012 06:47:10 -0400
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id CBF52C01AB82
	for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 16:17:08 +0530 (IST)
In-Reply-To: <4F6EEFF7.4020901@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

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


