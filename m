From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH] ceph: Document that dentry is unused in xattr ->get
Date: Wed, 25 May 2016 09:56:55 -0400
Message-ID: <1464184615.14859.4.camel@poochiereds.net>
References: <1464175265-1339-1-git-send-email-agruenba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35494 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcEYN47 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2016 09:56:59 -0400
Received: by mail-yw0-f195.google.com with SMTP id n16so6804554ywd.2
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2016 06:56:59 -0700 (PDT)
In-Reply-To: <1464175265-1339-1-git-send-email-agruenba@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 2016-05-25 at 13:21 +0200, Andreas Gruenbacher wrote:
> For consistency with the other filesystems, rename the dentry argumen=
t
> to "unused" here.
>=20
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
> =C2=A0fs/ceph/xattr.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 0d66722..223f567 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1042,7 +1042,7 @@ out:
> =C2=A0}
> =C2=A0
> =C2=A0static int ceph_get_xattr_handler(const struct xattr_handler *h=
andler,
> -				=C2=A0=C2=A0struct dentry *dentry, struct inode *inode,
> +				=C2=A0=C2=A0struct dentry *unused, struct inode *inode,
> =C2=A0				=C2=A0=C2=A0const char *name, void *value, size_t size)
> =C2=A0{
> =C2=A0	if (!ceph_is_valid_xattr(name))

Acked-by: Jeff Layton <jlayton@poochiereds.net>

=2E..that said, it'd be even better to just __always_unused attribute o=
n
the variable. That gives the same hint to the compiler as well...
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
