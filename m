From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 5/7] rbd: fixes in rbd_header_from_disk()
Date: Mon, 30 Jul 2012 17:45:28 -0500
Message-ID: <50170E88.4030104@inktank.com>
References: <50119421.1090702@inktank.com> <501195CB.7050902@inktank.com> <5016FB67.8030407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56338 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab2G3Wp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 18:45:29 -0400
Received: by yenl2 with SMTP id l2so5446147yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 15:45:29 -0700 (PDT)
In-Reply-To: <5016FB67.8030407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 04:23 PM, Josh Durgin wrote:
> Why not do this for snap_sizes too?

Because I seemed to have missed that one for some reason.

I'll add it before I commit.  Thanks for catching it.

					-Alex
