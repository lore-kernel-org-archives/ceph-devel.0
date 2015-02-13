From: Sage Weil <sage@newdream.net>
Subject: Re: cephfs root_squash, multitenancy
Date: Fri, 13 Feb 2015 06:32:30 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502130632070.3035@cobra.newdream.net>
References: <alpine.DEB.2.00.1502130457540.3131@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49347 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbBMOcb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Feb 2015 09:32:31 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 191098009E
	for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 06:32:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D58728009E
	for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 06:32:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502130457540.3131@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, 13 Feb 2015, Sage Weil wrote:
> Got this from JJ:
> 
> > The SA expanded on this by stating that there are basically three main 
> > scenarios here:
> >
> > 1) We trust the UID/GID in a controlled environment. In which case we 
> > can safely rely on the POSIX permissions. As long as root_squash is 
> > available this would be fine.
> 
> I think adding a root_squash option to client/Client.cc and the ceph.ko 
> should be pretty easy...

Er, this is a server option, actually.  It'd go in the MDSAuthCap 
probably?

> > 2) Multi-tenant systems. In these cases being able to create keyrings 
> > which limit access to specified directories would be ideal.
> 
> This is mainly enforcing uid/gid and mount path in MDSAuthCap, and not 
> unlike what we'll need for OpenStack Manila.  I think it's something like
> 
>  1- establish mount root inode ref when session is opened/authenticated
>  2- verify in reply path that any inode we reference is beneath that point
>  3- special case inodes in stray directory, hopefully in some secure-ish 
> way based on where they lived previously.  (not sure how this'll work...)
> 
> > 3) Government and financial sectors, with more sensitive information. In 
> > these cases the same capabilities as 2 but also the ability to have an 
> > audit trail of what is accessed, when, and from where.
> 
> This one I'm happy to ignore for now... :)
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
