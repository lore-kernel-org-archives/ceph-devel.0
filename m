From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/5] ceph: cleanup ceph page vector functions
Date: Tue, 19 Feb 2013 11:15:09 -0800
Message-ID: <5123CF3D.2020507@inktank.com>
References: <51152847.2030305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:62004 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933662Ab3BSTPY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 14:15:24 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so3132127dak.0
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 11:15:23 -0800 (PST)
In-Reply-To: <51152847.2030305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/08/2013 08:31 AM, Alex Elder wrote:
> This series does some cleanup related to some functions that
> implement ceph page vectors.  Together, these resolve:
>      http://tracker.ceph.com/issues/4053
>
> 					-Alex
>
> [PATCH 1/5] ceph: remove a few bogus declarations
> [PATCH 2/5] libceph: use void pointers in page vector functions
> [PATCH 3/5] rbd: prevent bytes transferred overflow
> [PATCH 4/5] rbd: ignore result of ceph_copy_from_page_vector()
> [PATCH 5/5] libceph: drop return value from page vector copy

These all seem fine to me.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

