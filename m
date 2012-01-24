From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] [ceph spec] package *.py* files
Date: Tue, 24 Jan 2012 21:18:21 +0100
Message-ID: <20120124201821.GA32255@homac.suse.de>
References: <orboq2w2vq.fsf@livre.localdomain>
 <loom.20120119T183130-208@post.gmane.org>
 <orehuvp6ce.fsf@livre.localdomain>
 <20120120150342.GB7606@homac.suse.de>
 <or39baosw7.fsf@livre.localdomain>
 <Pine.LNX.4.64.1201201536070.8753@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49840 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756471Ab2AXUSY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Jan 2012 15:18:24 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1201201536070.8753@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alexandre Oliva <oliva@lsd.ic.unicamp.br>, ceph-devel@vger.kernel.org

On Fr 20. Jan - 15:36:45, Sage Weil wrote:
> On Fri, 20 Jan 2012, Alexandre Oliva wrote:
> > On Jan 20, 2012, Holger Macht <hmacht@suse.de> wrote:
> > > So maybe we should just always put pyc files in for maximum
> > > compatibility across distributions?
> > 
> > Yeah.
> 
> I should apply this, then?

Ok, fine with me.

> 
> > > My fault. I also recompressed them at the very start of working on the
> > > spec file and changed it accordingly, but I'm fine for changing this
> > > back to .gz.
> > 
> > I'd rather use the smallest available tarball, but we should use
> > whatever ceph publishes.  If it's going to be .gz from now on, we have
> > to change the spec file.
> 
> I'll start doing .bz2 (in addition to .gz) with 0.41.

Thanks,
 Holger
