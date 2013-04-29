From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] rbd: reorder some setup operations
Date: Mon, 29 Apr 2013 12:41:26 -0700
Message-ID: <517ECCE6.7040101@inktank.com>
References: <517BC525.8090403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:50196 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856Ab3D2TmV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 15:42:21 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so533760pbc.26
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 12:42:20 -0700 (PDT)
In-Reply-To: <517BC525.8090403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/27/2013 05:31 AM, Alex Elder wrote:
> The first patch of this series doesn't really belong,
> but I threw it in anyway.  The other three defer doing
> some initialization of an rbd device until just before
> it gets activated by a call to add_disk().
>
> 					-Alex
>
> [PATCH 1/4] rbd: fix up some sysfs stuff
> [PATCH 2/4] rbd: only set device exists flag when ready
> [PATCH 3/4] rbd: defer setting disk capacity
> [PATCH 4/4] rbd: defer setting the mapping size and features

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

