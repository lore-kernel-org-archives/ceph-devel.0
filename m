From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Wed, 22 Feb 2012 22:04:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
References: <orboos1qyu.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54771 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2BWGEM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 01:04:12 -0500
In-Reply-To: <orboos1qyu.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Applied, with a small cleanup (wip-mds-old-inodes).. I'll merge it in 
tomorrow after a bit of testing.

On Tue, 21 Feb 2012, Alexandre Oliva wrote:
> This was supposed to fix bug 1946, and likely bug 1849 too, but it looks
> like something's still missing for a complete fix.  fuse-unmounting
> between touching a dir and creating a snapshot seems to help get correct
> snapshot timestamp,

Hmm, that sounds like ceph-fuse isn't sending the write flushsnap cap 
message.  I forget.. have you tried the same with the kernel client?

> but touching the dir after remounting and restarting
> the mds shortly afterwards very often results in the wrong timestamp for
> the snapshot.

Do you 'sync' after the touch, by any chance?  It may be lost between the 
client and mds, not in the MDS journal.  A full mds log of this should 
have the answer.

Thanks for digging into this!
sage



> 
> 8<-----
> 
> Add information about old inodes to the mds journal.
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/mds/events/EMetaBlob.h |   32 +++++++++++++++++++++++++-------
>  src/mds/journal.cc         |    2 ++
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
> index e03f147..747bff3 100644
> --- a/src/mds/events/EMetaBlob.h
> +++ b/src/mds/events/EMetaBlob.h
> @@ -68,6 +68,8 @@ public:
>      bufferlist snapbl;
>      bool dirty;
>      struct default_file_layout *dir_layout;
> +    typedef map<snapid_t, old_inode_t> old_inodes_t;
> +    old_inodes_t *old_inodes;
>  
>      bufferlist _enc;
>  
> @@ -77,10 +79,11 @@ public:
>      fullbit(const string& d, snapid_t df, snapid_t dl, 
>  	    version_t v, inode_t& i, fragtree_t &dft, 
>  	    map<string,bufferptr> &xa, const string& sym,
> -	    bufferlist &sbl, bool dr, default_file_layout *defl = NULL) :
> +	    bufferlist &sbl, bool dr, default_file_layout *defl = NULL,
> +	    old_inodes_t *oi = NULL) :
>        //dn(d), dnfirst(df), dnlast(dl), dnv(v), 
>        //inode(i), dirfragtree(dft), xattrs(xa), symlink(sym), snapbl(sbl), dirty(dr) 
> -      dir_layout(NULL), _enc(1024)
> +      dir_layout(NULL), old_inodes(NULL), _enc(1024)
>      {
>        ::encode(d, _enc);
>        ::encode(df, _enc);
> @@ -98,15 +101,21 @@ public:
>  	  ::encode(*defl, _enc);
>        }
>        ::encode(dr, _enc);      
> +      ::encode(oi ? true : false, _enc);
> +      if (oi)
> +	::encode(*oi, _enc);
>      }
> -    fullbit(bufferlist::iterator &p) : dir_layout(NULL) { decode(p); }
> -    fullbit() : dir_layout(NULL) {}
> +    fullbit(bufferlist::iterator &p) : dir_layout(NULL), old_inodes(NULL) {
> +      decode(p);
> +    }
> +    fullbit() : dir_layout(NULL), old_inodes(NULL) {}
>      ~fullbit() {
> +      delete old_inodes;
>        delete dir_layout;
>      }
>  
>      void encode(bufferlist& bl) const {
> -      __u8 struct_v = 2;
> +      __u8 struct_v = 3;
>        ::encode(struct_v, bl);
>        assert(_enc.length());
>        bl.append(_enc); 
> @@ -135,6 +144,14 @@ public:
>  	}
>        }
>        ::decode(dirty, bl);
> +      if (struct_v >= 3) {
> +	bool old_inodes_present;
> +	::decode(old_inodes_present, bl);
> +	if (old_inodes_present) {
> +	  old_inodes = new old_inodes_t;
> +	  ::decode(*old_inodes, bl);
> +	}
> +      }
>      }
>  
>      void update_inode(MDS *mds, CInode *in);
> @@ -562,7 +579,8 @@ private:
>  									 *pi, in->dirfragtree,
>  									 *in->get_projected_xattrs(),
>  									 in->symlink, snapbl,
> -									 dirty, default_layout)));
> +									 dirty, default_layout,
> +									 &in->old_inodes)));
>      if (pi)
>        lump.get_dfull().back()->inode = *pi;
>      return &lump.get_dfull().back()->inode;
> @@ -614,7 +632,7 @@ private:
>  		       0,
>  		       *pi, *pdft, *px,
>  		       in->symlink, snapbl,
> -		       dirty, default_layout);
> +		       dirty, default_layout, &in->old_inodes);
>      return &root->inode;
>    }
>    
> diff --git a/src/mds/journal.cc b/src/mds/journal.cc
> index 5f74bbb..fd45213 100644
> --- a/src/mds/journal.cc
> +++ b/src/mds/journal.cc
> @@ -416,6 +416,8 @@ void EMetaBlob::fullbit::update_inode(MDS *mds, CInode *in)
>    } else if (in->inode.is_symlink()) {
>      in->symlink = symlink;
>    }
> +  if (old_inodes)
> +    in->old_inodes = *old_inodes;
>  }
>  
>  void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
> -- 
> 1.7.7.6
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
