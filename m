From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: librbd discard bug problems -> i got it
Date: Mon, 19 Nov 2012 15:33:05 -0800
Message-ID: <50AAC1B1.9070701@inktank.com>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com> <50AABDD1.5050802@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:40305 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab2KSXdn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:33:43 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so959160dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:33:43 -0800 (PST)
In-Reply-To: <50AABDD1.5050802@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/19/2012 03:16 PM, Stefan Priebe wrote:
> mhm qemu rbd block driver. Get's always these errors back. As
> rbd_aio_bh_cb is directly called from librbd the problem must be there.
> Strangely i can't find where rbd_aio_bh_cb get's called with -512.
>
> ANy further ideas?

Two ideas:

1) Is rbd_finish_aiocb getting this same return value?

2) Perhaps it's an issue with the return value wrapping around with
very large discards. Adding some logging of the return values of each
rados operation in AioCompletion::complete_request() might give us a
clue. These large negative return values are suspicious.

> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -512 Error: 0
> rbd_aio_bh_cb got error back. Code: -1006628352 Error: 0
>
> Stefan

