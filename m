From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 08/16] rbd: don't store pool name in struct rbd_dev
Date: Thu, 12 Jul 2012 12:05:11 -0500
Message-ID: <4FFF03C7.1050806@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD875B.3060608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37636 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934096Ab2GLRFO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 13:05:14 -0400
Received: by yenl2 with SMTP id l2so2639200yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 10:05:13 -0700 (PDT)
In-Reply-To: <4FFD875B.3060608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I said I would pull this patch and replace it with two others--one
that just creates an entry in /sys/bus/rbd/devices/<N>/pool_id,
and one that makes the pool name get allocated dynamically.  I'm
about to post those for review.  They fit in about the same place
in the original series but I'm not going to pollute the list by
re-posting everything again.

					-Alex
