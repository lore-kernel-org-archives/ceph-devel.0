From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph] what's going on with d_rehash() in splice_dentry()?
Date: Mon, 7 Mar 2016 06:25:13 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603070615370.25897@cpach.fuggernut.com>
References: <20160226174250.GA17997@ZenIV.linux.org.uk> <alpine.DEB.2.11.1603010946290.24758@cpach.fuggernut.com> <B17B70FF-4B76-4593-9D96-F0298F83AEB3@redhat.com> <20160307021639.GR17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20160307021639.GR17997@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: "Yan, Zheng" <zyan@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 7 Mar 2016, Al Viro wrote:
> On Wed, Mar 02, 2016 at 11:00:01AM +0800, Yan, Zheng wrote:
> 
> > > This code dates back to when Ceph was originally upstreamed, so the 
> > > history is murky, but I expect at that point I wanted to avoid hashing in 
> > > the no-lease case.  But I don't think it matters.  We should just remove 
> > > the prehash argument from splice_dentry entirely.
> > > 
> > > Zheng, does that sound right?
> > 
> > Yes. I think we can remove the d_rehash(dn) call and rehash parameter.
> 
> Another question in the same general area:
>                 /* null dentry? */
>                 if (!rinfo->head->is_target) {
>                         dout("fill_trace null dentry\n");
>                         if (d_really_is_positive(dn)) {
>                                 ceph_dir_clear_ordered(dir);
>                                 dout("d_delete %p\n", dn);
>                                 d_delete(dn);
>                         } else {
>                                 dout("d_instantiate %p NULL\n", dn);
>                                 d_instantiate(dn, NULL);
>                                 if (have_lease && d_unhashed(dn))
>                                         d_rehash(dn);
>                                 update_dentry_lease(dn, rinfo->dlease,
>                                                     session,
>                                                     req->r_request_started);
>                         }
>                         goto done;
>                 }
> What's that d_instantiate() about?  We have just checked that it's
> negative; what's the point of setting ->d_inode to NULL again?  Would it
> be OK if we just do
> 			} else {
> 				if (have_lease && d_unhashed(dn))
> 					d_add(dn, NULL);
>                                 update_dentry_lease(dn, rinfo->dlease,
>                                                     session,
>                                                     req->r_request_started);
>                         }
> in there?

That looks okay, but changing d_rehash to d_add still means you're doing 
te d_instantiate(dn, NULL) in the d_unhashed case; is there a reason you 
changed that line?  Is the dentry_rcuwalk_invalidate in __d_instantiate is 
important before rehashing?

> As an aside, tracking back to the originating fs method is
> painful as hell ;-/  I _think_ that rehash can be hit during ->lookup()
> returning a negative, but I wouldn't bet a dime on it not happening from
> other methods...  AFAICS, the change should be OK regardless of what
> it's been called from, but... _ouch_.  Is is documented anywhere public?

It is a pain to follow, yes. FWIW this whole block is predicated in 
req->r_locked_dir being non-NULL (i.e., VFS holds dir->i_mutex), which is 
only true for lookup, create operations (mkdir/mknod/symlink/etc.), 
atomic_open, and the .get_name export op.  There's not much documentation 
beyond a description of the meaning of fields (e.g. r_locked_dir) in 
fs/ceph/mds_client.h ...

sage

