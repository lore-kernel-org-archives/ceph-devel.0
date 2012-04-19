From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Thu, 19 Apr 2012 16:30:49 +0530
Message-ID: <1334833249.17770.36.camel@indica.cc.iitb.ac.in>
References: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
	 <1332689005.2102.3.camel@jdlaptop.lesbg.loc>
	 <1334337873.17237.13.camel@indica.cc.iitb.ac.in>
	 <alpine.LFD.2.02.1204140209460.13159@stderr.seidelnet.de>
	 <1334402200.3126.17.camel@jdlaptop.lesbg.loc>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:37236 "EHLO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601Ab2DSLBL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Apr 2012 07:01:11 -0400
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 58411C081867
	for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 16:30:53 +0530 (IST)
Received: from [10.100.106.210] (indica.cc.iitb.ac.in [10.100.106.210])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.iitb.ac.in (Postfix) with ESMTP id B3F4213906
	for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 16:30:49 +0530 (IST)
In-Reply-To: <1334402200.3126.17.camel@jdlaptop.lesbg.loc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear List,

I have been able to get things going on CentOS 6.0. Have
been able to set up a small prototype based on CEPH 0.45
version.

Just wanted to post here for records so that it may benefit
someone else.

--ajit

On Sat, 2012-04-14 at 14:16 +0300, Jonathan Dieter wrote:
> On Sat, 2012-04-14 at 02:30 +0200, Udo Seidel wrote:
> > Hi Ajit,
> > I have successfully built 0.43 and 0.45 on Fedora 16 (last Fedora updates 
> > installed on Thursday). I suggest to try again with either of these 
> > versions. I have used the src.rpm packages from here: 
> > kojipkgs.fedoraproject.org/packages/ceph/
> > Good luck,
> > Udo
> 
> +1
> 
> The source RPMs for Fedora 17 should rebuild just fine for Fedora 15 and
> 16.
> 
> Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


