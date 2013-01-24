From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: how to protect rbd from multiple simultaneous mapping
Date: Thu, 24 Jan 2013 11:50:53 -0800
Message-ID: <5101909D.70501@inktank.com>
References: <CAE63xUMSqAFGLtm-ObkbYETQtMDdtwLsPAEgMLFtEpM6azfxqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:65514 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab3AXTu7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 14:50:59 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so5728497pad.32
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 11:50:59 -0800 (PST)
In-Reply-To: <CAE63xUMSqAFGLtm-ObkbYETQtMDdtwLsPAEgMLFtEpM6azfxqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 01/24/2013 05:30 AM, Ugis wrote:
> Hi,
>
> I have rbd which contains non-cluster filesystem. If this rbd is
> mapped+mounted on one host, it should not be mapped+mounted on the
> other simultaneously.
> How to protect such rbd from being mapped on the other host?
>
> At ceph level the only option is to use "lock add [image-name]
> [lock-id]" and check for existance of this lock on the other client or
> is it possible to protect rbd in a way that on other clients "rbd map
> " command would just fail with something like Permission denied
> without using arbitrary locks? In other words, can one limit the count
> of clients that may map certain rbd?

This is what the lock commands were added for. The lock add command
will exit non-zero if the image is already locked, so you can run
something like:

     rbd lock add [image-name] [lock-id] && rbd map [image-name]

to avoid mapping an image that's in use elsewhere.

The lock-id is user-defined, so you could (for example) use the
hostname of the machine mapping the image to tell where it's
in use.

Josh
