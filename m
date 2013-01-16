From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 0/5] rbd: drop some unneeded parameters
Date: Tue, 15 Jan 2013 17:46:38 -0800
Message-ID: <50F6067E.2050604@inktank.com>
References: <50E61175.7010103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:54459 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab3APBrs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 20:47:48 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so315496dac.12
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 17:47:47 -0800 (PST)
In-Reply-To: <50E61175.7010103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 03:17 PM, Alex Elder wrote:
> This series cleans up some parameter lists, eliminating parameters
> that don't need to be used.
>
> 					-Alex
>
> [PATCH REPOST 1/5] rbd: drop oid parameters from ceph_osdc_build_request()
> [PATCH REPOST 2/5] rbd: drop snapid parameter from rbd_req_sync_read()
> [PATCH REPOST 3/5] rbd: drop flags parameter from rbd_req_sync_exec()
> [PATCH REPOST 4/5] rbd: kill rbd_req_sync_op() snapc and snapid parameters
> [PATCH REPOST 5/5] rbd: don't bother setting snapid in rbd_do_request()

These look good to me.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

