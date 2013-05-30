From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: ceph gets stopped but never started...
Date: Thu, 30 May 2013 14:57:59 +0200
Message-ID: <CAF6-1L70z8xpZVQtDXJj4h+SY7TxrN2rAz-OAR-BXkJR_4DjxQ@mail.gmail.com>
References: <51A7383D.4060309@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36859 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab3E3M6B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 08:58:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so127037bkb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 05:58:00 -0700 (PDT)
In-Reply-To: <51A7383D.4060309@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi

> since commit 85fb422a084785176af3b694882964841e02195d in cuttle fish
> cherry-picked from 2f193fb931ed09d921e6fa5a985ab87aa4874589 ceph gets
> stopped on debian while upgrading but it never gets started again??
>
> Does this really makes sense?
>
> Should the admin handle the stop / start / restart on upgrade?

Yes, personally I think so.

I mean , I usually restart osd sequentially "by hand" while the
upgrade is usually done cluster wide by some automation but for the
service to stay up, the restart needs to be handled manually.

Cheers,

    Sylvain
