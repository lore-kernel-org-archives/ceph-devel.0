From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/3 v2] rbd: add discard support for rbd
Date: Wed, 12 Mar 2014 23:49:10 -0500
Message-ID: <532138C6.6060406@ieee.org>
References: <1394680896-8554-1-git-send-email-lucienchao@gmail.com> <1394680896-8554-3-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:54657 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaCMEuL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Mar 2014 00:50:11 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so1315030igc.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 21:50:10 -0700 (PDT)
In-Reply-To: <1394680896-8554-3-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org

On 03/12/2014 10:21 PM, Guangliang Zhao wrote:
> This patch add the discard support for rbd driver.
> 
> There are there types operation in the driver:
> 1. The objects would be removed if they completely contained
>    within the discard range.
> 2. The objects would be truncated if they partly contained within
>    the discard range, and align with their boundary.
> 3. Others would be zeroed.
> 
> A discard request from blkdev_issue_discard() is defined which
> REQ_WRITE and REQ_DISCARD both marked and no data, so we must
> check the REQ_DISCARD first when getting the request type.
> 
> This resolve:
> 	http://tracker.ceph.com/issues/190
> 
> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>


