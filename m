From: David Zafman <david.zafman@inktank.com>
Subject: Re: [PATCH REPOST 0/4] rbd: four minor patches
Date: Thu, 3 Jan 2013 14:55:01 -0800
Message-ID: <FAF7B66B-0B8C-402D-8F6C-C220AF85D795@inktank.com>
References: <50E5D641.2010405@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f181.google.com ([209.85.160.181]:43352 "EHLO
	mail-gh0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab3ACXBE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:01:04 -0500
Received: by mail-gh0-f181.google.com with SMTP id y8so1891169ghb.40
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:01:03 -0800 (PST)
In-Reply-To: <50E5D641.2010405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


I reviewed these.

Reviewed-by: David Zafman <david.zafman@inktank.com>

David Zafman
Senior Developer
david.zafman@inktank.com



On Jan 3, 2013, at 11:04 AM, Alex Elder <elder@inktank.com> wrote:

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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

