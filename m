From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] libceph: update rados.h and related code
Date: Sat, 16 Feb 2013 15:54:14 -0800
Message-ID: <51201C26.6010802@inktank.com>
References: <511FBA36.4020407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61950 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab3BPXyR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 18:54:17 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so1107861pbc.31
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 15:54:17 -0800 (PST)
In-Reply-To: <511FBA36.4020407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 02/16/2013 08:56 AM, Alex Elder wrote:
> The ceph kernel and user space code bases have a few header files
> in common, but because they're maintained separately they sometimes
> diverge.
>
> This series updates "include/linux/ceph/rados.h" to nearly match
> its user space counterpart in "src/include/rados.h".
>
> There are still a few things that should be reconciled by updating
> that user space code; that work is covered by:
>      http://tracker.ceph.com/issues/4167
>
> 					-Alex
>
> [PATCH 1/3] libceph: update rados.h
> [PATCH 2/3] libceph: add ceph_osd_state_name()
> [PATCH 3/3] libceph: update ceph_osd_op_name()

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

