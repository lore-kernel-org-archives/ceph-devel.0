From: Josh Durgin <joshd@hq.newdream.net>
Subject: Re: [PATCH 0/3] rbd: a few small cleanups
Date: Tue, 07 Aug 2012 16:28:20 -0700
Message-ID: <5021A494.3040200@hq.newdream.net>
References: <50200691.3040006@inktank.com>
Reply-To: joshd@hq.newdream.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55447 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807Ab2HGX2W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 19:28:22 -0400
In-Reply-To: <50200691.3040006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/06/2012 11:01 AM, Alex Elder wrote:
> This is a small series of cleanups to rbd code.
>
>      [PATCH 1/3] rbd: make snap_names_len a u64
>      [PATCH 2/3] rbd: ensure invalid pointers are made null
>      [PATCH 3/e] rbd: use sizeof (object) instead of sizeof (type)
>
>                      -Alex

This series looks good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

