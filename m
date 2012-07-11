From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 06/16] rbd: rename rbd_dev->block_name
Date: Wed, 11 Jul 2012 17:13:21 -0500
Message-ID: <4FFDFA81.3040009@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8743.3070704@inktank.com> <4FFDCDD3.7070903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55974 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030324Ab2GKWNX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 18:13:23 -0400
Received: by yenl2 with SMTP id l2so1793140yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 15:13:23 -0700 (PDT)
In-Reply-To: <4FFDCDD3.7070903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 02:02 PM, Josh Durgin wrote:
> Might want to rename block_name in struct rbd_image_header_ondisk too.

I thought about that, but explicitly decided against it.  It's kind
of arbitrary.  In part I didn't want to mess with definitions that
are common to both user space and kernel.  But it also left the
old definition intact, which seemed worthwhile.

					-Alex

