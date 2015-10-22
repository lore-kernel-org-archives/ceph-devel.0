From: Samuel Just <sjust@redhat.com>
Subject: Re: Ceph erasure coding
Date: Thu, 22 Oct 2015 09:59:26 -0700
Message-ID: <CAN=+7FVkFO0exjnJqC_329mvv8iGw1swPNHFg1kh77RZzYLwKw@mail.gmail.com>
References: <CA+nGFBodcEq0vOvuFP1Od0zVCyk_9PufsRSYBJYi1W4p_vh+7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33624 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbbJVQ70 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 12:59:26 -0400
Received: by igbkq10 with SMTP id kq10so18196290igb.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 09:59:26 -0700 (PDT)
In-Reply-To: <CA+nGFBodcEq0vOvuFP1Od0zVCyk_9PufsRSYBJYi1W4p_vh+7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kjetil Babington <babingto@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Not on purpose... out of curiosity, why do you want to do that?
-Sam

On Thu, Oct 22, 2015 at 9:44 AM, Kjetil Babington <babingto@gmail.com> wrote:
> Hi,
>
> I have a question about the capabilities of the erasure coding API in
> Ceph. Let's say that I have 10 data disks and 4 parity disks, is it
> possible to create an erasure coding plugin which creates 20 data
> chunks and 8 parity chunks, and then places two chunks on each osd?
>
> Or said maybe a bit simpler is it possible for two or more chunks from
> the same encode operation to be placed on the same osd?
>
> - Kjetil Babington
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
