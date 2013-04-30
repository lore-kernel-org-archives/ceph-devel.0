From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/6] rbd: parent probe cleanup
Date: Tue, 30 Apr 2013 11:45:53 -0700
Message-ID: <51801161.3090004@inktank.com>
References: <517BC608.5030008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60907 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850Ab3D3Sqs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 14:46:48 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so501965pad.25
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 11:46:48 -0700 (PDT)
In-Reply-To: <517BC608.5030008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/27/2013 05:35 AM, Alex Elder wrote:
> This series cleans up some code in the are of probing
> for parent images.
>
> 					-Alex
>
> [PATCH 1/6] rbd: encapsulate probing for parent devices
> [PATCH 2/6] rbd: encapsulate removing parent devices
> [PATCH 3/6] rbd: kill __rbd_remove()
> [PATCH 4/6] rbd: fix rbd_dev_remove_parent()
> [PATCH 5/6] rbd: remove parent devices on probe error
> [PATCH 6/6] rbd: probe for the parent earlier

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

