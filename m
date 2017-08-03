From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: mgr balancer module
Date: Thu, 3 Aug 2017 13:26:53 +0530
Message-ID: <CAAXqJ+r1CrBk1mHeHXK4_34uqLPtL9D+BBaKT=SU4s584Bk_sA@mail.gmail.com>
References: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal>
 <CAAXqJ+ovmFtC3dNo_5R5x9cj6smFev2Q9wgXVL_4NcHQCnA2tA@mail.gmail.com> <alpine.DEB.2.11.1707301814040.5035@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35681 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdHCH4y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Aug 2017 03:56:54 -0400
Received: by mail-wm0-f47.google.com with SMTP id m85so8141094wma.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Aug 2017 00:56:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707301814040.5035@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sage

I think it would be a good idea to include a command in the balancer
module itself, that would optimize the crushmap using the
python-crush, and set the optimized crushmap.

As far as I believe, uneven distributions can be majorly attributed to
the factors:
* using an unoptimized crushmap
* unevenness that occurs due to the (pseudo) random nature of CRUSH
* objects having different sizes.

If we set an optimized crushmap, at the very initial stages, we have
to move very less data in the due course, in order to maintain a
proper distribution. Hence the necessity of including it in the
balancer module. Please give a look at the PR[1], I sent in this
regard, and let me know if I am moving in the right direction.

[1] : https://github.com/liewegas/ceph/pull/57

-- 
Regards
Spandan Kumar Sahu
