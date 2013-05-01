From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3/5] rbd: define rbd_dev_unprobe()
Date: Tue, 30 Apr 2013 23:57:23 -0500
Message-ID: <5180A0B3.6030401@inktank.com>
References: <517EB4F0.1070607@inktank.com> <517EB54D.8090807@inktank.com> <51806BB4.2060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:43236 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3EAE50 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 00:57:26 -0400
Received: by mail-ia0-f182.google.com with SMTP id w33so1112609iag.27
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 21:57:25 -0700 (PDT)
In-Reply-To: <51806BB4.2060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/30/2013 08:11 PM, Josh Durgin wrote:
> There are a couple calls that look unnecessary noted below.

You were correct, in the two places that you mentioned,
rbd_parent_remove() should go away.  I'll do that before
I commit.

					-Alex

> Other than that:
> 
> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

