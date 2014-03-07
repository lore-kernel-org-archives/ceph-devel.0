From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH][RESEND] vfs: Make __d_materialise_dentry() set the
 materialised dentry name correctly
Date: Fri, 7 Mar 2014 13:55:52 -0500
Message-ID: <20140307185552.GA30256@fieldses.org>
References: <1394115376-17109-1-git-send-email-zheng.z.yan@intel.com>
 <6487FCC2-FB5C-4A32-94EF-5D3352A39781@primarydata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6487FCC2-FB5C-4A32-94EF-5D3352A39781@primarydata.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Trond Myklebust <trond.myklebust@primarydata.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, Viro Alexander <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, sage@inktank.com
List-Id: ceph-devel.vger.kernel.org

On Thu, Mar 06, 2014 at 09:35:01AM -0500, Trond Myklebust wrote:
>=20
> On Mar 6, 2014, at 9:16, Yan, Zheng <zheng.z.yan@intel.com> wrote:
>=20
> > From: David Howells <dhowells@redhat.com>
> >=20
> > Make __d_materialise_dentry() set the materialised dentry name corr=
ectly by
> > flipping the arguments to switch_names().
> >=20
> > switch_names() is lazy: if both names are internal to their dentrie=
s, it'll
> > overwrite that of the first dentry with that of the second, and won=
't update
> > that of the second.
> >=20
> > In the case of __d_materialise_dentry(), the second is an already e=
xtant
> > anonymous dentry that we want to insert into the tree in place of t=
he dentry we
> > just looked up[*].  However, the dentry we just looked up carries t=
he name we
> > actually want to use.
> >=20
> > [*] This is used by NFS to join a mount of a subtree into a mount o=
f a tree
> > nearer the root when the two meet, where both mounts share a superb=
lock and
> > thus a set of dentries.
> >=20
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > ---
> > fs/dcache.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 265e0ce..ff779d4 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -2698,7 +2698,7 @@ static void __d_materialise_dentry(struct den=
try *dentry, struct dentry *anon)
> >=20
> > 	dparent =3D dentry->d_parent;
> >=20
> > -	switch_names(dentry, anon);
> > +	switch_names(anon, dentry);
> > 	swap(dentry->d_name.hash, anon->d_name.hash);
> >=20
> > 	dentry->d_parent =3D dentry;
>=20
> Well spotted...
>=20
> We ought to better document the fact that =E2=80=99switch_names=E2=80=
=99 is asymmetrical. Perhaps change it to =E2=80=98update_target_name=E2=
=80=99, and then switch the argument names so that the =E2=80=99target=E2=
=80=99 really is the thing that gets updated?

Probably not worth it if Miklos's RENAME_EXCHANGE operation is making i=
t
symmetrical soon anyway?:

	http://mid.gmane.org/<1380643239-16060-4-git-send-email-miklos@szeredi=
=2Ehu>

--b.
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
