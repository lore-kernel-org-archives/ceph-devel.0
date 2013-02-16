From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] libceph: a few miscellaneous cleanups
Date: Sat, 16 Feb 2013 15:40:04 -0800
Message-ID: <512018D4.5060801@inktank.com>
References: <511FB4D9.7050009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:33364 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab3BPXkI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 18:40:08 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so1925284daj.8
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 15:40:07 -0800 (PST)
In-Reply-To: <511FB4D9.7050009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 02/16/2013 08:33 AM, Alex Elder wrote:
> These changes aren't all that closely related, but they all
> are cleanups in the osd client.
>
> 					-Alex
>
> [PATCH 1/3] libceph: lock outside send_queued()
> [PATCH 2/3] libdeph: don't export ceph_osdc_init() or ceph_osdc_stop()
> [PATCH 3/3] libceph: kill ceph_calc_raw_layout()

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

