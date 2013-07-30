From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: question about striped_read
Date: Tue, 30 Jul 2013 20:25:43 +0800
Message-ID: <CAAM7YAmmK1=F7h7ALSSCpngGNRkDk3B4doozd=YkY_wrvYGkLg@mail.gmail.com>
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
	<CAAM7YAnRKN5APQys=G9jUyerPBRzTq7ejcHwagP9MyNmUfov6g@mail.gmail.com>
	<201307301941552785741@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:48574 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab3G3MZp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 08:25:45 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so954861lab.5
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 05:25:44 -0700 (PDT)
In-Reply-To: <201307301941552785741@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 30, 2013 at 7:41 PM, majianpeng <majianpeng@gmail.com> wrote:
>>>
>>>>dd if=/dev/urandom bs=1M count=2 of=file_with_holes
>>>>dd if=/dev/urandom bs=1M count=2 seek=4 of=file_with_holes conv=notrunc
>>>>dd if=file_with_holes bs=8M >/dev/null
>>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 2ddf061..22a98e5 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -349,17 +349,17 @@ more:
>>>         dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
>>>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>>>
>>> -       if (ret > 0) {
>>> -               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>>> +       if (ret >= 0) {
>>> +               int didpages = (page_align + this_len) >> PAGE_CACHE_SHIFT;
>>>
>>> -               if (read < pos - off) {
>>> -                       dout(" zero gap %llu to %llu\n", off + read, pos);
>>> -                       ceph_zero_page_vector_range(page_align + read,
>>> -                                                   pos - off - read, pages);
>>> +               if (was_short) {
>>> +                       dout(" zero gap %llu to %llu\n", pos + ret, pos + this_len);
>>> +                       ceph_zero_page_vector_range(page_align + ret,
>>> +                                                   this_len - ret, pages);
>>>                 }
>>> -               pos += ret;
>>> +               pos += this_len;
>>>                 read = pos - off;
>>> -               left -= ret;
>>> +               left -= this_len;
>>>                 page_pos += didpages;
>>>                 pages_left -= didpages;
>>>
>>> This patch can do those case. It only add ret== 0 in judgement 'ret > 0".
>>
>>maybe we should add a  i_size check. stop reading next strip object
>>when 'pos > i_size'
>>
> I think we can't do this because i_size may smaller than real size in ceph.
>
ceph_aio_read() calls ceph_do_getattr() when 'checkeof = true', it
handles the case.

We must do i_size check in striped_read(), otherwise user program always gets as
much data as it requests. For example

dd if=/dev/urandom bs=1M count=1 of=file_with_holes
dd if=file_with_holes bs=64M iflag=direct of=/dev/null

Regards
Yan, Zheng


>>> But i think i will add a parameter about hit_hole. It will make the code easy to understand.
>>>
>>
>> i think 'was_short' is equal to 'hit_hole'
>>
[snip]
