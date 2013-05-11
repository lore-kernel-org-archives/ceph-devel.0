From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/5] rbd: prep work for flattening images
Date: Sat, 11 May 2013 14:08:51 -0700
Message-ID: <518EB363.8080303@inktank.com>
References: <518E831E.6000206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:44024 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab3EKVIm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 17:08:42 -0400
Received: by mail-ia0-f182.google.com with SMTP id j5so3816817iaf.41
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 14:08:41 -0700 (PDT)
In-Reply-To: <518E831E.6000206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/11/2013 10:42 AM, Alex Elder wrote:
> This series of patches prepares some parent request
> code to make handling the event of a mapped clone
> image getting flattened easier.
>
> 					-Alex
>
> [PATCH 1/5] rbd: get parent info on refresh
> [PATCH 2/5] rbd: don't release write request until necessary
> [PATCH 3/5] rbd: define rbd_dev_unparent()
> [PATCH 4/5] rbd: define parent image request routines
> [PATCH 5/5] rbd: reference count parent requests

2-5 look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

