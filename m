From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/2] libceph: define ceph_create_snap_context()
Date: Tue, 30 Apr 2013 16:17:27 -0700
Message-ID: <51805107.6050505@inktank.com>
References: <517FB65D.5040309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42310 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933786Ab3D3XSX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 19:18:23 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx1so606713pab.12
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 16:18:23 -0700 (PDT)
In-Reply-To: <517FB65D.5040309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/30/2013 05:17 AM, Alex Elder wrote:
> While reviewing a recent rbd change Josh suggested that a
> function I created for creating a snapshot context really
> belonged in libceph.  These patches do that.  The first
> defines the function in a new source file, and the second
> puts it to work.
>
> 					-Alex
>
> [PATCH 1/2] libceph: create source file "net/ceph/snapshot.c"
> [PATCH 2/2] ceph: use ceph_create_snap_context()

These look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
