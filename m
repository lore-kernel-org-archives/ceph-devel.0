From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: OSD memory leak when scrubbing [0.56.6]
Date: Tue, 21 May 2013 17:35:42 +0200
Message-ID: <CAF6-1L6E6s_wP6012ifwTRwZA4bp5+OLmYo92Y5QbmS20uxReA@mail.gmail.com>
References: <519B9196.5090402@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:33202 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab3EUPfo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 11:35:44 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji2so498620bkc.38
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 08:35:43 -0700 (PDT)
In-Reply-To: <519B9196.5090402@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> subject seems familiar, version was 0.48.3 in the last mail.
>
> Not anyone else with perhaps large pg's experiencing such behaviour?
>
> Any advice on how to proceed?

I had the same behavior in both argonaut and bobtail, raising sharply
~ 100M or so at each scrub (every 24h).

It's now resolved in cuttlefish AFAICT.

However given the mon leveldb issues I'm having with cuttlefish, I'm
not sure I'd recommend upgrading ...

Cheers,

    Sylvain
