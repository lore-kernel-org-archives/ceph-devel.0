From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 08/16] rbd: don't store pool name in struct rbd_dev
Date: Wed, 11 Jul 2012 16:32:59 -0700
Message-ID: <4FFE0D2B.6030400@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD875B.3060608@inktank.com> <4FFDD5B9.9090101@inktank.com> <4FFDFD59.8000105@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44995 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab2GKXdB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 19:33:01 -0400
Received: by yenl2 with SMTP id l2so1846269yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 16:33:01 -0700 (PDT)
In-Reply-To: <4FFDFD59.8000105@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 03:25 PM, Alex Elder wrote:
> On 07/11/2012 02:36 PM, Josh Durgin wrote:
>> On 07/11/2012 07:02 AM, Alex Elder wrote:
>>> An rbd device's pool name is used to specify the pool to use for an
>>> rbd image when it gets mapped (via rbd_add()).  However, only the
>>> pool id can be relied on to be invariant--the name of a pool can
>>> change at any time.
>>>
>>> This means that the name of the pool is potentially stale as soon as
>>> the image is mapped, so it's a bad idea to record this information.
>>> So only store the pool id, not its name, in an rbd_dev.
>>>
>>> Here are a few specific notes about this change:
>>>       - The "pool" name device attribute (/sys/bus/rbd/devices/<N>/pool)
>>>         goes away.  In its place is a "pool_id" attribute that provide
>>>         the numeric pool id for the rbd image.
>>
>> We're using the pool name for udev to provide a predictable device name
>> (/dev/rbd/poolname/imagename[@snapname]), so we probably want to keep
>> the sysfs attribute. I don't think there's a good way for us to detect
>> pool renames right now though, so we should document that the pool
>> name reported does not reflect any potential renames.
>
> OK.  I'll put the "pool" name entry back, but will still include the
> new "pool_id" entry as well.  Do you want me to re-post after that,
> or can I consider this reviewed?

Consider it reviewed. The same goes for the rest of this series,
since it was just minor changes.
