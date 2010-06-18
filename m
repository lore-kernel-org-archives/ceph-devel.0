From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] msgr: Fix crash in policy.throttler->get(message_size)
 when message_size == 0
Date: Fri, 18 Jun 2010 09:05:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006180905050.17737@cobra.newdream.net>
References: <4C1B6FB6.6020606@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37329 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab0FRQEb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jun 2010 12:04:31 -0400
In-Reply-To: <4C1B6FB6.6020606@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simone Gotti <simone.gotti@gmail.com>
Cc: ceph-devel@vger.kernel.org

Applied this, thanks!

sage
