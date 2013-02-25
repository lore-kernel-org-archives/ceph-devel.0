From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Four miscellaneous patches
Date: Mon, 25 Feb 2013 11:11:58 -0800
Message-ID: <512BB77E.4030401@inktank.com>
References: <5127A7C1.3070609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:38096 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab3BYTMV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 14:12:21 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so1920882pab.29
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 11:12:20 -0800 (PST)
In-Reply-To: <5127A7C1.3070609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 02/22/2013 09:15 AM, Alex Elder wrote:
> The following patches address some issues that were found while
> investigating a kernel rbd client performance issue this week.
>
> These patches are available in the branch "test/wip-4234,5,7,8"
> in the ceph-client git repository.
>
> 					-Alex
>
> [PATCH] rbd: ignore zero-length requests
> [PATCH] rbd: barriers are hard
> [PATCH] rbd: normalize dout() calls
> [PATCH] libceph: define connection flag helpers

These all look good to me. The dout calls should help
debugging a lot.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

