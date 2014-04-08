From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/3 v3] rbd: add discard support for rbd
Date: Tue, 08 Apr 2014 14:48:51 -0700
Message-ID: <53446EC3.8000509@inktank.com>
References: <1396362136-8722-1-git-send-email-lucienchao@gmail.com> <1396362136-8722-2-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:56849 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbaDHVtA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 17:49:00 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so1553745pdj.34
        for <ceph-devel@vger.kernel.org>; Tue, 08 Apr 2014 14:49:00 -0700 (PDT)
In-Reply-To: <1396362136-8722-2-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org
Cc: elder@ieee.org

On 04/01/2014 07:22 AM, Guangliang Zhao wrote:
> This patch add the discard support for rbd driver.
>
> There are three types operation in the driver:
> 1. The objects would be removed if they completely contained
>     within the discard range.
> 2. The objects would be truncated if they partly contained within
>     the discard range, and align with their boundary.
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
> ---

Thanks for fixing these up! I've added them to the wip-discard branch
in ceph-client.git, which I'll post for review shortly.

Josh

