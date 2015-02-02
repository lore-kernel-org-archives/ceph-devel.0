From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [RFC] several ceph dentry leaks
Date: Mon, 2 Feb 2015 14:19:20 +0800
Message-ID: <CAAM7YA=PEL2=j=+iMVvWhBonZGtfRv95V8+KYQnz6yf18d28tw@mail.gmail.com>
References: <20150202003124.GQ29656@ZenIV.linux.org.uk>
	<CAAM7YAm_ZRtEG3iOGsgY8wYNXYBJhKMQLk=3knqmtef4N8nKKA@mail.gmail.com>
	<20150202044135.GR29656@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20150202044135.GR29656@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Feb 2, 2015 at 12:41 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 02, 2015 at 11:23:58AM +0800, Yan, Zheng wrote:
> > > we should _never_ create multiple dentries pointing to directory inode, so
> > > d_instantiate() in there isn't mitigating anything - it's actively breaking
> > > things as far as the rest of the kernel is concerned...  What are you
> > > trying to do there?
> >
> > ceph_handle_notrace_create() is for case: Ceph Metadata server restarted,
> > client re-sent a request. Ceph MDS found the request has already completed,
> > so it sent a traceless reply to client. (traceless reply contains no information
> > for the dentry and the newly created inode). It's hard to handle this case
> > elegantly, because MDS may have done other operation, which moved the
> > newly created file/directory to other place.
> >
> > For multiple dentries pointing to directory inode, maybe we can return an error
> > (-ENOENT or -ESTALE).
>
> IDGI...  Suppose we got non-NULL from ceph_lookup() there.  So we'd sent either
> CEPH_MDS_OP_LOOKUP or CEPH_MDS_OP_LOOKUPSNAP and got ->r_dentry changed
> (presumably in ceph_fill_trace(), after it got the sucker from splice_dentry(),
> i.e. ultimately d_splice_alias()).  Right?

In theory, yes. But I think it never happens in reality. Because
parent directory of the newly created
file/directory is locked, client has no other way to lookup the newly
created file/directory.


Now, we have acquired a reference
> to it (in ceph_finish_lookup()).  So far, so good; for one thing, we definitely
> do *NOT* want to forget about that reference.  For another, we've got
> a good and valid dentry; so why are we playing with the originally passed
> one?  Just unhash the original and be done with that...
>

I think the reason is that VFS still uses the original dentry. (for
example, after calling
filesystem's mkdir callback, vfs_mkdir() calls fsnotify_mkdir() and
passing the original
dentry to it)


> Looking at the code downstream from the calls of ceph_handle_notrace_create(),
> ceph_mkdir() looks very dubious - we do ceph_init_inode_acls(dentry->d_inode,
> &acls); there, after having set ->d_inode to that of a preexisting alias.
> Is that really correct in the case when such an alias used to exist?

you are right, it's incorrect.

how about make ceph_handle_notrace_create()  return an error when it
gets an non-NULL
from ceph_lookup() ? this method is not perfect but should work in most case.

Regards
Yan, Zheng
