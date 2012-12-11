From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: Behavior of librbd::Image::read_iterate() changed?
Date: Tue, 11 Dec 2012 12:12:23 +0800
Message-ID: <CANExM-PpR-hqS-qykL-nBNXBQ3zcorj6LtctFCvXwXbO-MUr3Q@mail.gmail.com>
References: <CANExM-MYm5iomxv1GszEOo4+PJouGCzC+ssjm0FHhX1GuD-FXQ@mail.gmail.com>
	<50C2CA78.5010005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:52779 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab2LKEMY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 23:12:24 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so13140319iea.16
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 20:12:23 -0800 (PST)
In-Reply-To: <50C2CA78.5010005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for your reply, Dan.

It really seems due to new stripping codes. Below are the debug
messages of rbd export:

root@ceph1:~# rbd -p rbdtest export image1 out1 --debug_rbd 20
--debug_striper 20
2012-12-11 12:06:21.538932 7f50a5fea780 20 librbd: open_image: ictx =
0x27b33a0 name = 'image1' id = '' snap_name = ''
2012-12-11 12:06:21.542949 7f50a5fea780 20 librbd: detect format of image1 : old
2012-12-11 12:06:21.542970 7f50a5fea780 20 librbd: ictx_refresh 0x27b33a0
2012-12-11 12:06:21.547103 7f50a5fea780 10 librbd::ImageCtx:
init_layout stripe_unit 4194304 stripe_count 1 object_size 4194304
prefix rb.0.652e.6b8b4567 format rb.0.652e.6b8b4567.%012llx
2012-12-11 12:06:21.550876 7f50a5fea780 20 librbd::ImageCtx: watching
header object returned 0
2012-12-11 12:06:21.550916 7f50a5fea780 20 librbd: info 0x27b33a0
2012-12-11 12:06:21.550921 7f50a5fea780 20 librbd: ictx_check 0x27b33a0
2012-12-11 12:06:21.550983 7f50a5fea780 20 librbd: read_iterate
0x27b33a0 off = 0 len = 1073741824
2012-12-11 12:06:21.550988 7f50a5fea780 20 librbd: ictx_check 0x27b33a0
2012-12-11 12:06:21.551006 7f50a5fea780 20 librbd: aio_read 0x27b33a0
completion 0x27b4b10 [0,4194304]
2012-12-11 12:06:21.551009 7f50a5fea780 20 librbd: ictx_check 0x27b33a0
2012-12-11 12:06:21.551017 7f50a5fea780 10 striper file_to_extents
0~4194304 format rb.0.652e.6b8b4567.%012llx
2012-12-11 12:06:21.553971 7f50a5fea780 20 striper  su 4194304 sc 1 os
4194304 stripes_per_object 1
2012-12-11 12:06:21.553981 7f50a5fea780 20 striper  off 0 blockno 0
stripeno 0 stripepos 0 objectsetno 0 objectno 0 block_start 0
block_off 0 0~4194304
2012-12-11 12:06:21.554146 7f50a5fea780 20 striper  added new
extent(rb.0.652e.6b8b4567.000000000000 (0) in @14 0~4194304 -> [])
2012-12-11 12:06:21.554176 7f50a5fea780 15 striper file_to_extents
extent(rb.0.652e.6b8b4567.000000000000 (0) in @14 0~4194304 ->
[0,4194304]) in @14
2012-12-11 12:06:21.554180 7f50a5fea780 20 librbd:  oid
rb.0.652e.6b8b4567.000000000000 0~4194304 from [0,4194304]
2012-12-11 12:06:21.554194 7f50a5fea780 20 librbd::AioRequest: send
0x27b5530 rb.0.652e.6b8b4567.000000000000 0~4194304
2012-12-11 12:06:21.555059 7f50a5fea780 20 librbd::AioCompletion:
AioCompletion::finish_adding_requests 0x27b4b10 pending 1
2012-12-11 12:06:21.556193 7f50937fe700 20 librbd::AioRequest:
should_complete 0x27b5530 rb.0.652e.6b8b4567.000000000000 0~4194304 r
= -2
2012-12-11 12:06:21.556246 7f50937fe700 10 striper extent_to_file 0 0~4194304
2012-12-11 12:06:21.556248 7f50937fe700 20 striper  stripes_per_object 1
2012-12-11 12:06:21.556249 7f50937fe700 20 striper  object 0~4194304
-> file 0~4194304
2012-12-11 12:06:21.556251 7f50937fe700 10 librbd::ImageCtx:
prune_parent_extents image overlap 0, object overlap 0 from image
extents []
2012-12-11 12:06:21.556254 7f50937fe700 10 librbd::AioCompletion:
C_AioRead::finish() 0x27b3fc0 r = -2
2012-12-11 12:06:21.556255 7f50937fe700 10 librbd::AioCompletion:  got
{} for [0,4194304] bl 0
2012-12-11 12:06:21.556264 7f50937fe700 10 striper
add_partial_sparse_result(0x27b4bf8) 0 covering {0=0} (offset 0) to
[0,4194304]
2012-12-11 12:06:21.556276 7f50937fe700 20 striper   t 0~4194304 bl has 0 off 0
2012-12-11 12:06:21.556277 7f50937fe700 20 striper   t 0~4194304 bl has 0 off 0
2012-12-11 12:06:21.556278 7f50937fe700 20 striper   s at end
2012-12-11 12:06:21.556282 7f50937fe700 20 librbd::AioCompletion:
AioCompletion::complete_request() 0x27b4b10 complete_cb=0x7f50a5b7e4c0
pending 1
2012-12-11 12:06:21.556284 7f50937fe700 20 librbd::AioCompletion:
AioCompletion::finalize() 0x27b4b10 rval 4194304 read_buf 0 read_bl
0x7fff8f12a9b0
2012-12-11 12:06:21.556285 7f50937fe700 10 striper
assemble_result(0x27b4bf8) zero_tail=1
2012-12-11 12:06:21.556290 7f50937fe700 20 striper
assemble_result(0x27b4bf8) 0~4194304 0 bytes
2012-12-11 12:06:21.576042 7f50937fe700 20 librbd::AioCompletion:
AioCompletion::finalize() moving resulting 4194304 bytes to bl
0x7fff8f12a9b0
writing 4194304 bytes at ofs 0

2012/12/8 Dan Mick <dan.mick@inktank.com>:
> I suspect, but have not figured out yet, that this is due to the new
> striping code (even on images that don't have advanced striping enabled).  I
> know we want to look at it further; it might be that this is a regression.
>
>
> On 12/07/2012 07:44 PM, Henry C Chang wrote:
>>
>> Hi,
>>
>> I am testing v0.55. I noticed that the behavior of
>> librbd::Image::read_iterate() changed. With 0.48.2, when hitting the
>> hole, the callback function will be called with the buf set to NULL.
>> However, with v0.55, I got the zero-ed buffer of full length of the
>> object (e.g., 4MB).
>>
>> Is it the expected behavior or a bug?
>>
>> Henry
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
