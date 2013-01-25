From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: how to protect rbd from multiple simultaneous mapping
Date: Thu, 24 Jan 2013 17:30:03 -0800
Message-ID: <CA+jddaN6RhfKV20AV-mnGteYKnYPioGHtDkqDRqgJcOizbySuw@mail.gmail.com>
References: <CAE63xUMSqAFGLtm-ObkbYETQtMDdtwLsPAEgMLFtEpM6azfxqA@mail.gmail.com>
	<5101909D.70501@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49919 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab3AYBaF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 20:30:05 -0500
Received: by mail-wi0-f174.google.com with SMTP id hq4so1005196wib.13
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 17:30:03 -0800 (PST)
In-Reply-To: <5101909D.70501@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The advisory locks are nice, but it would be really nice to have the
fencing.  If a node is temporarily off the network and a heartbeat
monitor attempts to bring up a service on a different node, there is
no way to ensure that the first node will not write data to the rbd
after the rbd is mounted on the second node.  It would be nice if, on
seeing that an advisory lock exists, you could tell ceph "Do not
accept data from node X until further notice".

On Thu, Jan 24, 2013 at 11:50 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 01/24/2013 05:30 AM, Ugis wrote:
>>
>> Hi,
>>
>> I have rbd which contains non-cluster filesystem. If this rbd is
>> mapped+mounted on one host, it should not be mapped+mounted on the
>> other simultaneously.
>> How to protect such rbd from being mapped on the other host?
>>
>> At ceph level the only option is to use "lock add [image-name]
>> [lock-id]" and check for existance of this lock on the other client or
>> is it possible to protect rbd in a way that on other clients "rbd map
>> " command would just fail with something like Permission denied
>> without using arbitrary locks? In other words, can one limit the count
>> of clients that may map certain rbd?
>
>
> This is what the lock commands were added for. The lock add command
> will exit non-zero if the image is already locked, so you can run
> something like:
>
>     rbd lock add [image-name] [lock-id] && rbd map [image-name]
>
> to avoid mapping an image that's in use elsewhere.
>
> The lock-id is user-defined, so you could (for example) use the
> hostname of the machine mapping the image to tell where it's
> in use.
>
> Josh
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
