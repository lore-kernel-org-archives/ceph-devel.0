From: Sage Weil <sage@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Mon, 22 Oct 2012 14:27:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210221416520.31573@cobra.newdream.net>
References: <1014301554.14.1350734976941.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60318 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133Ab2JVV2A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 17:28:00 -0400
In-Reply-To: <1014301554.14.1350734976941.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Gregory Farnum <greg@inktank.com>, Casey Bodley <casey@linuxbox.com>, ceph-devel@vger.kernel.org, peter honeyman <peter.honeyman@gmail.com>, "Adam C. Emerson" <aemerson@linuxbox.com>

On Sat, 20 Oct 2012, Matt W. Benjamin wrote:
> Hi Sage,
> 
> I the interest of timeliness, I'll post a few thoughts now.
> 
> ----- "Sage Weil" <sage@inktank.com> wrote:
> 
> > On Wed, 17 Oct 2012, Adam C. Emerson wrote:
> 
> > 
> > I think this basic approach is viable.  However, I'm hesitant to give
> > up 
> > on embedded inodes because of the huge performance wins in the common
> > 
> > cases; I'd rather have a more expensive lookup-by-ino in the rare
> > cases 
> > where nfs filehandles are out of cache and be smokin' fast the rest of
> > the 
> > time.
> 
> Broadly, for us, lookup-by-ino is a fast path.  Fast for lookups but 
> slow for inode lookups seems out of balance.

And just to make sure I completely understand, this is specifically in 
reference to resolving NFS file handles?

My hope is that because it has to fall through both the client and MDS 
caches before it goes to the 'slow' path, this isn't such an issue.  It's 
really the case of clients presenting ancient fhs that are slow.  Even 
then, the 'normal' pattern would be a single osd op to the osd data 
object, followed by a path lookup or two.

In exchange, you get an 'ls -al' that only takes a single IO to fully 
populate the cache... but it is hard to say how often the client will need 
to resolve an ino it doesn't have in its cache, or how expensive that will 
be.

> > Are there reasons you're attached to your current approach?  Do you
> > see 
> > problems with a generalized "find this ino" function based on the file
> > 
> > objects?  I like the latter because it
> > 
> >  - means we can scrap the anchor table, which needs additional work
> > anyway 
> >    if it is going to scale
> >  - is generallly useful for fsck
> >  - solves the NFS fh issue
> 
> The proposed approach, if I understand it, is costly.  It's optimizing 
> for some workloads, at the definite expense of others.  (The side 
> benefits, e.g., to fsck might completely justify the cost, however.  
> "We need it anyway" may only be a decisive argument if we've accepted 
> the premise that inode lookups can be slow, however.)
> 
> By contrast, the additional cost our approach adds is small and 
> constant--but we grant, it's in a fast path.  For motivation, we solve 
> both the lookup-by-ino and hard link problems much more satisfactorily, 
> as far as I can see.
> 
> Obviously, we -hope- we are not sacrificing "smokin' fast" name lookups 
> for (smokin') fast inode lookups.  As in UFS, we can make use of 
> caching, bulkstat [which proved to be a huge win in AFS and DFS], and 
> given Ceph's design, parallelism to make up the gap in what -we hope- 
> would be the actual common case.  Of course we might be wrong.  We 
> haven't implemented all of that yet.  Maybe we would need to actually do 
> some performance measurement and comparison to be convincing, and 
> presumed we would.

Yep.  It's hard to make a convincing argument either way without seeing 
what performance looks like on the actual workloads you care about.

I think we will continue to implement the file backpointers, since it will 
be useful for fsck regardless, and then we'll be in a position to 
experiment with how fast/slow it is in practice.

sage



> 
> > 
> > The only real downsides I see to this approach are:
> > 
> >  - more OSD ops (setxattrs.. if we're smart, they'll be cheap)
> >  - lookup-by-ino for resolving hard links may be slower than the
> > anchor 
> >    table, which gives you *all* ancestors in one lookup, vs this,
> > which 
> >    may range from 1 lookup to (depth of tree) lookups (or possibly
> > more, 
> >    in rare cases).  For all the reasons that the anchor table was 
> >    acceptable for hard links, though (hard link rarity, parallel link
> > 
> >    patterns), I can live with it.
> > 
> > There are also lots of people who seem to be putting BackupPC (or
> > whatever 
> > is it) on Ceph, which is creating huge messes of hard links, so it
> > will be 
> > really good to solve/avoid teh current anchor table scaling problems.
> > 
> > sage
> 
> -- 
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://linuxbox.com
> 
> tel. 734-761-4689
> fax. 734-769-8938
> cel. 734-216-5309
> 
> 
