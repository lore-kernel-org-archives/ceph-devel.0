From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: question about striped_read
Date: Thu, 1 Aug 2013 11:29:14 +0800
Message-ID: <CAAM7YAkP5LAY5Q+6fmuJkV6t9c-GZtQrwrC3awxRZ=LcRpt4xg@mail.gmail.com>
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
	<CAAM7YA=Vr=6DgrQzsqxkAr8u-nBqdNH8y6_3TCJTEpdO4DayQA@mail.gmail.com>
	<201308010929458493571@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44007 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab3HAD3P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 23:29:15 -0400
Received: by mail-lb0-f177.google.com with SMTP id r11so1127650lbv.8
        for <ceph-devel@vger.kernel.org>; Wed, 31 Jul 2013 20:29:14 -0700 (PDT)
In-Reply-To: <201308010929458493571@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 1, 2013 at 9:45 AM, majianpeng <majianpeng@gmail.com> wrote:
>>On Wed, Jul 31, 2013 at 3:32 PM, majianpeng <majianpeng@gmail.com> wrote:
>>>
>>>  [snip]
>>> Test case
>>> A: touch file
>>>     dd if=file of=/dev/null bs=5M count=1 iflag=direct
>>> B: [data(2M)|hole(2m)][data(2M)]
>>>    dd if=file of=/dev/null bs=8M count=1 iflag=direct
>>> C: [data(4M)[hole(4M)][hole(4M)][data(2M)]
>>>   dd if=file of=/dev/null bs=16M count=1 iflag=direct
>>> D: touch file;truncate -s 5M file
>>>   dd if=file of=/dev/null bs=8M count=1 iflag=direct
>>>
>>> Those cases can work.
>>> Now i make different processing  for short-read between 'ret > 0' and "ret =0".
>>> For the short-read which ret > 0, it don't do read-page rather than zero the left area.
>>> This means reduce one meaningless read operation.
>>>
>>
>>This patch looks good. But I still hope not to duplicate code.
>>
>>how about change
>> "hit_stripe = this_len < left;"
>>to
>> "hit_stripe = this_len < left && (ret == this_len || pos + this_len <
>>inode->i_size);"
>>
> To make the code easy to understand, i don't apply your suggestion.But i add this check on the judgement of
> whether read more contents.
> The follow is the latest patch.Can you check?
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2ddf061..3d8d14d 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -349,44 +349,38 @@ more:
>         dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>
> -       if (ret > 0) {
> -               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> -
> -               if (read < pos - off) {
> -                       dout(" zero gap %llu to %llu\n", off + read, pos);
> -                       ceph_zero_page_vector_range(page_align + read,
> -                                                   pos - off - read, pages);
> +       if (ret >= 0) {
> +               int  didpages;
> +               if (was_short && (pos + ret < inode->i_size)) {
> +                       u64 tmp = min(this_len - ret,
> +                                inode->i_size - pos - ret);
> +                       dout(" zero gap %llu to %llu\n",
> +                               pos + ret, pos + ret + tmp);
> +                       ceph_zero_page_vector_range(page_align + read + ret,
> +                                                       tmp, pages);
> +                       ret += tmp;
>                 }
> +
> +               didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>                 pos += ret;
>                 read = pos - off;
>                 left -= ret;
>                 page_pos += didpages;
>                 pages_left -= didpages;
>
> -               /* hit stripe? */
> -               if (left && hit_stripe)
> +               /* hit stripe and need continue*/
> +               if (left && hit_stripe && pos < inode->i_size)
>                         goto more;
> +
>         }
>
> -       if (was_short) {
> +       if (ret >= 0) {
> +               ret = read;
>                 /* did we bounce off eof? */
>                 if (pos + left > inode->i_size)
>                         *checkeof = 1;
> -
> -               /* zero trailing bytes (inside i_size) */
> -               if (left > 0 && pos < inode->i_size) {
> -                       if (pos + left > inode->i_size)
> -                               left = inode->i_size - pos;
> -
> -                       dout("zero tail %d\n", left);
> -                       ceph_zero_page_vector_range(page_align + read, left,
> -                                                   pages);
> -                       read += left;
> -               }
>         }
>
> -       if (ret >= 0)
> -               ret = read;

I think this line should be "if (read > 0) ret = read;". Other than
this, your patch looks good.
You can add "Reviewed-by: Yan, Zheng <zheng.z.yan@intel.com>" to your
formal patch.

Regards
Yan, Zheng


>         dout("striped_read returns %d\n", ret);
>         return ret;
>  }
>
> Thanks!
> Jianpeng Ma
