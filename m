From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Sun, 19 Aug 2012 14:22:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208191422110.26858@cobra.newdream.net>
References: <orboos1qyu.fsf@livre.localdomain> <Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net> <ork43bbbbb.fsf@livre.localdomain> <Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net> <ora9xsbm9w.fsf@livre.localdomain> <orzk5ra8m9.fsf@livre.localdomain>
 <alpine.DEB.2.00.1208191415240.26858@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58793 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab2HSVWY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Aug 2012 17:22:24 -0400
In-Reply-To: <alpine.DEB.2.00.1208191415240.26858@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Sun, 19 Aug 2012, Sage Weil wrote:
> On Sun, 19 Aug 2012, Alexandre Oliva wrote:
> > On Aug 18, 2012, Alexandre Oliva <oliva@lsd.ic.unicamp.br> wrote:
> > 
> > > I've looked further into this tonight, and I found out what modifies
> > > the timestamps in the inode is (re)issuing caps to a client.
> > 
> > > So, how can we stop pre_cow_old_inode from messing with the old_inode?
> > > Any suggestions?
> > 
> > This patch seems to avoid the problem, but is it correct, or is it just
> > papering over a problem elsewhere?
> 
> I think the real bug is that CInode::first is less than one of the 
> old_inodes keys.  Looking at cow_old_inode(), it looks like first should 
> always be strictly > than all old_inodes keys.  We should probably assert 
> as much wherever it is convenient to do so...
> 
> In any case, can you see where/how that is happening?  If this is a dir 
> inode that has been commited and then refetched from the parent dir, that 
> probably explains it.  For non-multiversion inodes, dn->first == 
> in->first, but not so for these guys, and at first glance I'm not seeing 
> it in the CDir::_fetched() code.

This might do the trick?

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 6761c6f..9034978 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1564,6 +1564,8 @@ void CDir::_fetched(bufferlist &bl, const string& want_dn)
          in->xattrs.swap(xattrs);
          in->decode_snap_blob(snapbl);
          in->old_inodes.swap(old_inodes);
+         if (!in->old_inodes.empty())
+           in->first = in->old_inodes.rbegin()->first + 1;
          if (snaps)
            in->purge_stale_snap_data(*snaps);
 


> 
> sage
> 
> > 
> > Subject: mds: Don't modify already-created old_inode
> > 
> > In cow_old_inode, do not modify an old_inode that was created before.
> > 
> > Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> > ---
> >  src/mds/CInode.cc |   14 +++++++++-----
> >  1 files changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
> > index 53f9e69..fdff86c 100644
> > --- a/src/mds/CInode.cc
> > +++ b/src/mds/CInode.cc
> > @@ -2030,12 +2030,16 @@ old_inode_t& CInode::cow_old_inode(snapid_t follows, bool cow_head)
> >    inode_t *pi = cow_head ? get_projected_inode() : get_previous_projected_inode();
> >    map<string,bufferptr> *px = cow_head ? get_projected_xattrs() : get_previous_projected_xattrs();
> >  
> > +  bool found = old_inodes.find(follows) != old_inodes.end();
> >    old_inode_t &old = old_inodes[follows];
> > -  old.first = first;
> > -  old.inode = *pi;
> > -  old.xattrs = *px;
> > -  
> > -  dout(10) << " " << px->size() << " xattrs cowed, " << *px << dendl;
> > +
> > +  if (!found) {
> > +    old.first = first;
> > +    old.inode = *pi;
> > +    old.xattrs = *px;
> > +
> > +    dout(10) << " " << px->size() << " xattrs cowed, " << *px << dendl;
> > +  }
> >  
> >    old.inode.trim_client_ranges(follows);
> >  
> > -- 
> > 1.7.7.6
> > 
> > 
> > 
> > -- 
> > Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> > You must be the change you wish to see in the world. -- Gandhi
> > Be Free! -- http://FSFLA.org/   FSF Latin America board member
> > Free Software Evangelist      Red Hat Brazil Compiler Engineer
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
