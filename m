From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v2] rbd: add ioctl for rbd
Date: Tue, 17 Sep 2013 11:24:37 -0500
Message-ID: <52388245.9040407@linaro.org>
References: <1379401443-13569-1-git-send-email-guangliang@unitedstack.com> <52386A4E.6030805@linaro.org> <52387421.3080906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:36429 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab3IQQYZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Sep 2013 12:24:25 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so4385238vcb.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Sep 2013 09:24:25 -0700 (PDT)
In-Reply-To: <52387421.3080906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Guangliang Zhao <guangliang@unitedstack.com>, ceph-devel@vger.kernel.org, sage@inktank.com, lucienchao@gmail.com

On 09/17/2013 10:24 AM, Josh Durgin wrote:
>>
>> As long as you're testing...
>>
>> It would be good to demonstrate that it's writable after
>> a setrw call (i.e., by actually writing to it).
>>
>> And it would be good to show an attempt to change to
>> read-write a mapped "base" image as well as a mapped
>> snapshot image, both opened (mounted) and not.
> 
> Also a read-only mapped non-snapshot, which will catch
> a bug with this patch:
> 
> rbd_request_fn reads rbd_dev->mapping.read_only when it is first
> called, but once it's in the processing loop it never checks it again.
> This will prevent an initially read-only mapping from ever becoming
> read-write. The request loop needs to check for an updated
> rbd_dev->mapping.read_only value.

You are absolutely right.  The existing code assumes it won't
change, basically.

> This makes me notice another cleanup, though it doesn't affect the
> functionality in this patch:
> 
> The place where the rbd driver calls set_device_ro() should be changed
> as well - it only needs to be done once, when the device is being added,
> not during each open() call.

Yes, probably in rbd_dev_device_setup(), near the set_capacity() call.

Very good finds Josh.

					-Alex
