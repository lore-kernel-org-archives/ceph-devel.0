From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] [ceph spec] package *.py* files
Date: Fri, 20 Jan 2012 16:03:42 +0100
Message-ID: <20120120150342.GB7606@homac.suse.de>
References: <orboq2w2vq.fsf@livre.localdomain>
 <loom.20120119T183130-208@post.gmane.org>
 <orehuvp6ce.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52479 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692Ab2ATPDp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Jan 2012 10:03:45 -0500
Content-Disposition: inline
In-Reply-To: <orehuvp6ce.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

On Thu 19. Jan - 22:26:09, Alexandre Oliva wrote:
> On Jan 19, 2012, Holger Macht <hmacht@suse.de> wrote:
> 
> > Alexandre Oliva <oliva <at> lsd.ic.unicamp.br> writes:
> >> 
> >> Some post-install rpmbuild defaults byte-compile all packaged python
> >> files, so don't bother removing the .pyc files, and package .py* to
> >> get both .pyo and .pyc.  It wastes a tiny little bit of space, but it
> >> makes the spec file portable across a wider range of rpm and python
> >> configurations.
> 
> > Just wondering...do you have a concrete issue or an example where this is a 
> > problem?
> 
> It failed to build on a BLAGified Fedora 16, complaining about the
> unpackaged .pyc files.  It's not just CentOS that creates the .pyc files
> in brp-python-bytecompile.  

So the built failed because *.pyo was there and *.pyc wasn't? That is
really strange, because I really don't think both are needed. But sure,
there might be python configurations out there I don't know of, which
can't handle pyo but can do fine with pyc. So maybe we should just
always put pyc files in for maximum compatibility across distributions?

Otherwise, if this really makes the build fail for some distributions,
go for it. I will not argue about the different build systems because 1)
I don't know enough about them (including the one from SUSE) and 2) I
don't won't to dig to deep because of some minor issue like this.

> Plus, they should be packaged (if at all) in python-ceph, but
> definitely not in the main ceph package.

They are packaged in python-ceph.

> Another issue I forgot while posting the patch was that there was not a
> .tar.bz2 available from the ceph site.  I ended up recompressing the .gz
> as .bz2, but if ceph is going to be released compressed as .gz, the spec
> file ought to be adjusted to reflect that.

My fault. I also recompressed them at the very start of working on the
spec file and changed it accordingly, but I'm fine for changing this
back to .gz.

Regards
 Holger
