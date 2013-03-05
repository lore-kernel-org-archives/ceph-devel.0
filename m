From: Sage Weil <sage@inktank.com>
Subject: Re: CephFS First product release discussion
Date: Tue, 5 Mar 2013 10:28:37 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com> <51363490.4070408@42on.com> <1F15E079964848B9BE079E974A1946B4@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35656 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab3CES2i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 13:28:38 -0500
In-Reply-To: <1F15E079964848B9BE079E974A1946B4@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel@vger.kernel.org

On Tue, 5 Mar 2013, Greg Farnum wrote:
> On Tuesday, March 5, 2013 at 10:08 AM, Wido den Hollander wrote:
> > On 03/05/2013 06:03 PM, Greg Farnum wrote:
> > > This is a companion discussion to the blog post at http://ceph.com/dev-notes/cephfs-mds-status-discussion/ ? go read that!
> > >  
> > > The short and slightly alternate version: I spent most of about two weeks working on bugs related to snapshots in the MDS, and we started realizing that we could probably do our first supported release of CephFS and the related infrastructure much sooner if we didn't need to support all of the whizbang features. (This isn't to say that the base feature set is stable now, but it's much closer than when you turn on some of the other things.) I'd like to get feedback from you in the community on what minimum supported feature set would prompt or allow you to start using CephFS in real environments ? not what you'd *like* to see, but what you *need* to see. This will allow us at Inktank to prioritize more effectively and hopefully get out a supported release much more quickly! :)
> > >  
> > > The current proposed feature set is basically what's left over after we've trimmed off everything we can think to split off, but if any of the proposed included features are also particularly important or don't matter, be sure to mention them (NFS export in particular ? it works right now but isn't in great shape due to NFS filehandle caching).
> >  
> > Great news! Although RBD and RADOS itself are already great, a lot of  
> > applications would still require a shared filesystem.
> >  
> > Think about a (Cloud|Open)Stack environment with thousands of instances  
> > running but also need some form of shared filesystem.
> >  
> > One thing I'm missing though is user-quotas, have they been discussed at  
> > all and what would the work to implement those involve?
> >  
> > I know it would require a lot more tracking per file so it's not that  
> > easy and would certainly not make it into a first release, but are they  
> > on the roadmap at all?
> 
> Not at present. I think there are some tickets related to this in the 
> tracker as feature requests, but CephFS needs more groundwork about 
> multi-tenancy in general before we can do reasonable planning around a 
> robust user quota feature. (Near-real-time hacks are possible now based 
> around the rstats infrastructure and I believe somebody has built them, 
> though I've never seen them myself.)

Wido, by 'user quota' do you mean something that is uid-based, or would 
enforcement on subtree/directory quotas be sufficient for your use cases?  
I've been holding out hope that uid-based usage accounting is a thing of 
the past and that subtrees are sufficient for real users... in which case 
adding enfocement to the existing rstats infrastructure is a very 
manageable task.

sage
