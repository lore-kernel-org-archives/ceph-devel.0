From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] rbd: fix the memory leak of bio_chain_clone
Date: Mon, 2 Jul 2012 11:39:24 -0700
Message-ID: <CAPYLRzhHiEPRm_zU-f_yzbZ72c6H--8NXh39zzCNurBVyHn35Q@mail.gmail.com>
References: <1340609863-10971-1-git-send-email-gzhao@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33553 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab2GBSjZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 14:39:25 -0400
Received: by lbbgm6 with SMTP id gm6so8012628lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 11:39:24 -0700 (PDT)
In-Reply-To: <1340609863-10971-1-git-send-email-gzhao@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hey guys,
I'm checking through the archives and I didn't see any replies to this
patch, nor does it appear in our tree that I can see. We should
probably let him know what we're doing with it. :)
-Greg

On Mon, Jun 25, 2012 at 12:37 AM, Guangliang Zhao <gzhao@suse.com> wrot=
e:
> Signed-off-by: Guangliang Zhao <gzhao@suse.com>
> ---
> =A0drivers/block/rbd.c | =A0 10 ++++------
> =A01 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 65665c9..3d6dfc8 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -719,8 +719,6 @@ static struct bio *bio_chain_clone(struct bio **o=
ld, struct bio **next,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (total + old_chain->bi_size > len)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct bio_pair *bp;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this split can o=
nly happen with a single paged bio,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* split_bio will B=
UG_ON if this is not the case
> @@ -732,13 +730,13 @@ static struct bio *bio_chain_clone(struct bio *=
*old, struct bio **next,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* split the bio. We'=
ll release it either in the next
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call, or it wi=
ll have to be released outside */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bp =3D bio_split(old_ch=
ain, (len - total) / SECTOR_SIZE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *bp =3D bio_split(old_c=
hain, (len - total) / SECTOR_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!*bp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto =
err_out;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __bio_clone(tmp, &bp->b=
io1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __bio_clone(tmp, &(*bp)=
->bio1);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *next =3D &bp->bio2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *next =3D &(*bp)->bio2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __bio_clone(tmp, old_=
chain);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *next =3D old_chain->=
bi_next;
> --
> 1.7.3.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
