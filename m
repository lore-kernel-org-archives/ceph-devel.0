From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH v2] rbd: add ioctl for rbd
Date: Tue, 17 Sep 2013 09:35:13 -0700
Message-ID: <523884C1.2000601@inktank.com>
References: <1379401443-13569-1-git-send-email-guangliang@unitedstack.com> <52386A4E.6030805@linaro.org> <52387421.3080906@inktank.com> <52387F38.8020506@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:36319 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3IQQfE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Sep 2013 12:35:04 -0400
Received: by mail-yh0-f44.google.com with SMTP id f64so2818213yha.31
        for <ceph-devel@vger.kernel.org>; Tue, 17 Sep 2013 09:35:03 -0700 (PDT)
In-Reply-To: <52387F38.8020506@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <alex.elder@linaro.org>
Cc: Guangliang Zhao <guangliang@unitedstack.com>, ceph-devel@vger.kernel.org, sage@inktank.com, lucienchao@gmail.com

On 09/17/2013 09:11 AM, Alex Elder wrote:
> On 09/17/2013 10:24 AM, Josh Durgin wrote:
>> block/ioctl.c will already call set_device_ro() for us after this
>> driver-specific handling completes successfully, so we don't need to
>> call it here. Also, it appears the block layer has a bug in that
>> it does the check for CAP_SYS_ADMIN *after* calling the driver-specific
>> code for BLKROSET. So the driver-specific part could succeed, but the
>> generic code could fail due to this later check without the driver
>> knowing, possibly leaving the driver inconsistent with the block layer.
>
> I wonder if that's intentional, but I doubt it.  It predates
> the original Linux-2.6.12-rc2 git commit.
>
> But I agree with you, I think it's a bug.  Do you plan to submit
> a patch upstream to propose a fix?

Sure, I'll submit a patch for it.
