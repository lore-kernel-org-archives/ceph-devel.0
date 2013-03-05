From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] libceph: a few cleanups
Date: Mon, 04 Mar 2013 17:49:17 -0800
Message-ID: <51354F1D.8040205@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E30E.2090400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:55125 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290Ab3CEBtt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 20:49:49 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so3698204pbc.25
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 17:49:48 -0800 (PST)
In-Reply-To: <5134E30E.2090400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/04/2013 10:08 AM, Alex Elder wrote:
> Three small cleanups in the libceph code.	-Alex
>
> [PATCH 1/3] libceph: use (void *) for untyped data in osd ops
> [PATCH 2/3] libceph: kill ceph_msg->pagelist_count
> [PATCH 3/3] libceph: rename ceph_calc_object_layout()

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

