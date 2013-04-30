From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/2] libceph: define ceph_create_snap_context()
Date: Tue, 30 Apr 2013 07:45:16 -0500
Message-ID: <517FBCDC.9080205@inktank.com>
References: <517FB65D.5040309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:37721 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760220Ab3D3MvV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:51:21 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so506087ieb.25
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:51:20 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id qn10sm22310809igc.6.2013.04.30.05.45.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:45:17 -0700 (PDT)
In-Reply-To: <517FB65D.5040309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 04/30/2013 07:17 AM, Alex Elder wrote:
> While reviewing a recent rbd change Josh suggested that a
> function I created for creating a snapshot context really
> belonged in libceph.  These patches do that.  The first
> defines the function in a new source file, and the second
> puts it to work.

These patches are available in the "review/wip-rbd-cleanup-6"
branch of the ceph-client git repository, which is based on
branch "review/wip-rbd-cleanup-5".

All of the patches that I just posted are available there as
well:
    [PATCH 0/3] rbd: a few small issues
    [PATCH 0/5] rbd: eliminate object version tracking
    [PATCH 0/4] rbd: get rid of the snapshot list

					-Alex
> 					-Alex
> 
> [PATCH 1/2] libceph: create source file "net/ceph/snapshot.c"
> [PATCH 2/2] ceph: use ceph_create_snap_context()
> 

