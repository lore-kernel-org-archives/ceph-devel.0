From: Vladislav Gorbunov <vadikgo@gmail.com>
Subject: Re: Segmentation fault on rbd client ceph version 0.48.2argonaut
Date: Tue, 11 Dec 2012 21:44:07 +1200
Message-ID: <CAD+Ap5Y1aM6HD8bqBNruoGJ6XqByVwpdDHnRPBjV_uVc9Rjtyw@mail.gmail.com>
References: <CAD+Ap5bAgNczG_JusPYSXJYD9ScjUtxRD6k5xXZuG-2E0dkYcg@mail.gmail.com>
	<50C667A3.4040407@inktank.com>
	<CAD+Ap5YYGvEFhPh=MQD6uVuCOTd+ukc0Z5oq-wmuafvyo45xuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:45547 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab2LKJoJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 04:44:09 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2705862lag.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Dec 2012 01:44:07 -0800 (PST)
In-Reply-To: <CAD+Ap5YYGvEFhPh=MQD6uVuCOTd+ukc0Z5oq-wmuafvyo45xuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I found a hardware error in the osd server the day before:
Dec 10 05:40:20 zstore kernel: EDAC MC1: 1 CE error on
CPU#1Channel#0_DIMM#0 (channel:0 slot:0 page:0x0 offset:0x0 grain:8
syndrome:0x0)

=D0=A1ould it affect the replication process?
2012-12-11 00:15:17.705096 7f22b27f4700  0 log [ERR] : 4.6 osd.0: soid
fe0ab176/seodo1.rbd/head//4 size 0 !=3D known size 112
2012-12-11 00:15:17.705100 7f22b27f4700  0 log [ERR] : 4.6 scrub 0
missing, 1 inconsistent objects
2012-12-11 00:15:17.706169 7f22b27f4700  0 log [ERR] : scrub 4.6
fe0ab176/seodo1.rbd/head//4 on disk size (112) does not match object
info size (0)
2012-12-11 00:15:17.706452 7f22b27f4700  0 log [ERR] : 4.6 scrub 1 erro=
rs
2012-12-11 00:21:58.214974 7f23a5ffb700  0 log [ERR] : 3.5 scrub stat
mismatch, got 21841/21839 objects, 199/199 clones,
90932097984/90932097760 bytes.
2012-12-11 00:21:58.214993 7f23a5ffb700  0 log [ERR] : 3.5 scrub 1 erro=
rs



2012/12/11 Vladislav Gorbunov <vadikgo@gmail.com>:
> Look like the header object on broken images is empty.
>
> root@bender:~# rados -p iscsi stat seodo1.rbd
> iscsi/seodo1.rbd mtime 1354795057, size 0
>
> root@bender:~# rados -p iscsi stat siri.rbd
> iscsi/siri.rbd mtime 1355151093, size 0
>
> On accessible image header size not empty:
> root@bender:~# rados -p iscsi stat siri1.rbd
> iscsi/siri1.rbd mtime 1355174156, size 112
>
> and header can't saved:
> root@bender:~# rados -p iscsi get seodo1.rbd seodo1.header
> 2012-12-11 11:34:06.044164 7fe732f52780  0 wrote 0 byte payload to se=
odo1.header
>
> Before this header became unreadable new osd server added and cluster
> was rebalanced. One of the mon server (mon.0) crushed, and i restart
> them.
>
> 2012/12/11 Josh Durgin <josh.durgin@inktank.com>:
>> On 12/10/2012 01:54 PM, Vladislav Gorbunov wrote:
>>>
>>> but access to iscsi/seodo1 and iscsi/siri1 fail on every rbd client
>>> hosts. Data completely inaccessible.
>>>
>>> root@bender:~# rbd info iscsi/seodo1
>>> *** Caught signal (Segmentation fault) **
>>>   in thread 7fb8c93f5780
>>>   ceph version 0.48.2argonaut
>>> (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
>>>   1: rbd() [0x41dfea]
>>>   2: (()+0xfcb0) [0x7fb8c796fcb0]
>>>   3: (()+0x16244d) [0x7fb8c6ae444d]
>>>   4: (librbd::read_header_bl(librados::IoCtx&, std::string const&,
>>> ceph::buffer::list&, unsigned long*)+0xf9) [0x7fb8c8fadb99]
>>>   5: (librbd::read_header(librados::IoCtx&, std::string const&,
>>> rbd_obj_header_ondisk*, unsigned long*)+0x82) [0x7fb8c8fadda2]
>>>   6: (librbd::ictx_refresh(librbd::ImageCtx*)+0x90b) [0x7fb8c8fb05e=
b]
>>>   7: (librbd::open_image(librbd::ImageCtx*)+0x1b5) [0x7fb8c8fb1165]
>>>   8: (librbd::RBD::open(librados::IoCtx&, librbd::Image&, char cons=
t*,
>>> char const*)+0x5f) [0x7fb8c8fb16af]
>>>   9: (main()+0x73c) [0x41721c]
>>>   10: (__libc_start_main()+0xed) [0x7fb8c69a376d]
>>>   11: rbd() [0x41a0c9]
>>> 2012-12-11 09:33:14.264755 7fb8c93f5780 -1 *** Caught signal
>>> (Segmentation fault) **
>>>   in thread 7fb8c93f5780
>>
>>
>> It sounds like the header object (which rbd uses to determine the
>> prefix for data object names) is corrupted or otherwise inaccessible=
=2E
>>
>> Could you save the header object to a file ('rados -p iscsi get seod=
o1.rbd')
>> and put that file somewhere accessible?
>>
>> Did anything happen to your cluster before this header became
>> unreadable? Any disk problems, or osds crashing?
>>
>> Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
