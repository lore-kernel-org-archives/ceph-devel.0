From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: question about striped_read
Date: Wed, 31 Jul 2013 16:26:19 +0800
Message-ID: <CAAM7YA=Vr=6DgrQzsqxkAr8u-nBqdNH8y6_3TCJTEpdO4DayQA@mail.gmail.com>
References: <201307250852310158703@gmail.com>
	<alpine.DEB.2.00.1307250848160.29435@cobra.newdream.net>
	<201307260848241340451@gmail.com>
	<CAAM7YAm0VnhuYanC+gj7M==snc4XDvPd5q0qCK=DchvqPCcmDw@mail.gmail.com>
	<201307260922285205344@gmail.com>
	<CAAM7YAm5e98gzWrsEAQkvu_XEMdDTRND9=sPMOHyhFKAw-KJsw@mail.gmail.com>
	<201307260938095935695@gmail.com>
	<CAAM7YAmJgG3xPcNxw_q4HZXejZbRpMOn_ddxow7_pnyQgCrv2w@mail.gmail.com>
	<201307261007003577701@gmail.com>
	<CAAM7YAkNQA5PqVr15CXRQ5xPLk42VCCb3kf3U8ic9f6n3d9SGg@mail.gmail.com>
	<201307291100080913443@gmail.com>
	<CAAM7YAmB=o28DjT4N2KzQ73zo14miq8pDR2U6MKrGRo1MpawwQ@mail.gmail.com>
	<201307301707312612641@gmail.com>
	<CAAM7YAnRKN5APQys=G9jUyerPBRzTq7ejcHwagP9MyNmUfov6g@mail.gmail.com>
	<201307301941552785741@gmail.com>
	<CAAM7YAmmK1=F7h7ALSSCpngGNRkDk3B4doozd=YkY_wrvYGkLg@mail.gmail.com>
	<201307310827296030660@gmail.com>
	<alpine.DEB.2.00.1307301738350.14027@cobra.newdream.net>
	<201307310844488455702@gmail.com>
	<alpine.DEB.2.00.1307301746030.14027@cobra.newdream.net>
	<201307310933358798964@gmail.com>
	<CAAM7YAnGaXcQm1LcaCUGL71FGRV5zfNx1iRObFkvXsyVpu91Ag@mail.gmail.com>
	<2013073113222469570311@gmail.com>
	<CAAM7YAmv6Ar_oTdYG31YSHnQwyUUYSNq3Zj_4fHcwMoOvno7Sw@mail.gmail.com>
	<201307311532055128853@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:36419 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab3GaI0V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 04:26:21 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so287294lab.12
        for <ceph-devel@vger.kernel.org>; Wed, 31 Jul 2013 01:26:19 -0700 (PDT)
In-Reply-To: <201307311532055128853@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 31, 2013 at 3:32 PM, majianpeng <majianpeng@gmail.com> wrote:
>
>  [snip]
> Test case
> A: touch file
>     dd if=file of=/dev/null bs=5M count=1 iflag=direct
> B: [data(2M)|hole(2m)][data(2M)]
>    dd if=file of=/dev/null bs=8M count=1 iflag=direct
> C: [data(4M)[hole(4M)][hole(4M)][data(2M)]
>   dd if=file of=/dev/null bs=16M count=1 iflag=direct
> D: touch file;truncate -s 5M file
>   dd if=file of=/dev/null bs=8M count=1 iflag=direct
>
> Those cases can work.
> Now i make different processing  for short-read between 'ret > 0' and "ret =0".
> For the short-read which ret > 0, it don't do read-page rather than zero the left area.
> This means reduce one meaningless read operation.
>

This patch looks good. But I still hope not to duplicate code.

how about change
 "hit_stripe = this_len < left;"
to
 "hit_stripe = this_len < left && (ret == this_len || pos + this_len <
inode->i_size);"

> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2ddf061..f643ec8 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -350,13 +350,17 @@ more:
>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>
>         if (ret > 0) {

changes this to "(ret >= 0)"

> -               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> -
> -               if (read < pos - off) {
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2ddf061..f643ec8 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -350,13 +350,17 @@ more:
>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>
>         if (ret > 0) {
> -               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> -
> -               if (read < pos - off) {
> -                       dout(" zero gap %llu to %llu\n", off + read, pos);
> -                       ceph_zero_page_vector_range(page_align + read,
> -                                                   pos - off - read, pages);
> +               int  didpages;
> +
> +               if (was_short && pos + ret < inode->i_size) {

change this to "(was_short && hit_stripe)"

by this way, we can avoid modifying the "zero trailing bytes" code.

Regards,
Yan, Zheng

> +                        u64 tmp = min(this_len - ret,
> +                                               inode->i_size - pos - ret);
> +                        dout(" zero gap %llu to %llu\n", pos + ret, pos + ret + tmp);
> +                        ceph_zero_page_vector_range(page_align + read + ret,
> +                                                       tmp, pages);
> +                        ret += tmp;
>                 }
> +               didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>                 pos += ret;
>                 read = pos - off;
>                 left -= ret;
> @@ -375,13 +379,25 @@ more:
>
>                 /* zero trailing bytes (inside i_size) */
>                 if (left > 0 && pos < inode->i_size) {
> +                       int didpages;
>                         if (pos + left > inode->i_size)
>                                 left = inode->i_size - pos;
>
> -                       dout("zero tail %d\n", left);
> -                       ceph_zero_page_vector_range(page_align + read, left,
> +                       ret = min(left, this_len);
> +                       dout("zero tail %d\n", ret);
> +                       ceph_zero_page_vector_range(page_align + read, ret,
>                                                     pages);
> -                       read += left;
> +                       didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> +
> +                       pos += ret;
> +                       read = pos - off;
> +                       left -= ret;
> +                       page_pos += didpages;
> +                       pages_left -= didpages;
> +
> +                       /* hit stripe? */
> +                       if (left && hit_stripe)
> +                               goto more;
>                 }
>         }
>
