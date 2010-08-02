From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] rbd: use async write for copy and import
Date: Mon, 2 Aug 2010 13:30:32 -0700
Message-ID: <AANLkTi=ZyhJy6fd08VRWfrd-XLUkKiyuGvttBEtdhh0X@mail.gmail.com>
References: <20100802201235.GD4923@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53190 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab0HBUad (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 16:30:33 -0400
Received: by wyb39 with SMTP id 39so3677518wyb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Aug 2010 13:30:32 -0700 (PDT)
In-Reply-To: <20100802201235.GD4923@chb-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 2, 2010 at 1:12 PM, Christian Brunner <chb@muc.de> wrote:
> Hi Yehuda,
>
> copying images whith "rbd cp" can be quite slow. I did the
> following change to speed up copy and import. Please decide
> if you want to include it.

We'd certainly be happy to be able to speed up those operations. There
are some issues with this implementation, mainly not protecting
aiocnt, and using sleep. Also, it looks like it is unbounded, so with
large images you'd easily run out of memory.
It can be altered to be similar to the patch you supplied for
throttling the qemu-rbd messages, using a conditional variable.

Thanks,
Yehuda
