From: Sage Weil <sage@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Fri, 19 Oct 2012 14:17:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210191409050.6636@cobra.newdream.net>
References: <937776470.145.1350510476081.JavaMail.root@thunderbeast.private.linuxbox.com> <1471957339.149.1350510684603.JavaMail.root@thunderbeast.private.linuxbox.com> <CAPYLRzg5tkaTSvxnKsDMPFSdfSHKqiFOyETKxnSNFmrYOuf6fA@mail.gmail.com>
 <78pq4g3fu9.wl%aemerson@linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34127 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab2JSVR1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 17:17:27 -0400
In-Reply-To: <78pq4g3fu9.wl%aemerson@linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@linuxbox.com>
Cc: Gregory Farnum <greg@inktank.com>, Casey Bodley <casey@linuxbox.com>, "Matt W. Benjamin" <matt@linuxbox.com>, ceph-devel@vger.kernel.org, peter honeyman <peter.honeyman@gmail.com>

On Wed, 17 Oct 2012, Adam C. Emerson wrote:
> Mr. Farnum,
> 
> At Wed, 17 Oct 2012 15:04:23 -0700, Gregory Farnum wrote:
> > 
> > I still don't get it. Putting every inode's primary link in a lookup
> > directory and then patching the lookup code to go there makes sense to
> > me. But if you have to go the other way (from the inode directory's
> > secondary link to some other location as the primary link), you need
> > an up-to-date path for that primary link, right? How do you handle it
> > when the path changes ? do you have a two-phase commit on the lookup
> > directory attributes?
> 
> Our idea isn't to have the inode directory contain links back to the
> primary.  Our idea is to have a structure managed by MDSs that is
> looked up by inode number and spread across the MDSs in a cluster
> similarly to the way CRUSH maps files across OSDs.  This structure
> contains all the information currently in the inode that's now
> incorporated into the dirent.
> 
> The dirents would then contain mappings from mappings from names to
> inodes and possibly cache (but not be the primary for) inode content.
> We were also planning to change directory fragmentation to distribute
> fragments across MDSs based on a function of the filename, also
> similarly to how CRUSH maps objects to OSDs.

I think this basic approach is viable.  However, I'm hesitant to give up 
on embedded inodes because of the huge performance wins in the common 
cases; I'd rather have a more expensive lookup-by-ino in the rare cases 
where nfs filehandles are out of cache and be smokin' fast the rest of the 
time.

Are there reasons you're attached to your current approach?  Do you see 
problems with a generalized "find this ino" function based on the file 
objects?  I like the latter because it

 - means we can scrap the anchor table, which needs additional work anyway 
   if it is going to scale
 - is generallly useful for fsck
 - solves the NFS fh issue

The only real downsides I see to this approach are:

 - more OSD ops (setxattrs.. if we're smart, they'll be cheap)
 - lookup-by-ino for resolving hard links may be slower than the anchor 
   table, which gives you *all* ancestors in one lookup, vs this, which 
   may range from 1 lookup to (depth of tree) lookups (or possibly more, 
   in rare cases).  For all the reasons that the anchor table was 
   acceptable for hard links, though (hard link rarity, parallel link 
   patterns), I can live with it.

There are also lots of people who seem to be putting BackupPC (or whatever 
is it) on Ceph, which is creating huge messes of hard links, so it will be 
really good to solve/avoid teh current anchor table scaling problems.

sage
