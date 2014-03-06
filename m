From: Trond Myklebust <trond.myklebust@primarydata.com>
Subject: Re: [PATCH][RESEND] vfs: Make __d_materialise_dentry() set the materialised dentry name correctly
Date: Thu, 6 Mar 2014 09:35:01 -0500
Message-ID: <6487FCC2-FB5C-4A32-94EF-5D3352A39781@primarydata.com>
References: <1394115376-17109-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52701 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbaCFOfF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 09:35:05 -0500
Received: by mail-ie0-f179.google.com with SMTP id lx4so2765648iec.10
        for <ceph-devel@vger.kernel.org>; Thu, 06 Mar 2014 06:35:04 -0800 (PST)
In-Reply-To: <1394115376-17109-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, Viro Alexander <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, sage@inktank.com


On Mar 6, 2014, at 9:16, Yan, Zheng <zheng.z.yan@intel.com> wrote:

> From: David Howells <dhowells@redhat.com>
>=20
> Make __d_materialise_dentry() set the materialised dentry name correc=
tly by
> flipping the arguments to switch_names().
>=20
> switch_names() is lazy: if both names are internal to their dentries,=
 it'll
> overwrite that of the first dentry with that of the second, and won't=
 update
> that of the second.
>=20
> In the case of __d_materialise_dentry(), the second is an already ext=
ant
> anonymous dentry that we want to insert into the tree in place of the=
 dentry we
> just looked up[*].  However, the dentry we just looked up carries the=
 name we
> actually want to use.
>=20
> [*] This is used by NFS to join a mount of a subtree into a mount of =
a tree
> nearer the root when the two meet, where both mounts share a superblo=
ck and
> thus a set of dentries.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> fs/dcache.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 265e0ce..ff779d4 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2698,7 +2698,7 @@ static void __d_materialise_dentry(struct dentr=
y *dentry, struct dentry *anon)
>=20
> 	dparent =3D dentry->d_parent;
>=20
> -	switch_names(dentry, anon);
> +	switch_names(anon, dentry);
> 	swap(dentry->d_name.hash, anon->d_name.hash);
>=20
> 	dentry->d_parent =3D dentry;

Well spotted...

We ought to better document the fact that =92switch_names=92 is asymmet=
rical. Perhaps change it to =91update_target_name=92, and then switch t=
he argument names so that the =92target=92 really is the thing that get=
s updated?

_________________________________
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
