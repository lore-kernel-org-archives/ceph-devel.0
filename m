From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] ceph: assign message data fields consistently
Date: Mon, 04 Mar 2013 17:55:25 -0800
Message-ID: <5135508D.4040402@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E46C.9020402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:47480 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721Ab3CEBz5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 20:55:57 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so3719002pbc.37
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 17:55:56 -0800 (PST)
In-Reply-To: <5134E46C.9020402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/04/2013 10:14 AM, Alex Elder wrote:
> Rearrange code so all the fields related to message data get
> assigned the same way throughout the ceph code.
>
> 					-Alex
>
> [PATCH 1/3] ceph: use calc_pages_for() in start_read()
> [PATCH 2/3] ceph: simplify ceph_sync_write() page_align calculation
> [PATCH 3/3] libceph: don't assign page info in ceph_osdc_new_request()

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
