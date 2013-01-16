From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 0/4] rbd: four minor patches
Date: Tue, 15 Jan 2013 17:29:11 -0800
Message-ID: <50F60267.5040503@inktank.com>
References: <50E5D641.2010405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56131 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013Ab3APBaU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 20:30:20 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so459594pad.11
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 17:30:20 -0800 (PST)
In-Reply-To: <50E5D641.2010405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 11:04 AM, Alex Elder wrote:
> I'm re-posting my patch backlog, in chunks that may or may not
> match how they got posted before.  This series contains some
> pretty fairly straightforward changes.
>
> 					-Alex
>
> [PATCH REPOST 1/4] rbd: document rbd_spec structure
> [PATCH REPOST 2/4] rbd: kill rbd_spec->image_name_len
> [PATCH REPOST 3/4] rbd: kill rbd_spec->image_id_len
> [PATCH REPOST 4/4] rbd: use kmemdup()

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

