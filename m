From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/7] rbd: drop unused parameters from functions
Date: Thu, 26 Jul 2012 12:35:24 -0700
Message-ID: <50119BFC.6050306@inktank.com>
References: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62779 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab2GZTf0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 15:35:26 -0400
Received: by pbbrp8 with SMTP id rp8so3676924pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 12:35:26 -0700 (PDT)
In-Reply-To: <50119076.1030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 11:46 AM, Alex Elder wrote:
> All the patches in this series just drop unused parameters from
> their functions.
>
> 					-Alex
>
> [PATCH 1/7] rbd: snapc is unused in rbd_req_sync_read()
> [PATCH 2/7] rbd: drop rbd_header_from_disk() gfp_flags parameter
> [PATCH 3/7] rbd: drop rbd_dev parameter in snap functions
> [PATCH 4/7] rbd: drop "object_name" from rbd_req_sync_watch()
> [PATCH 5/7] rbd: drop "object_name" from rbd_req_sync_notify()
> [PATCH 6/7] rbd: drop "object_name" from rbd_req_sync_notify_ack()
> [PATCH 7/7] rbd: drop "object_name" from rbd_req_sync_unwatch()

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
