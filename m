From: Jeff Layton <jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org>
Subject: Re: [PATCH] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Date: Fri, 11 Sep 2015 17:44:45 -0400
Message-ID: <20150911174445.402d4dca@tlielax.poochiereds.net>
References: <1441966830-5517-1-git-send-email-jeff.layton@primarydata.com>
	<20150911212957.GH11677@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150911212957.GH11677-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, HPDD-discuss-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cluster-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ocfs2-devel-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 11 Sep 2015 17:29:57 -0400
"J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org> wrote:

> On Fri, Sep 11, 2015 at 06:20:30AM -0400, Jeff Layton wrote:
> > With NFSv3 nfsd will always attempt to send along WCC data to the
> > client. This generally involves saving off the in-core inode information
> > prior to doing the operation on the given filehandle, and then issuing a
> > vfs_getattr to it after the op.
> > 
> > Some filesystems (particularly clustered or networked ones) have an
> > expensive ->getattr inode operation. Atomicitiy is also often difficult
> > or impossible to guarantee on such filesystems. For those, we're best
> > off not trying to provide WCC information to the client at all, and to
> > simply allow it to poll for that information as needed with a GETATTR
> > RPC.
> > 
> > This patch adds a new flags field to struct export_operations, and
> > defines a new EXPORT_OP_NOWCC flag that filesystems can use to indicate
> > that nfsd should not attempt to provide WCC info in NFSv3 replies. It
> > also adds a blurb about the new flags field and flag to the exporting
> > documentation.
> > 
> > The server will also now skip collecting this information for NFSv2 as
> > well, since that info is never used there anyway.
> > 
> > Note that this patch does not add this flag to any filesystem
> > export_operations structures. This was originally developed to allow
> > reexporting nfs via nfsd. That code is not (and may never be) suitable
> > for merging into mainline.
> > 
> > Other filesystems may want to consider enabling this flag too. It's hard
> > to tell however which ones have export operations to enable export via
> > knfsd and which ones mostly rely on them for open-by-filehandle support,
> 
> Are there any in the latter class?  I'm not sure how or why you'd
> support open-by-filehandle without supporting nfs exports.
> 

I don't know. I'm not sure that there's any difference from a technical
standpoint. If you enable open by fh support, then you sort of get
knfsd exporting "for free".

That said, I imagine at least some of these filesystems are typically
exported by some sort of userland server instead of knfsd (ganesha or
whatnot), and for them knfsd v3 performance is not terribly critical
either way.

> > so I'm leaving that up to the individual maintainers to decide. I am
> > cc'ing the relevant lists for those filesystems that I think may want to
> > consider adding this though.
> 
> I'd definitely like to see evidence from maintainers of those
> filesystems that this would be useful to them.
> 

Agreed. If it turns out that there aren't any, then we can drop this
patch and I'll just plan to carry it privately.

-- 
Jeff Layton <jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
