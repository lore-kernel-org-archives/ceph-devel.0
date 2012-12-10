From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Segmentation fault on rbd client ceph version 0.48.2argonaut
Date: Mon, 10 Dec 2012 14:52:19 -0800
Message-ID: <50C667A3.4040407@inktank.com>
References: <CAD+Ap5bAgNczG_JusPYSXJYD9ScjUtxRD6k5xXZuG-2E0dkYcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34370 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2LJWwj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 17:52:39 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2225903pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 14:52:39 -0800 (PST)
In-Reply-To: <CAD+Ap5bAgNczG_JusPYSXJYD9ScjUtxRD6k5xXZuG-2E0dkYcg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladislav Gorbunov <vadikgo@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/10/2012 01:54 PM, Vladislav Gorbunov wrote:
> but access to iscsi/seodo1 and iscsi/siri1 fail on every rbd client
> hosts. Data completely inaccessible.
>
> root@bender:~# rbd info iscsi/seodo1
> *** Caught signal (Segmentation fault) **
>   in thread 7fb8c93f5780
>   ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
>   1: rbd() [0x41dfea]
>   2: (()+0xfcb0) [0x7fb8c796fcb0]
>   3: (()+0x16244d) [0x7fb8c6ae444d]
>   4: (librbd::read_header_bl(librados::IoCtx&, std::string const&,
> ceph::buffer::list&, unsigned long*)+0xf9) [0x7fb8c8fadb99]
>   5: (librbd::read_header(librados::IoCtx&, std::string const&,
> rbd_obj_header_ondisk*, unsigned long*)+0x82) [0x7fb8c8fadda2]
>   6: (librbd::ictx_refresh(librbd::ImageCtx*)+0x90b) [0x7fb8c8fb05eb]
>   7: (librbd::open_image(librbd::ImageCtx*)+0x1b5) [0x7fb8c8fb1165]
>   8: (librbd::RBD::open(librados::IoCtx&, librbd::Image&, char const*,
> char const*)+0x5f) [0x7fb8c8fb16af]
>   9: (main()+0x73c) [0x41721c]
>   10: (__libc_start_main()+0xed) [0x7fb8c69a376d]
>   11: rbd() [0x41a0c9]
> 2012-12-11 09:33:14.264755 7fb8c93f5780 -1 *** Caught signal
> (Segmentation fault) **
>   in thread 7fb8c93f5780

It sounds like the header object (which rbd uses to determine the
prefix for data object names) is corrupted or otherwise inaccessible.

Could you save the header object to a file ('rados -p iscsi get 
seodo1.rbd') and put that file somewhere accessible?

Did anything happen to your cluster before this header became
unreadable? Any disk problems, or osds crashing?

Josh
