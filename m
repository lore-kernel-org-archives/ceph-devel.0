From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] libceph: use cursor for incoming data
Date: Thu, 14 Mar 2013 12:49:45 -0700
Message-ID: <514229D9.6000102@inktank.com>
References: <513FD092.2030106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:33839 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3CNTua (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 15:50:30 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so2677606pbc.8
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 12:50:29 -0700 (PDT)
In-Reply-To: <513FD092.2030106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/12/2013 06:04 PM, Alex Elder wrote:
> This series changes the incoming data path for the messenger
> to use the new data item cursors.
>
> 					-Alex
>
> [PATCH 1/4] libceph: use cursor for bio reads
> [PATCH 2/4] libceph: kill ceph message bio_iter, bio_seg
> [PATCH 3/4] libceph: use cursor for inbound data pages
> [PATCH 4/4] libceph: get rid of read helpers

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

