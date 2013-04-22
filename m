From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/2] rbd: void buffer pointer types
Date: Mon, 22 Apr 2013 11:38:25 -0700
Message-ID: <517583A1.3090202@inktank.com>
References: <5174571C.4010203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:53919 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab3DVSjJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 14:39:09 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so3769096pdj.13
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 11:39:08 -0700 (PDT)
In-Reply-To: <5174571C.4010203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/21/2013 02:16 PM, Alex Elder wrote:
> This series just makes the buffer pointer parameters
> for two rbd functions be type (void *) rather than
> (char *).
>
> 					-Alex
>
> [PATCH 1/2] rbd: give rbd_obj_read_sync() buffer void type
> [PATCH 2/2] rbd: void data pointers for rbd_obj_method_sync()

These are fine.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

