From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] libceph: use slab caches in messenger and osd osd
 client
Date: Thu, 02 May 2013 09:35:04 -0700
Message-ID: <518295B8.3070605@inktank.com>
References: <51818B12.4010307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44636 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760624Ab3EBQei (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 12:34:38 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so434129pbc.40
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 09:34:37 -0700 (PDT)
In-Reply-To: <51818B12.4010307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/01/2013 02:37 PM, Alex Elder wrote:
> This series adds slab caches to some frequently-allocated
> data structures in the messenger and the osd client.
>
> 					-Alex
>
> [PATCH 1/3] libceph: allocate ceph messages with a slab allocator
> [PATCH 2/3] libceph: allocate ceph message data with a slab
> [PATCH 3/3] libceph: use slab cache for osd client requests

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

