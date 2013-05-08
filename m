From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/5] rbd: fix some bugs
Date: Wed, 08 May 2013 16:24:19 -0700
Message-ID: <518ADEA3.2040702@inktank.com>
References: <518ACC55.7090100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:61451 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab3EHXZ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 19:25:27 -0400
Received: by mail-pd0-f174.google.com with SMTP id u10so1584277pdi.33
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 16:25:25 -0700 (PDT)
In-Reply-To: <518ACC55.7090100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/08/2013 03:06 PM, Alex Elder wrote:
> This series is mostly bug fixes of varying degrees of importance.
> The last one is a simple cleanup.  These patches are available in
> the "review/wip-rbd-cleanup-2" branch of the ceph-client git
> git repository.
>
> 					-Alex
>
> [PATCH 1/5] rbd: fix an incorrect assertion condition
> [PATCH 2/5] rbd: support reading parent page data
> [PATCH 3/5] rbd: set mapping read-only flag in rbd_add()
> [PATCH 4/5] rbd: only set up watch for mapped images
> [PATCH 5/5] rbd: kill rbd_img_request_get()

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

