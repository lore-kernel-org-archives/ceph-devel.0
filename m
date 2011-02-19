From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: ceph messenger compile error on old backport (2.6.32)
Date: Sat, 19 Feb 2011 23:47:20 +0800
Message-ID: <AANLkTin8bMZYru0eXLSVcRdaHzJ2Ldikowc1N5Z3F0_y@mail.gmail.com>
References: <loom.20110219T141159-409@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52850 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab1BSPrV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Feb 2011 10:47:21 -0500
Received: by eye27 with SMTP id 27so2305073eye.19
        for <ceph-devel@vger.kernel.org>; Sat, 19 Feb 2011 07:47:20 -0800 (PST)
In-Reply-To: <loom.20110219T141159-409@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GabrieleB <gabriele.bozzi@kaukana.be>
Cc: ceph-devel@vger.kernel.org

2011/2/19 GabrieleB <gabriele.bozzi@kaukana.be>:
> Apologizes if this is not relevant.
>
> I tried to compile Ceph client against a Lucid Ubuntu (Ubuntu 2.6.32-24-server),
> the master backport does not compile complaining for a missing definition of
> WQ_NON_REENTRANT.
> Not an expert of Kernel workqueues but I understand that this mechanism was
> introduced in a post subversion of current Ubuntu stable.
> Am I wrong assuming that the backport should not use Concurrency-managed
> workqueues? Is there a workaround for this?
>

For kernel 2.6.32, the simplest wordaround is to revert the following commits:

c59cb6f net/ceph: make ceph_msgr_wq non-reentrant
6b40e7f ceph: fsc->*_wq's aren't used in memory reclaim path

Cheers,
-- 
Henry Chang
