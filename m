From: Greg Farnum <greg@inktank.com>
Subject: Re: Multiple named clusters on same nodes
Date: Tue, 29 May 2012 11:54:48 -0700
Message-ID: <AC2A719493A045CBACD9934439475A2B@inktank.com>
References: <201205231100.28327.a.ott@m-privacy.de>
 <CADvuQRHFR8_6EPy-02Xm9Zx-vUnPg3ngiTEr5hLZkKgaLNA--A@mail.gmail.com>
 <201205240959.46764.a.ott@m-privacy.de>
 <201205241058.02262.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62136 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab2E2Syv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 14:54:51 -0400
Received: by pbbrp8 with SMTP id rp8so6341880pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 11:54:51 -0700 (PDT)
In-Reply-To: <201205241058.02262.a.ott@m-privacy.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

On Thursday, May 24, 2012 at 1:58 AM, Amon Ott wrote:
> On Thursday 24 May 2012 wrote Amon Ott:
> > Attached is a patch based on current git stable that makes mkcephfs work
> > fine for me with --cluster name. ceph-mon uses the wrong mkfs path for "mon
> > data" (default "ceph" instead of supplied cluster name), so I put in a
> > workaround.
> > 
> > Please have a look and consider inclusion as well as fixing mon data path.
> > Thanks.
> 
> 
> 
> And another patch for the init script to handle multiple clusters.

Amon:
Thanks for the patches! Unfortunately nobody who's competent to review these (ie, not me) has time to look into them right now, but they're on the queue when TV or Sage gets some time. :)
-Greg


