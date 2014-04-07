From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH][RESEND] vfs: Make __d_materialise_dentry() set the
 materialised dentry name correctly
Date: Mon, 7 Apr 2014 06:56:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404070655530.28550@cobra.newdream.net>
References: <1394115376-17109-1-git-send-email-zheng.z.yan@intel.com> <6487FCC2-FB5C-4A32-94EF-5D3352A39781@primarydata.com> <53392EDA.7000904@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53392EDA.7000904-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viro Alexander <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Cc: "Yan, Zheng" <zheng.z.yan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Trond Myklebust <trond.myklebust-7I+n7zu2hftEKMMhf/gKZA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Al,

Can this go to Linus via your tree?

Thanks!
sage


On Mon, 31 Mar 2014, Yan, Zheng wrote:

> Hi Al,
> 
> Could you include this in 3.15
> 
> Regards
> Yan, Zheng
> 
> On 03/06/2014 10:35 PM, Trond Myklebust wrote:
> > 
> > On Mar 6, 2014, at 9:16, Yan, Zheng <zheng.z.yan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > 
> >> From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>
> >> Make __d_materialise_dentry() set the materialised dentry name correctly by
> >> flipping the arguments to switch_names().
> >>
> >> switch_names() is lazy: if both names are internal to their dentries, it'll
> >> overwrite that of the first dentry with that of the second, and won't update
> >> that of the second.
> >>
> >> In the case of __d_materialise_dentry(), the second is an already extant
> >> anonymous dentry that we want to insert into the tree in place of the dentry we
> >> just looked up[*].  However, the dentry we just looked up carries the name we
> >> actually want to use.
> >>
> >> [*] This is used by NFS to join a mount of a subtree into a mount of a tree
> >> nearer the root when the two meet, where both mounts share a superblock and
> >> thus a set of dentries.
> >>
> >> Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> ---
> >> fs/dcache.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/dcache.c b/fs/dcache.c
> >> index 265e0ce..ff779d4 100644
> >> --- a/fs/dcache.c
> >> +++ b/fs/dcache.c
> >> @@ -2698,7 +2698,7 @@ static void __d_materialise_dentry(struct dentry *dentry, struct dentry *anon)
> >>
> >> 	dparent = dentry->d_parent;
> >>
> >> -	switch_names(dentry, anon);
> >> +	switch_names(anon, dentry);
> >> 	swap(dentry->d_name.hash, anon->d_name.hash);
> >>
> >> 	dentry->d_parent = dentry;
> > 
> > Well spotted...
> > 
> > We ought to better document the fact that ?switch_names? is asymmetrical. Perhaps change it to ?update_target_name?, and then switch the argument names so that the ?target? really is the thing that gets updated?
> > 
> > _________________________________
> > Trond Myklebust
> > Linux NFS client maintainer, PrimaryData
> > trond.myklebust-7I+n7zu2hftEKMMhf/gKZA@public.gmane.org
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
