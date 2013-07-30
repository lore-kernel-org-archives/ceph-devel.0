From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: question about striped_read
Date: Tue, 30 Jul 2013 10:56:02 +0800
Message-ID: <CAAM7YAmF9KBZ8zZbpE2d=fEuApxh-cJuAuDP5ojDd_=KPFgkBg@mail.gmail.com>
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
	<201307300856506858451@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:42484 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab3G3C4E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 22:56:04 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so627133lab.33
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 19:56:02 -0700 (PDT)
In-Reply-To: <201307300856506858451@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 30, 2013 at 10:08 AM, majianpeng <majianpeng@gmail.com> wrote:
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
>
> From above test, i think your patch is right.
> Although, the original code can work but it  call multi striped_read.

For test case
---
dd if=/dev/urandom bs=1M count=2 of=file_with_holes
dd if=/dev/urandom bs=1M count=2 seek=4 of=file_with_holes conv=notrunc
dd if=file_with_holes bs=8M iflag=direct >/dev/null

I got
---
ceph:  striped_read 0~8388608 (read 0) got 2097152 HITSTRIPE SHORT
ceph:  striped_read 2097152~6291456 (read 2097152) got 0 HITSTRIPE SHORT
ceph:  zero tail 4194304
ceph:  striped_read returns 6291456
ceph:  sync_read result 6291456
ceph:  aio_read ffff88000fb22f98 10000193e8c.fffffffffffffffe dropping
cap refs on Fcr = 6291456

the original code zeros data in range 2M~6M, it's obvious incorrect.

> As your said for stripe short-read,it doesn't make sense to return rather than reading next stripe.
> But can you add some comments for this?
> The short-read reasongs are two:EOF or hit-hole.
> But for hit-hole there are some differents case. For that i don't know.
>

For hit-hole, there is only one case: the strip object's size is
smaller then 4M. When reading
a strip object, if the returned data is less than we expected, we need
to check if following strip
objects have data.

I think the original code and my patch doesn't handle the below case properly.

| object 0 |  hole  |  hole |  object 3 |
dd if=testfile iflag=direct bs=16M >/dev/null

Could you write a patch, do some tests and submit it.

Regards
Yan, Zheng
