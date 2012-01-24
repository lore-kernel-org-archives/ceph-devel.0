From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] [ceph spec] package *.py* files
Date: Tue, 24 Jan 2012 21:26:17 +0100
Message-ID: <20120124202617.GB32255@homac.suse.de>
References: <orboq2w2vq.fsf@livre.localdomain>
 <loom.20120119T183130-208@post.gmane.org>
 <orehuvp6ce.fsf@livre.localdomain>
 <20120120150342.GB7606@homac.suse.de>
 <or39baosw7.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50083 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756835Ab2AXU0U (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Jan 2012 15:26:20 -0500
Content-Disposition: inline
In-Reply-To: <or39baosw7.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

On Fr 20. Jan - 21:28:56, Alexandre Oliva wrote:
> On Jan 20, 2012, Holger Macht <hmacht@suse.de> wrote:
> 
> > On Thu 19. Jan - 22:26:09, Alexandre Oliva wrote:
> >> On Jan 19, 2012, Holger Macht <hmacht@suse.de> wrote:
> >> 
> >> > Alexandre Oliva <oliva <at> lsd.ic.unicamp.br> writes:
> >> >> 
> >> >> Some post-install rpmbuild defaults byte-compile all packaged python
> >> >> files, so don't bother removing the .pyc files, and package .py* to
> >> >> get both .pyo and .pyc.  It wastes a tiny little bit of space, but it
> >> >> makes the spec file portable across a wider range of rpm and python
> >> >> configurations.
> >> 
> >> > Just wondering...do you have a concrete issue or an example where this is a 
> >> > problem?
> >> 
> >> It failed to build on a BLAGified Fedora 16, complaining about the
> >> unpackaged .pyc files.  It's not just CentOS that creates the .pyc files
> >> in brp-python-bytecompile.  
> 
> > So the built failed because *.pyo was there and *.pyc wasn't?
> 
> No, both were there, but the .pyc was (correctly) flagged as not
> packaged.
> 
> > So maybe we should just always put pyc files in for maximum
> > compatibility across distributions?
> 
> Yeah.
> 
> > Otherwise, if this really makes the build fail for some distributions,
> 
> The CentOS-only .pyc packaging did not cover other distros that required
> it, such as Fedora and BLAG, yes.
> 
> >> Plus, they should be packaged (if at all) in python-ceph, but
> >> definitely not in the main ceph package.
> 
> > They are packaged in python-ceph.
> 
> No, look at the patch.  The ugly work-around to package .pyc files on
> CentOS only was not in python-ceph.

Ok, now I see.

Regards
 Holger
