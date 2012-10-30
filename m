From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH, resend] rbd: simplify rbd_rq_fn()
Date: Tue, 30 Oct 2012 07:01:26 -0500
Message-ID: <508FC196.30702@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1242.1090808@inktank.com> <508EE73E.4090101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53559 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab2J3MB3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 08:01:29 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so208299iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 05:01:28 -0700 (PDT)
In-Reply-To: <508EE73E.4090101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/29/2012 03:29 PM, Josh Durgin wrote:
> This is much easier to read now. It might be useful
> to add messages for the different failure cases in
> bio_chain_clone_range later.

I've added this to my growing list of cleanup tasks.

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

