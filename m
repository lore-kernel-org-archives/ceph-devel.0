From: Vladislav Gorbunov <vadikgo@gmail.com>
Subject: Re: Segmentation fault on rbd client ceph version 0.48.2argonaut
Date: Tue, 11 Dec 2012 11:37:47 +1200
Message-ID: <CAD+Ap5YYGvEFhPh=MQD6uVuCOTd+ukc0Z5oq-wmuafvyo45xuw@mail.gmail.com>
References: <CAD+Ap5bAgNczG_JusPYSXJYD9ScjUtxRD6k5xXZuG-2E0dkYcg@mail.gmail.com>
	<50C667A3.4040407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63564 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2LJXht (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 18:37:49 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so2413033lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 15:37:48 -0800 (PST)
In-Reply-To: <50C667A3.4040407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Look like the header object on broken images is empty.

root@bender:~# rados -p iscsi stat seodo1.rbd
iscsi/seodo1.rbd mtime 1354795057, size 0

root@bender:~# rados -p iscsi stat siri.rbd
iscsi/siri.rbd mtime 1355151093, size 0

On accessible image header size not empty:
root@bender:~# rados -p iscsi stat siri1.rbd
iscsi/siri1.rbd mtime 1355174156, size 112

and header can't saved:
root@bender:~# rados -p iscsi get seodo1.rbd seodo1.header
2012-12-11 11:34:06.044164 7fe732f52780  0 wrote 0 byte payload to seodo1.header

Before this header became unreadable new osd server added and cluster
was rebalanced. One of the mon server (mon.0) crushed, and i restart
them.

2012/12/11 Josh Durgin <josh.durgin@inktank.com>:
> On 12/10/2012 01:54 PM, Vladislav Gorbunov wrote:
>>
>> but access to iscsi/seodo1 and iscsi/siri1 fail on every rbd client
>> hosts. Data completely inaccessible.
>>
>> root@bender:~# rbd info iscsi/seodo1
>> *** Caught signal (Segmentation fault) **
>>   in thread 7fb8c93f5780
>>   ceph version 0.48.2argonaut
>> (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
>>   1: rbd() [0x41dfea]
>>   2: (()+0xfcb0) [0x7fb8c796fcb0]
>>   3: (()+0x16244d) [0x7fb8c6ae444d]
>>   4: (librbd::read_header_bl(librados::IoCtx&, std::string const&,
>> ceph::buffer::list&, unsigned long*)+0xf9) [0x7fb8c8fadb99]
>>   5: (librbd::read_header(librados::IoCtx&, std::string const&,
>> rbd_obj_header_ondisk*, unsigned long*)+0x82) [0x7fb8c8fadda2]
>>   6: (librbd::ictx_refresh(librbd::ImageCtx*)+0x90b) [0x7fb8c8fb05eb]
>>   7: (librbd::open_image(librbd::ImageCtx*)+0x1b5) [0x7fb8c8fb1165]
>>   8: (librbd::RBD::open(librados::IoCtx&, librbd::Image&, char const*,
>> char const*)+0x5f) [0x7fb8c8fb16af]
>>   9: (main()+0x73c) [0x41721c]
>>   10: (__libc_start_main()+0xed) [0x7fb8c69a376d]
>>   11: rbd() [0x41a0c9]
>> 2012-12-11 09:33:14.264755 7fb8c93f5780 -1 *** Caught signal
>> (Segmentation fault) **
>>   in thread 7fb8c93f5780
>
>
> It sounds like the header object (which rbd uses to determine the
> prefix for data object names) is corrupted or otherwise inaccessible.
>
> Could you save the header object to a file ('rados -p iscsi get seodo1.rbd')
> and put that file somewhere accessible?
>
> Did anything happen to your cluster before this header became
> unreadable? Any disk problems, or osds crashing?
>
> Josh
