From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: add 'fs' mount option support
Date: Mon, 24 Feb 2020 14:24:34 -0800
Message-ID: <8a9c3239eab504f47b93377998312c447a1eec41.camel@kernel.org>
References: <20200223021440.40257-1-xiubli@redhat.com>
         <552341c730d2835b1492599fce319ae91a34f504.camel@kernel.org>
         <33fb49fe-87bc-b5d3-f717-3c22c7a15030@redhat.com>
         <19a375d6b80aaaeab0133f53e3bba2d067e3699d.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXWYi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:24:38 -0500
In-Reply-To: <19a375d6b80aaaeab0133f53e3bba2d067e3699d.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Mon, 2020-02-24 at 14:20 -0800, Jeff Layton wrote:
> On Mon, 2020-02-24 at 10:41 +0800, Xiubo Li wrote:
> > On 2020/2/23 22:56, Jeff Layton wrote:
> > > On Sat, 2020-02-22 at 21:14 -0500, xiubli@redhat.com wrote:
> > > > From: Xiubo Li <xiubli@redhat.com>
> > > > 
> > > > The 'fs' here will be cleaner when specifying the ceph fs name,
> > > > and we can easily get the corresponding name from the `ceph fs
> > > > dump`:
> > > > 
> > > > [...]
> > > > Filesystem 'a' (1)
> > > > fs_name	a
> > > > epoch	12
> > > > flags	12
> > > > [...]
> > > > 
> > > > The 'fs' here just an alias name for 'mds_namespace' mount options,
> > > > and we will keep 'mds_namespace' for backwards compatibility.
> > > > 
> > > > URL: https://tracker.ceph.com/issues/44214
> > > > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > > It looks like mds_namespace feature went into the kernel in 2016 (in
> > > v4.7). We're at v5.5 today, so that's a large swath of kernels in the
> > > field that only support the old option.
> > > 
> > > While I agree that 'fs=' would have been cleaner and more user-friendly,
> > > I've found that it's just not worth it to add mount option aliases like
> > > this unless you have a really good reason. It all ends up being a huge
> > > amount of churn for little benefit.
> > > 
> > > The problem with changing it after the fact like this is that you still
> > > have to support both options forever. Removing support isn't worth the
> > > pain as you can break working environments. When working environments
> > > upgrade they won't change to use the new option (why bother?)
> > > 
> > > Maybe it would be good to start this change by doing a "fs=" to
> > > "mds_namespace=" translation in the mount helper? That would make the
> > > new option work across older kernel releases too, and make it simpler to
> > > document what options are supported.
> > 
> > This sounds a pretty good idea for me.
> > 
> > 
> > > > @@ -561,8 +562,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
> > > >   	if ((fsopt->flags & CEPH_MOUNT_OPT_NOCOPYFROM) == 0)
> > > >   		seq_puts(m, ",copyfrom");
> > > >   
> > > > -	if (fsopt->mds_namespace)
> > > > -		seq_show_option(m, "mds_namespace", fsopt->mds_namespace);
> > > > +	if (fsopt->fs_name)
> > > > +		seq_show_option(m, "fs", fsopt->fs_name);
> > > Someone will mount with mds_namespace= but then that will be converted
> > > to fs= when displaying options here. It's not necessarily a problem but
> > > it may be noticed by some users.
> > 
> > Yeah, but if we convert 'fs=' to 'mds_namespace=' in userland and here 
> > it will always showing with 'mds_namespace=', won't it be the same issue?
> > 
> > Or should we covert it to "fs/mds_namespace=" here ? Will it make sense ?
> > 
> 
> Now that I think about it more, it's probably not a problem either way,
> but we should probably convert it to read 'fs=' here since that's what
> we're planning to encourage people to use long-term.
> 

To be even more clear:

We should probably take your initial patch (or something like it) into
the kernel as well, but also change the mount helper to smooth over the
difference in the option handling there.  Once your userland changes
are merged, let me know and I'll plan to re-review and merge this.



-- 
Jeff Layton <jlayton@kernel.org>
