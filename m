From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] [ceph spec] package *.py* files
Date: Fri, 20 Jan 2012 15:36:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201201536070.8753@cobra.newdream.net>
References: <orboq2w2vq.fsf@livre.localdomain> <loom.20120119T183130-208@post.gmane.org>
 <orehuvp6ce.fsf@livre.localdomain> <20120120150342.GB7606@homac.suse.de>
 <or39baosw7.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40302 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab2ATXgq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jan 2012 18:36:46 -0500
In-Reply-To: <or39baosw7.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: Holger Macht <hmacht@suse.de>, ceph-devel@vger.kernel.org

On Fri, 20 Jan 2012, Alexandre Oliva wrote:
> On Jan 20, 2012, Holger Macht <hmacht@suse.de> wrote:
> > So maybe we should just always put pyc files in for maximum
> > compatibility across distributions?
> 
> Yeah.

I should apply this, then?

> > My fault. I also recompressed them at the very start of working on the
> > spec file and changed it accordingly, but I'm fine for changing this
> > back to .gz.
> 
> I'd rather use the smallest available tarball, but we should use
> whatever ceph publishes.  If it's going to be .gz from now on, we have
> to change the spec file.

I'll start doing .bz2 (in addition to .gz) with 0.41.

Thanks!
sage

