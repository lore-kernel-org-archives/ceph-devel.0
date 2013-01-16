From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 0/2] libceph: embed r_trail struct in ceph_osd_request()
Date: Wed, 16 Jan 2013 14:50:02 -0800
Message-ID: <50F72E9A.4080404@inktank.com>
References: <50E61589.6080900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:54822 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757681Ab3APWuG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 17:50:06 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so785629dak.0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 14:50:04 -0800 (PST)
In-Reply-To: <50E61589.6080900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 03:34 PM, Alex Elder wrote:
> This series simplifies some handling of osd client message
> handling by using an initialized ceph_pagelist structure
> to refer to the trail portion of a ceph_osd_request rather
> than using a null pointer to represent "not there".
>
> 					-Alex
>
> [PATCH REPOST 1/2] libceph: always allow trail in osd request
> [PATCH REPOST 2/2] libceph: kill op_needs_trail()

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

