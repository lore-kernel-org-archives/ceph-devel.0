From: Sage Weil <sage@newdream.net>
Subject: Re: Proposal: data-at-rest encryption
Date: Thu, 27 Aug 2015 06:38:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508270635300.13116@cobra.newdream.net>
References: <55DAE0F7.1070905@suse.de> <alpine.DEB.2.00.1508261744370.13116@cobra.newdream.net> <55DECE66.5000505@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55855 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbbH0NiC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 09:38:02 -0400
In-Reply-To: <55DECE66.5000505@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joshua Schmid <jschmid@suse.de>
Cc: ceph-devel@vger.kernel.org

On Thu, 27 Aug 2015, Joshua Schmid wrote:
> 
> On 08/27/2015 02:49 AM, Sage Weil wrote:
> > Hi Joshua!
> > 
> 
> Hi Sage,
> 
> 
> > Overall the ceph-disk changes look pretty good, and it looks like Andrew 
> > and David have both reviewed.  My only real concern/request is that the 
> > key server be as pluggable as possible.  You're using ftps here, but we'd 
> > also like to allow deo[1], or even the mon config-key service.
> 
> Thank for having a look!
> I think this should do:
> 
> https://github.com/jschmid1/ceph/commit/7dd64c70bcb8d986568d6f379a6fbf9a0e40a441
> 
> Service of choice can now be set in the ceph.conf and will be handled
> separately. This is currently only for unlocking/mapping but will be
> extended for locking/new if this solution is acceptable.

Yep!  It'd probably be much cleaner to wrap this up in a class with 
fetch_key() and create_key(), etc. methods so that there is only one place 
that has to instantiate the implemetnation based on type.

> > With the original mon proposal, we also wanted an additional layer of 
> > security (beyond simply access to the storage network) by 
> > storing some key-fetching-key on the disk.
> 
> Like deo does it? (From the deo README)
> 
> """
> Second, we will add a new random key to the pre-existing LUKS encrypted
> disk and then encrypt it using Deo in a known location.
> """
> 
> 
>   It looks like the ftps
> > access is unauthenticated... is that right?  I would assume (I'm not hte 
> > expert!) that most key management systems require some credentials to 
> > store/fetch keys?
> 
> Its totally unauthenticated, thats right. It'd be possible to require
> USER/PASS for ftp.

Yeah.  If we have a general method to store a key-fetching-key on the disk 
(in the LUKS table?  I forget if this was practical) on the LUKS disk the 
might work?  Hopefully such that various backends can all use it (e.g., as 
the ftps password, or as a mon key)..

sage
