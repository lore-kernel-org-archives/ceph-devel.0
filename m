From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: libvirt: Using rbd_create3 to create format 2 images
Date: Fri, 30 Aug 2013 08:26:00 -0700
Message-ID: <5220B988.9060906@inktank.com>
References: <5220691A.1080604@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35904 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab3H3P0G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Aug 2013 11:26:06 -0400
Received: by mail-oa0-f46.google.com with SMTP id o20so2456237oag.33
        for <ceph-devel@vger.kernel.org>; Fri, 30 Aug 2013 08:26:06 -0700 (PDT)
In-Reply-To: <5220691A.1080604@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/30/2013 02:42 AM, Wido den Hollander wrote:
> Hi,
>
> I created the attached patch to have libvirt create images with format 2
> by default, this would simplify the CloudStack code and could also help
> other projects.
>
> The problem with libvirt is that there is no mechanism to supply
> information like order, features, stripe unit and count to the
> rbd_create3 method, so it's now hardcoded in libvirt.
>
> Any comments on this patch before I fire it of to the libvirt guys?

Seems ok to me. They might want you to detect whether the function is
there and compile without it if librbd doesn't support it (rbd_create3
first appeared in bobtail).

