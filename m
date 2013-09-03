From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: libvirt: Using rbd_create3 to create format 2 images
Date: Tue, 03 Sep 2013 11:23:10 -0700
Message-ID: <5226290E.1000303@inktank.com>
References: <5220691A.1080604@42on.com> <5220B988.9060906@inktank.com> <5220E6B6.7030008@42on.com> <5224A784.4030606@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58092 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694Ab3ICSZZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 14:25:25 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so6787259pab.41
        for <ceph-devel@vger.kernel.org>; Tue, 03 Sep 2013 11:25:24 -0700 (PDT)
In-Reply-To: <5224A784.4030606@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/02/2013 07:58 AM, Wido den Hollander wrote:
> On 08/30/2013 08:38 PM, Wido den Hollander wrote:
>> On 08/30/2013 05:26 PM, Josh Durgin wrote:
>>> On 08/30/2013 02:42 AM, Wido den Hollander wrote:
>>>> Hi,
>>>>
>>>> I created the attached patch to have libvirt create images with
>>>> format 2
>>>> by default, this would simplify the CloudStack code and could also help
>>>> other projects.
>>>>
>>>> The problem with libvirt is that there is no mechanism to supply
>>>> information like order, features, stripe unit and count to the
>>>> rbd_create3 method, so it's now hardcoded in libvirt.
>>>>
>>>> Any comments on this patch before I fire it of to the libvirt guys?
>>>
>>> Seems ok to me. They might want you to detect whether the function is
>>> there and compile without it if librbd doesn't support it (rbd_create3
>>> first appeared in bobtail).
>>>
>>
>> Good one. Although I don't think anybody is still running Argonaut I'll
>> do a version check of librbd and switch to rbd_create if needed.
>>
>>
> What do you think of the attached patch Josh?

It be a bit cleaner to make a helper to call the rbd_create() or
rbd_create3() so you only need one check of LIBRBD_VERSION_CODE.

It looks like v0.55 was the first release which contained rbd_create3(),
and the version code for that is 261, so the version code check is off
by one.

Josh
