From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/2] libceph: get rid of unused "one shot" event support
Date: Sat, 16 Feb 2013 15:50:08 -0800
Message-ID: <51201B30.10002@inktank.com>
References: <511FB598.50603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:53539 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab3BPXuM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 18:50:12 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so1922885daj.22
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 15:50:11 -0800 (PST)
In-Reply-To: <511FB598.50603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 02/16/2013 08:36 AM, Alex Elder wrote:
> The osd client supports a "one shot" event, but nobody ever uses
> it.  It probably works right, but it's effectively dead code, so
> just get rid of it.  Get rid of ceph_osd_wait_event() as well,
> because whatever purpose it served was probably related to
> using a one shot event.
>
> 					-Alex
>
> [PATCH 1/2] libceph: kill ceph_osdc_create_event() "one_shot"
> [PATCH 2/2] libceph: kill ceph_osdc_wait_event()

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

