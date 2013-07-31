From: Sage Weil <sage@inktank.com>
Subject: Re: Re: question about striped_read
Date: Tue, 30 Jul 2013 17:40:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307301738350.14027@cobra.newdream.net>
References: <201307250852310158703@gmail.com> <201307251455102701172@gmail.com> <CAAM7YAnDKvGBsXxzbcsFHTbTo7-7AgNnRXRCK+gEbvkwGuj5cg@mail.gmail.com> <alpine.DEB.2.00.1307250848160.29435@cobra.newdream.net> <201307260848241340451@gmail.com>
 <CAAM7YAm0VnhuYanC+gj7M==snc4XDvPd5q0qCK=DchvqPCcmDw@mail.gmail.com> <201307260922285205344@gmail.com> <CAAM7YAm5e98gzWrsEAQkvu_XEMdDTRND9=sPMOHyhFKAw-KJsw@mail.gmail.com> <201307260938095935695@gmail.com> <CAAM7YAmJgG3xPcNxw_q4HZXejZbRpMOn_ddxow7_pnyQgCrv2w@mail.gmail.com>
 <201307261007003577701@gmail.com> <CAAM7YAkNQA5PqVr15CXRQ5xPLk42VCCb3kf3U8ic9f6n3d9SGg@mail.gmail.com> <201307291100080913443@gmail.com> <CAAM7YAmB=o28DjT4N2KzQ73zo14miq8pDR2U6MKrGRo1MpawwQ@mail.gmail.com> <201307301707312612641@gmail.com>
 <CAAM7YAnRKN5APQys=G9jUyerPBRzTq7ejcHwagP9MyNmUfov6g@mail.gmail.com> <201307301941552785741@gmail.com>,  <CAAM7YAmmK1=F7h7ALSSCpngGNRkDk3B4doozd=YkY_wrvYGkLg@mail.gmail.com> <201307310827296030660@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43040 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab3GaAka (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 20:40:30 -0400
In-Reply-To: <201307310827296030660@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 31 Jul 2013, majianpeng wrote:
> >On Tue, Jul 30, 2013 at 7:41 PM, majianpeng <majianpeng@gmail.com> wrote:
> >>>>
> >>>>>dd if=/dev/urandom bs=1M count=2 of=file_with_holes
> >>>>>dd if=/dev/urandom bs=1M count=2 seek=4 of=file_with_holes conv=notrunc
> >>>>>dd if=file_with_holes bs=8M >/dev/null
> >>>>>
> >>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> >>>> index 2ddf061..22a98e5 100644
> >>>> --- a/fs/ceph/file.c
> >>>> +++ b/fs/ceph/file.c
> >>>> @@ -349,17 +349,17 @@ more:
> >>>>         dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
> >>>>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
> >>>>
> >>>> -       if (ret > 0) {
> >>>> -               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> >>>> +       if (ret >= 0) {
> >>>> +               int didpages = (page_align + this_len) >> PAGE_CACHE_SHIFT;
> >>>>
> >>>> -               if (read < pos - off) {
> >>>> -                       dout(" zero gap %llu to %llu\n", off + read, pos);
> >>>> -                       ceph_zero_page_vector_range(page_align + read,
> >>>> -                                                   pos - off - read, pages);
> >>>> +               if (was_short) {
> >>>> +                       dout(" zero gap %llu to %llu\n", pos + ret, pos + this_len);
> >>>> +                       ceph_zero_page_vector_range(page_align + ret,
> >>>> +                                                   this_len - ret, pages);
> >>>>                 }
> >>>> -               pos += ret;
> >>>> +               pos += this_len;
> >>>>                 read = pos - off;
> >>>> -               left -= ret;
> >>>> +               left -= this_len;
> >>>>                 page_pos += didpages;
> >>>>                 pages_left -= didpages;
> >>>>
> >>>> This patch can do those case. It only add ret== 0 in judgement 'ret > 0".
> >>>
> >>>maybe we should add a  i_size check. stop reading next strip object
> >>>when 'pos > i_size'
> >>>
> >> I think we can't do this because i_size may smaller than real size in ceph.
> >>
> >ceph_aio_read() calls ceph_do_getattr() when 'checkeof = true', it
> >handles the case.
> >
> >We must do i_size check in striped_read(), otherwise user program always gets as
> >much data as it requests. For example
> >
> >dd if=/dev/urandom bs=1M count=1 of=file_with_holes
> >dd if=file_with_holes bs=64M iflag=direct of=/dev/null
> >
> Before doing that, we must know the meaning of return value.

For ceph_osdc_readpages(),

> A: ret = ENOENT

The object does not exist.

> B: ret = 0

The object exists but we read 0 bytes, which means we are past EOF or the 
object has size 0 bytes.  Either way, we are either in a hole or past EOF.

sage

> 
> Only we knowed this, we can handle exactly.
> Sage, can you explain those meaning in detail?
> 
> Thanks!
> Jianpeng Ma
> 
> >Regards
> >Yan, Zheng
> >
> >
> >>>> But i think i will add a parameter about hit_hole. It will make the code easy to understand.
> >>>>
> >>>
> >>> i think 'was_short' is equal to 'hit_hole'
> >>>
> >[snip]
> Thanks!
> Jianpeng Ma
> >On Tue, Jul 30, 2013 at 7:41 PM, majianpeng <majianpeng@gmail.com> wrote:
> >>>>
> >>>>>dd if=/dev/urandom bs=1M count=2 of=file_with_holes
> >>>>>dd if=/dev/urandom bs=1M count=2 seek=4 of=file_with_holes conv=notrunc
> >>>>>dd if=file_with_holes bs=8M >/dev/null
> >>>>>
> >>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> >>>> index 2ddf061..22a98e5 100644
> >>>> --- a/fs/ceph/file.c
> >>>> +++ b/fs/ceph/file.c
> >>>> @@ -349,17 +349,17 @@ more:
> >>>>         dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
> >>>>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
> >>>>
> >>>> -       if (ret > 0) {
> >>>> -               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> >>>> +       if (ret >= 0) {
> >>>> +               int didpages = (page_align + this_len) >> PAGE_CACHE_SHIFT;
> >>>>
> >>>> -               if (read < pos - off) {
> >>>> -                       dout(" zero gap %llu to %llu\n", off + read, pos);
> >>>> -                       ceph_zero_page_vector_range(page_align + read,
> >>>> -                                                   pos - off - read, pages);
> >>>> +               if (was_short) {
> >>>> +                       dout(" zero gap %llu to %llu\n", pos + ret, pos + this_len);
> >>>> +                       ceph_zero_page_vector_range(page_align + ret,
> >>>> +                                                   this_len - ret, pages);
> >>>>                 }
> >>>> -               pos += ret;
> >>>> +               pos += this_len;
> >>>>                 read = pos - off;
> >>>> -               left -= ret;
> >>>> +               left -= this_len;
> >>>>                 page_pos += didpages;
> >>>>                 pages_left -= didpages;
> >>>>
> >>>> This patch can do those case. It only add ret== 0 in judgement 'ret > 0".
> >>>
> >>>maybe we should add a  i_size check. stop reading next strip object
> >>>when 'pos > i_size'
> >>>
> >> I think we can't do this because i_size may smaller than real size in ceph.
> >>
> >ceph_aio_read() calls ceph_do_getattr() when 'checkeof = true', it
> >handles the case.
> >
> >We must do i_size check in striped_read(), otherwise user program always gets as
> >much data as it requests. For example
> >
> >dd if=/dev/urandom bs=1M count=1 of=file_with_holes
> >dd if=file_with_holes bs=64M iflag=direct of=/dev/null
> >
> >Regards
> >Yan, Zheng
> >
> >
> >>>> But i think i will add a parameter about hit_hole. It will make the code easy to understand.
> >>>>
> >>>
> >>> i think 'was_short' is equal to 'hit_hole'
> >>>
> >[snip]
