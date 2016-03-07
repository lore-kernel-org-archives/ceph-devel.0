From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [ceph] what's going on with d_rehash() in splice_dentry()?
Date: Mon, 7 Mar 2016 14:56:16 +0000
Message-ID: <20160307145616.GT17997@ZenIV.linux.org.uk>
References: <20160226174250.GA17997@ZenIV.linux.org.uk>
 <alpine.DEB.2.11.1603010946290.24758@cpach.fuggernut.com>
 <B17B70FF-4B76-4593-9D96-F0298F83AEB3@redhat.com>
 <20160307021639.GR17997@ZenIV.linux.org.uk>
 <alpine.DEB.2.11.1603070615370.25897@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1603070615370.25897@cpach.fuggernut.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Sage Weil <sweil@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Mar 07, 2016 at 06:25:13AM -0500, Sage Weil wrote:

> That looks okay, but changing d_rehash to d_add still means you're doing 
> te d_instantiate(dn, NULL) in the d_unhashed case; is there a reason you 
> changed that line?  Is the dentry_rcuwalk_invalidate in __d_instantiate is 
> important before rehashing?

d_add() gets uninlined in my queue, along with some locking massage to avoid
extra bouncing of ->d_lock we do for no good reason.  So that call is also
going away.

> > As an aside, tracking back to the originating fs method is
> > painful as hell ;-/  I _think_ that rehash can be hit during ->lookup()
> > returning a negative, but I wouldn't bet a dime on it not happening from
> > other methods...  AFAICS, the change should be OK regardless of what
> > it's been called from, but... _ouch_.  Is is documented anywhere public?
> 
> It is a pain to follow, yes. FWIW this whole block is predicated in 
> req->r_locked_dir being non-NULL (i.e., VFS holds dir->i_mutex), which is 
> only true for lookup, create operations (mkdir/mknod/symlink/etc.), 
> atomic_open, and the .get_name export op.  There's not much documentation 
> beyond a description of the meaning of fields (e.g. r_locked_dir) in 
> fs/ceph/mds_client.h ...

Yes.  Now consider the plans to make ->i_mutex an rwsem and weaken it for
->lookup() (i.e. held only shared when it's held for lookup alone).  IOW,
the aforementioned queue...  I would rather avoid d_rehash() in ->lookup()
instances; the tricky part is that we want to avoid parallel lookups on
the *same* name, so we need an "in parallel lookup" state for dentries and
mechanism allowing to wait for it to be finished.  d_add()/d_splice_alias()
on such a dentry would take it out of that state and I would rather
avoid dealing with it in d_rehash()...

I was going to post the series last week, got sidetracked on various fun
things I'd found (ecryptfs and lustre).  Hopefully will get all of that
sorted out and the whole series posted for review tomorrow or on Wednesday...
