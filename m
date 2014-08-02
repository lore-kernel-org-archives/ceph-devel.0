From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: giant and hammer dates
Date: Sat, 2 Aug 2014 04:17:28 -0400
Message-ID: <CAOGLoJNanuAYK=be-p7JdMg4afQXau4gYSND-P58UywJbG8f7g@mail.gmail.com>
References: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net>
	<CAPYLRzgv8m-7LzQBgcGafwOw3SWjn_wVBh7L_+vMnwtRFUYz7g@mail.gmail.com>
	<alpine.DEB.2.00.1407300905400.5022@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:65011 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaHBIR3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Aug 2014 04:17:29 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so7206289pad.9
        for <ceph-devel@vger.kernel.org>; Sat, 02 Aug 2014 01:17:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407300905400.5022@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jul 30, 2014 at 12:15 PM, Sage Weil <sweil@redhat.com> wrote:
> Basically, I think the trade-off is merge pressure vs backporting and
> upgrade testing work...

FWIW, over in Subversion (which is about as paranoid as Ceph regarding
data corruption issues and compatibility), we have a 4-week
"stabilization" period after a release candidate for a "minor" release
(we have never issued a new major API release; so API compatibility is
almost always kept). This stabilization period is when the tree
switches over to enforcing prior review on all merges/backports in our
STATUS file.  This is documented at:

http://subversion.apache.org/docs/community-guide/releasing.html#release-stabilization

One particular point is that we will restart the soak (stabilization
period) if something critical is found.  (Alpha/betas are usually
issued about 2 weeks prior to the first release candidate.)

As a downstream user, I'd advocate the same for Ceph - while it's
great to be on a strict release frequency train, I'd strongly prefer
not to have a rehash of the firefly xfs corruption bug.  I would also
advocate that new features should not be backported to anything but
the most recent "named" release - now that firefly is out, dumpling
only gets critical bug fixes - no new features.

Cheers.  -- justin
