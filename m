From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] libceph: update ceph_fs.h and related code
Date: Sat, 16 Feb 2013 15:58:14 -0800
Message-ID: <51201D16.4050408@inktank.com>
References: <511FBC54.9060408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:37448 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab3BPX6R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 18:58:17 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so1109804pbc.23
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 15:58:17 -0800 (PST)
In-Reply-To: <511FBC54.9060408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 02/16/2013 09:05 AM, Alex Elder wrote:
> This series updates "include/linux/ceph/ceph_fs.h" to nearly match
> its user space counterpart in "src/include/ceph_fs.h".
>
> There are still a few things that should be reconciled by updating
> that user space code; that work is covered by:
>      http://tracker.ceph.com/issues/4168
>
> 					-Alex
>
> [PATCH 1/2] libceph: update ceph_fs.h
> [PATCH 2/2] libceph: update ceph_mds_state_name() and ceph_mds_op_name()

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

