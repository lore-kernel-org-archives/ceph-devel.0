From: Sage Weil <sage@inktank.com>
Subject: Re: Preserve dir default_file_layout in encoded inode
Date: Thu, 16 Aug 2012 18:07:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208161759460.16032@cobra.newdream.net>
References: <orr4r7tn5q.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43407 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab2HQBHa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 21:07:30 -0400
In-Reply-To: <orr4r7tn5q.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Hi Alexandre,

I'm glad to you picked this up again; it'll be nice to get this issue 
behind us.  Sadly it's been a while since I've looked at this code...

On Thu, 16 Aug 2012, Alexandre Oliva wrote:
> Store dir layouts not only in the journal, but also in inode
> information for the directory, so that they aren't dropped on the
> floor when dirs are evicted from the MDS cache and dropped from the
> journal.  Also restore dir layouts when fetching dirs back into the
> MDS cache.

That sounds like the right diagnosis.  I'm not sure this fix is correct, 
though (see below).  It looks like I had a patch from a while back that 
simplified a lot of this code, though, and fixed teh storage issue for 
free.  I've dusted it off and repushed it.. can you take a look?  
wip-mds-layout.

> This is supposed to fix for bug 1435, except that it doesn't look like
> a layout change to a directory will trigger a commit of the new layout
> if the directory is not otherwise modified before the change is
> evicted from the cache and the journal.  This can be sorted out in a
> separate patch.
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/mds/CDir.cc  |   16 +++++++++++++++-
>  src/mds/CInode.h |    9 +++++++--
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index 6761c6f..df19252 100644
> --- a/src/mds/CDir.cc
> +++ b/src/mds/CDir.cc
> @@ -1552,8 +1552,16 @@ void CDir::_fetched(bufferlist &bl, const string& want_dn)
>  	    << " already exists at " << inopath << "\n";
>  	  continue;
>  	} else {
> +	  ceph_file_layout unset_fl = ceph_file_layout(), *fl;
> +
> +	  if (inode.is_dir ()
> +	      && memcmp (&inode.layout, &unset_fl, sizeof (unset_fl)) != 0)
> +	    fl = &inode.layout;
> +	  else
> +	    fl = NULL;
> +
>  	  // inode
> -	  in = new CInode(cache, true, first, last);
> +	  in = new CInode(cache, true, first, last, fl);
>  	  in->inode = inode;
>  	  
>  	  // symlink?
> @@ -1845,6 +1853,12 @@ void CDir::_encode_dentry(CDentry *dn, bufferlist& bl,
>      
>      dout(14) << " pos " << bl.length() << " dn '" << dn->name << "' inode " << *in << dendl;
>      
> +    ceph_file_layout *fl = in->get_projected_dir_layout ();

We aren't allowed to write any "projected" (i.e., unjournaled) changes to 
other objects until they've committed.  If this were the 
committed/journaled layout, it'd be close, though.

In any case, can you try out wip-mds-layout?  I don't have a full 
environment on my laptop so I haven't tested it yet; I'll try to do that 
later tonight.

Thanks!
sage


> +    if (fl)
> +      in->inode.layout = *fl;
> +    else
> +      memset (&in->inode.layout, 0, sizeof (in->inode.layout));
> +
>      // marker, name, inode, [symlink string]
>      bl.append('I');         // inode
>      ::encode(in->inode, bl);
> diff --git a/src/mds/CInode.h b/src/mds/CInode.h
> index 57c76c4..8b42f6f 100644
> --- a/src/mds/CInode.h
> +++ b/src/mds/CInode.h
> @@ -71,6 +71,9 @@ struct default_file_layout {
>  
>    ceph_file_layout layout;
>  
> +  default_file_layout() {};
> +  default_file_layout(ceph_file_layout l) : layout(l) {};
> +
>    void encode(bufferlist &bl) const {
>      __u8 struct_v = 1;
>      ::encode(struct_v, bl);
> @@ -458,12 +461,13 @@ private:
>  
>   public:
>    // ---------------------------
> -  CInode(MDCache *c, bool auth=true, snapid_t f=2, snapid_t l=CEPH_NOSNAP) : 
> +  CInode(MDCache *c, bool auth=true, snapid_t f=2, snapid_t l=CEPH_NOSNAP,
> +	 ceph_file_layout *dl = NULL) : 
>      mdcache(c),
>      snaprealm(0), containing_realm(0),
>      first(f), last(l),
>      last_journaled(0), //last_open_journaled(0), 
> -    default_layout(NULL),
> +    default_layout(dl ? new default_file_layout (*dl) : NULL),
>      //hack_accessed(true),
>      stickydir_ref(0),
>      parent(0),
> @@ -498,6 +502,7 @@ private:
>      g_num_inos++;
>      close_dirfrags();
>      close_snaprealm();
> +    delete default_layout;
>    }
>    
>  
> -- 
> 1.7.7.6
> 
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
