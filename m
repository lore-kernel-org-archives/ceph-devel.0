From: Gregory Farnum <greg@inktank.com>
Subject: Re: wip-msgr-delay-queue
Date: Tue, 4 Dec 2012 11:04:43 -0800
Message-ID: <CAPYLRzh6AP-Uw1=1CbJMQPsCrTWZDzcS+VUJ598PNGNitOnJuw@mail.gmail.com>
References: <alpine.DEB.2.00.1212011249450.9862@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51691 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab2LDTEo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 14:04:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6724644ieb.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 11:04:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212011249450.9862@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Dec 1, 2012 at 12:51 PM, Sage Weil <sage@inktank.com> wrote:
> Is ready to merge, after a final look.  There is one additional patch that
> handles the connection fault and reconnect cases that hasn't been reviewed
> yet.  Passed the rados suite, although when we add it to the night suite
> we'll want lower probabilities because most of the runs took hours to
> complete with the artificial delays.

Yep, this all looks good to me. Do we want to merge into next or
master? And the default probabilities are of course still zero, so I'm
not sure which ones you were testing with or want to reduce. :)
-Greg
