From: Sage Weil <sage@inktank.com>
Subject: Re: CephFS First product release discussion
Date: Tue, 5 Mar 2013 11:33:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com> <51363490.4070408@42on.com> <1F15E079964848B9BE079E974A1946B4@inktank.com> <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net> <51363B30.7080006@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36252 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab3CETda (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 14:33:30 -0500
In-Reply-To: <51363B30.7080006@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Tue, 5 Mar 2013, Wido den Hollander wrote:
> > Wido, by 'user quota' do you mean something that is uid-based, or would
> > enforcement on subtree/directory quotas be sufficient for your use cases?
> > I've been holding out hope that uid-based usage accounting is a thing of
> > the past and that subtrees are sufficient for real users... in which case
> > adding enfocement to the existing rstats infrastructure is a very
> > manageable task.
> > 
> 
> I mean actual uid-based quotas. That still plays nice with shared environments
> like Samba or so where you have all homedirectories on a shared filesystems
> and you set per user quotas. Samba reads out those quotas and propagates them
> to the (Windows) client.

Does samba propagate the quota information (how much space is 
used/available) or do enforcement on the client side?  (Is client 
enforcement even necessary/useful if the backend will stop writes when the 
quota is exceeded?)

> I know this was a problem with ZFS as well. They also said they could do "per
> filesystem quotas" so that would be sufficient, but for example NFS doesn't
> export filesystems mounted in a export, so if you have a bunch of
> homedirectories on the filesystem and you want to account the usage of each
> user it's getting kind of hard.
> 
> This could be solved if the clients directly mounted CephFS though.
> 
> I'm talking about setups where you have 100k users in a LDAP and they all have
> their data in a single filesystem and you want to track the usage of each
> user, that's not an easy task without uid-based quotas.

Wouldn't each user live in a sub- or home directory?  If so, it seems like 
the existing rstats would be sufficient to do the accounting piece; only 
enforcement is missing.

> Running 'du' on each directory would be much faster with Ceph since it
> accounts tracks the subdirectories and shows their total size with an 'ls
> -al'.
> 
> Environments with 100k users also tend to be very dynamic with adding and
> removing users all the time, so creating separate filesystems for them would
> be very time consuming.
> 
> Now, I'm not talking about enforcing soft or hard quotas, I'm just talking
> about knowing how much space uid X and Y consume on the filesystem.

The part I'm most unclear on is what use cases people have where uid X and 
Y are spread around the file system (not in a single or small set of sub 
directories) and per-user (not, say, per-project) quotas are still 
necessary.  In most environments, users get their own home directory and 
everything lives there...

sage


> 
> Wido
> 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> -- 
> Wido den Hollander
> 42on B.V.
> 
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> 
> 
