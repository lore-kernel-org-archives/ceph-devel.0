From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: question about striped_read
Date: Tue, 30 Jul 2013 19:14:15 +0800
Message-ID: <CAAM7YAnRKN5APQys=G9jUyerPBRzTq7ejcHwagP9MyNmUfov6g@mail.gmail.com>
References: <201307250852310158703@gmail.com>
	<alpine.DEB.2.00.1307242252080.10870@cobra.newdream.net>
	<201307251455102701172@gmail.com>
	<CAAM7YAnDKvGBsXxzbcsFHTbTo7-7AgNnRXRCK+gEbvkwGuj5cg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:33687 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3G3LOR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 07:14:17 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1316576lab.14
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 04:14:15 -0700 (PDT)
In-Reply-To: <201307301707312612641@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 30, 2013 at 7:01 PM, majianpeng <majianpeng@gmail.com> wrote:
>>On Mon, Jul 29, 2013 at 11:00 AM, majianpeng <majianpeng@gmail.com> wrote:
>>>
>>> [snip]
>>> >I don't think the later was_short can handle the hole case. For the hole case,
>>> >we should try reading next strip object instead of return. how about
>>> >below patch.
>>> >
>>> Hi Yan,
>>>         i uesed this demo to test hole case.
>>> dd if=/dev/urandom bs=4096 count=2 of=file_with_holes
>>> dd if=/dev/urandom bs=4096 seek=7 count=2 of=file_with_holes
>>>
>>> dd if=file_with_holes of=/dev/null bs=16k count=1 iflag=direct
>>> Using the dynamic_debug in striped_read,  the message are:
>>> >[ 8743.663499] ceph:           file.c:350  : striped_read 0~16384 (read 0) got 16384
>>> >[ 8743.663502] ceph:           file.c:390  : striped_read returns 16384
>>> From the messages, we can see it can't hit the short-read.
>>> For the ceph-file-hole, how does the ceph handle?
>>> Or am i missing something?
>>
>>the default strip size is 4M, all data are written to the first object
>>in your test case.
>>could you try something like below.
>>
>
>>dd if=/dev/urandom bs=1M count=2 of=file_with_holes
>>dd if=/dev/urandom bs=1M count=2 seek=4 of=file_with_holes conv=notrunc
>>dd if=file_with_holes bs=8M >/dev/null
>>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2ddf061..22a98e5 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -349,17 +349,17 @@ more:
>         dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>
> -       if (ret > 0) {
> -               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> +       if (ret >= 0) {
> +               int didpages = (page_align + this_len) >> PAGE_CACHE_SHIFT;
>
> -               if (read < pos - off) {
> -                       dout(" zero gap %llu to %llu\n", off + read, pos);
> -                       ceph_zero_page_vector_range(page_align + read,
> -                                                   pos - off - read, pages);
> +               if (was_short) {
> +                       dout(" zero gap %llu to %llu\n", pos + ret, pos + this_len);
> +                       ceph_zero_page_vector_range(page_align + ret,
> +                                                   this_len - ret, pages);
>                 }
> -               pos += ret;
> +               pos += this_len;
>                 read = pos - off;
> -               left -= ret;
> +               left -= this_len;
>                 page_pos += didpages;
>                 pages_left -= didpages;
>
> This patch can do those case. It only add ret== 0 in judgement 'ret > 0".

maybe we should add a  i_size check. stop reading next strip object
when 'pos > i_size'

> But i think i will add a parameter about hit_hole. It will make the code easy to understand.
>

 i think 'was_short' is equal to 'hit_hole'

Regards
Yan, Zheng

>
>
>>Regards
>>Yan, Zheng
>>
>>
>>>
>>>
>>> Thanks!
>>> Jianpeng Ma
>>>
>>> >Regards
>>> >Yan, Zheng
>>> >---
>>> >diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> >index 271a346..6ca2921 100644
>>> >--- a/fs/ceph/file.c
>>> >+++ b/fs/ceph/file.c
>>> >@@ -350,16 +350,17 @@ more:
>>> >            ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>>> >
>>> >       if (ret > 0) {
>>> >-              int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>>> >+              int didpages = (page_align + this_len) >> PAGE_CACHE_SHIFT;
>>> >
>>> >-              if (read < pos - off) {
>>> >-                      dout(" zero gap %llu to %llu\n", off + read, pos);
>>> >-                      ceph_zero_page_vector_range(page_align + read,
>>> >-                                                  pos - off - read, pages);
>>> >+              if (was_short) {
>>> >+                      dout(" zero gap %llu to %llu\n",
>>> >+                           pos + ret, pos + this_len);
>>> >+                      ceph_zero_page_vector_range(page_align + ret,
>>> >+                                                  this_len - ret, page_pos);
>>> >               }
>>> >-              pos += ret;
>>> >+              pos += this_len;
>>> >               read = pos - off;
>>> >-              left -= ret;
>>> >+              left -= this_len;
>>> >               page_pos += didpages;
>>> >               pages_left -= didpages;
>>> >
> Thanks!
> Jianpeng Ma
>>On Mon, Jul 29, 2013 at 11:00 AM, majianpeng <majianpeng@gmail.com> wrote:
>>>
>>> [snip]
>>> >I don't think the later was_short can handle the hole case. For the hole case,
>>> >we should try reading next strip object instead of return. how about
>>> >below patch.
>>> >
>>> Hi Yan,
>>>         i uesed this demo to test hole case.
>>> dd if=/dev/urandom bs=4096 count=2 of=file_with_holes
>>> dd if=/dev/urandom bs=4096 seek=7 count=2 of=file_with_holes
>>>
>>> dd if=file_with_holes of=/dev/null bs=16k count=1 iflag=direct
>>> Using the dynamic_debug in striped_read,  the message are:
>>> >[ 8743.663499] ceph:           file.c:350  : striped_read 0~16384 (read 0) got 16384
>>> >[ 8743.663502] ceph:           file.c:390  : striped_read returns 16384
>>> From the messages, we can see it can't hit the short-read.
>>> For the ceph-file-hole, how does the ceph handle?
>>> Or am i missing something?
>>
>>the default strip size is 4M, all data are written to the first object
>>in your test case.
>>could you try something like below.
>>
>>dd if=/dev/urandom bs=1M count=2 of=file_with_holes
>>dd if=/dev/urandom bs=1M count=2 seek=4 of=file_with_holes conv=notrunc
>>dd if=file_with_holes bs=8M >/dev/null
>>
>>Regards
>>Yan, Zheng
>>
>>
>>>
>>>
>>> Thanks!
>>> Jianpeng Ma
>>>
>>> >Regards
>>> >Yan, Zheng
>>> >---
>>> >diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> >index 271a346..6ca2921 100644
>>> >--- a/fs/ceph/file.c
>>> >+++ b/fs/ceph/file.c
>>> >@@ -350,16 +350,17 @@ more:
>>> >            ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>>> >
>>> >       if (ret > 0) {
>>> >-              int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>>> >+              int didpages = (page_align + this_len) >> PAGE_CACHE_SHIFT;
>>> >
>>> >-              if (read < pos - off) {
>>> >-                      dout(" zero gap %llu to %llu\n", off + read, pos);
>>> >-                      ceph_zero_page_vector_range(page_align + read,
>>> >-                                                  pos - off - read, pages);
>>> >+              if (was_short) {
>>> >+                      dout(" zero gap %llu to %llu\n",
>>> >+                           pos + ret, pos + this_len);
>>> >+                      ceph_zero_page_vector_range(page_align + ret,
>>> >+                                                  this_len - ret, page_pos);
>>> >               }
>>> >-              pos += ret;
>>> >+              pos += this_len;
>>> >               read = pos - off;
>>> >-              left -= ret;
>>> >+              left -= this_len;
>>> >               page_pos += didpages;
>>> >               pages_left -= didpages;
>>> >
