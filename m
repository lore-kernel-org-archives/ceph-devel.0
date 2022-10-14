Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A66C4332F
	for <ceph-devel@archiver.kernel.org>; Fri, 14 Oct 2022 11:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJNL51 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 14 Oct 2022 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJNL5Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Oct 2022 07:57:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45E1958D8;
        Fri, 14 Oct 2022 04:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54F62B8233F;
        Fri, 14 Oct 2022 11:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712B7C433C1;
        Fri, 14 Oct 2022 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665748641;
        bh=l7s33WW80o2Ho7V6d8lzPtmhtWRewxayd5WuDg9sK/I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=og8EYi7fMzAgCsL6j+enBcswUWiP4E+cQ6MjVB/cVJf/nmIH4ddwEDV7jjrdG27Ga
         +ADDM5BzMAh04KeJVcjo5y5xCI+2JiTlf9odRQXVoY5ERcTRAUCYM5Fy0sEBQitwQn
         w5p5ju3yUVx1pL1e+A2U3dcxMAUTEd/ZzP22/XjjTBU6fVFalWrZKgKkF5whPt7Jru
         RzZMfDyPP89FtVmtDwknzs6sgKOetPOF/7swrnWsoRK+i32Op1l8LPlcU/4hLaFUJX
         dc6F3AVAbejmne8n8T3oI35W4zJ03QYrxiWBtI4UnlVIba4TRAkFz6Oisukow5SaDN
         +JsPhhMpySZZA==
Message-ID: <f3239bc440ffc8536a72e353fe822f59c6e68e34.camel@kernel.org>
Subject: Re: [PATCH] ceph: fix a NULL vs IS_ERR() check
From:   Jeff Layton <jlayton@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Fri, 14 Oct 2022 07:57:18 -0400
In-Reply-To: <Y0kttQIe0+2Rw+SP@kili>
References: <Y0kttQIe0+2Rw+SP@kili>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Fri, 2022-10-14 at 12:36 +0300, Dan Carpenter wrote:
> The ceph_lookup_inode() function returns error pointers.  It never
> returns NULL.
>=20
> Fixes: aa87052dd965 ("ceph: fix incorrectly showing the .snap size for st=
at")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/ceph/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 4af5e55abc15..bad9eeb6a1a5 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2492,7 +2492,7 @@ int ceph_getattr(struct user_namespace *mnt_userns,=
 const struct path *path,
>  			struct inode *parent;
> =20
>  			parent =3D ceph_lookup_inode(sb, ceph_ino(inode));
> -			if (!parent)
> +			if (IS_ERR(parent))
>  				return PTR_ERR(parent);
> =20
>  			pci =3D ceph_inode(parent);


Reviewed-by: Jeff Layton <jlayton@kernel.org>
