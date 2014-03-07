From: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH][RESEND] vfs: Make __d_materialise_dentry() set the
 materialised dentry name correctly
Date: Fri, 7 Mar 2014 14:01:36 -0500
Message-ID: <20140307190136.GB30256@fieldses.org>
References: <1394115376-17109-1-git-send-email-zheng.z.yan@intel.com>
 <6487FCC2-FB5C-4A32-94EF-5D3352A39781@primarydata.com>
 <20140307185552.GA30256@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140307185552.GA30256-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trond Myklebust <trond.myklebust-7I+n7zu2hftEKMMhf/gKZA@public.gmane.org>
Cc: "Yan, Zheng" <zheng.z.yan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viro Alexander <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 07, 2014 at 01:55:52PM -0500, J. Bruce Fields wrote:
> On Thu, Mar 06, 2014 at 09:35:01AM -0500, Trond Myklebust wrote:
> >=20
> > On Mar 6, 2014, at 9:16, Yan, Zheng <zheng.z.yan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >=20
> > > From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > >=20
> > > Make __d_materialise_dentry() set the materialised dentry name co=
rrectly by
> > > flipping the arguments to switch_names().
> > >=20
> > > switch_names() is lazy: if both names are internal to their dentr=
ies, it'll
> > > overwrite that of the first dentry with that of the second, and w=
on't update
> > > that of the second.
> > >=20
> > > In the case of __d_materialise_dentry(), the second is an already=
 extant
> > > anonymous dentry that we want to insert into the tree in place of=
 the dentry we
> > > just looked up[*].  However, the dentry we just looked up carries=
 the name we
> > > actually want to use.
> > >=20
> > > [*] This is used by NFS to join a mount of a subtree into a mount=
 of a tree
> > > nearer the root when the two meet, where both mounts share a supe=
rblock and
> > > thus a set of dentries.
> > >=20
> > > Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > ---
> > > fs/dcache.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/dcache.c b/fs/dcache.c
> > > index 265e0ce..ff779d4 100644
> > > --- a/fs/dcache.c
> > > +++ b/fs/dcache.c
> > > @@ -2698,7 +2698,7 @@ static void __d_materialise_dentry(struct d=
entry *dentry, struct dentry *anon)
> > >=20
> > > 	dparent =3D dentry->d_parent;
> > >=20
> > > -	switch_names(dentry, anon);
> > > +	switch_names(anon, dentry);
> > > 	swap(dentry->d_name.hash, anon->d_name.hash);
> > >=20
> > > 	dentry->d_parent =3D dentry;
> >=20
> > Well spotted...
> >=20
> > We ought to better document the fact that =E2=80=99switch_names=E2=80=
=99 is asymmetrical. Perhaps change it to =E2=80=98update_target_name=E2=
=80=99, and then switch the argument names so that the =E2=80=99target=E2=
=80=99 really is the thing that gets updated?
>=20
> Probably not worth it if Miklos's RENAME_EXCHANGE operation is making=
 it
> symmetrical soon anyway?:
>=20
> 	http://mid.gmane.org/<1380643239-16060-4-git-send-email-miklos@szere=
di.hu>

To clarify: I mean, the suggested cleanup may not be worth it.  The
__d_materialise_dentry bugfix of course is.

(What I wonder about is the duplication between this and __d_move.  Is
there any way to make d_materialise_unique a special case of d_move?)

--b.
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
