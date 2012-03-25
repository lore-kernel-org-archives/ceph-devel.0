From: Sage Weil <sage@newdream.net>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Sun, 25 Mar 2012 08:40:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203250834500.23214@cobra.newdream.net>
References: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
 <1332689005.2102.3.camel@jdlaptop.lesbg.loc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37057 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241Ab2CYPkF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Mar 2012 11:40:05 -0400
In-Reply-To: <1332689005.2102.3.camel@jdlaptop.lesbg.loc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Dieter <jdieter@lesbg.com>
Cc: ceph-devel@vger.kernel.org

Hi Jonathan,

On Sun, 25 Mar 2012, Jonathan Dieter wrote:
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

I just pushed two patches to the stable branch that should address this: 
d3bcac241f25f681a585c2115a79befe43dd7d6c and 
3ab28950beabe9d452da35ec2f2d583751764a9a.  Can you verify the problem goes 
away?

Thanks!
sage
