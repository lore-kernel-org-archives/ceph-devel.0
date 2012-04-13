From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Fri, 13 Apr 2012 22:54:33 +0530
Message-ID: <1334337873.17237.13.camel@indica.cc.iitb.ac.in>
References: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
	 <1332689005.2102.3.camel@jdlaptop.lesbg.loc>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([14.139.97.13]:35499 "EHLO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358Ab2DMRYo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Apr 2012 13:24:44 -0400
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id AFCECC01A16A
	for <ceph-devel@vger.kernel.org>; Fri, 13 Apr 2012 22:54:34 +0530 (IST)
Received: from [10.100.106.210] (indica.cc.iitb.ac.in [10.100.106.210])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.iitb.ac.in (Postfix) with ESMTP id 666D413906
	for <ceph-devel@vger.kernel.org>; Fri, 13 Apr 2012 22:54:34 +0530 (IST)
In-Reply-To: <1332689005.2102.3.camel@jdlaptop.lesbg.loc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi CEPH Developers,

Thanks for your responses. I have been trying your suggestions one
after another. Sorry to report that none of the suggestions work
for me.

Looks like FEDORA is not fit for CEPH experimentation anymore !!
The source RPM for 0.43 and above simply does not build on
FC1[356]. I am not so sure about FC17 since it may bring a host of
other hidden problems.

Can any one pl let me know what other distros one should look at ?
I am really not keen about trying UBUNTU or other DEBIAN derivatives.
What about CENTOS 6.[012] ?

Thanks for your help.

--ajit

On Sun, 2012-03-25 at 18:23 +0300, Jonathan Dieter wrote:
> On Sun, 2012-03-25 at 14:27 +0530, Ajit K Jena wrote:
> > Hello All,
> > 
> > I have lost touch with the growth of ceph after version 0.30.
> > I am trying to compile version 0.43 and 0.44 on FC13 and FC15.
> 
> FWIW, we've pushed 0.43 in Fedora 17. We don't have anything later than
> 0.41 in versions lower than 17 because of Fedora's updates policies.  
> 
> However, you could take the source rpm from F17 and rebuild it for older
> versions of Fedora.
> 
> It's available at
> http://kojipkgs.fedoraproject.org/packages/ceph/0.43/1.fc17/src/ceph-0.43-1.fc17.src.rpm
> 
> I'll probably push 0.44 to F17 once I manage to get the RPM built.
> 
> Jonathan


