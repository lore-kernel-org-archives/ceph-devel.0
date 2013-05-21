From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [ceph-users] mon IO usage
Date: Tue, 21 May 2013 20:51:10 +0200
Message-ID: <CAF6-1L7vURna8K8EGUS=3W=DKpb_5p8gLH1AfH=hvF2MYZAEsA@mail.gmail.com>
References: <CAF6-1L4oWCwNxywALb=cUNP_pbD=ND631MJqvCWyvAfvNdWauQ@mail.gmail.com>
	<519B6F28.9000400@scholarstack.com>
	<519B75B2.4070405@scholarstack.com>
	<CAF6-1L4NHhtaaGGB4vBwWWqEa0pVR4T44-Xx_eTmkUEEXHsfgA@mail.gmail.com>
	<alpine.DEB.2.00.1305210854320.16413@cobra.newdream.net>
	<CAF6-1L4C1QQHZ_5=3OCATFTCD_As63HEjJLcKsGURAV02PFQPQ@mail.gmail.com>
	<alpine.DEB.2.00.1305210909190.16413@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:45906 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab3EUSvM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 14:51:12 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so616600bkc.20
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 11:51:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305210909190.16413@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mike Dawson <mike.dawson@scholarstack.com>, ceph-users@lists.ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> Hmm.  Can you generate a log with 'debug mon = 20', 'debug paxos = 20',
> 'debug ms = 1' for a few minutes over which you see a high data rate and
> send it my way?  It sounds like there is something wrong with the
> stash_full logic.

Mm, actually I may have been fooled by the instrumentation ... it does
30 sec average, so when looking closer I don't have 4 Mo/s constantly,
it's more like 50 Mo every 15/20 sec as a burst.

In anycase, that seems like a lot of data being written.

logs can be downloaded from  http://ge.tt/9MOeKHh/v/0


Cheers,

    Sylvan
