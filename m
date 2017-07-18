From: Sage Weil <sage@newdream.net>
Subject: Re: Luminous 12.1.1 upgrade mgr woes
Date: Tue, 18 Jul 2017 13:24:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707181323480.27271@piezo.novalocal>
References: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz> <7d69fde3-6a64-578e-85d4-acbf96ea4ab4@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51646 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdGRNYC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 09:24:02 -0400
In-Reply-To: <7d69fde3-6a64-578e-85d4-acbf96ea4ab4@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 18 Jul 2017, Mark Kirkwood wrote:
> On 18/07/17 21:03, Mark Kirkwood wrote:
> 
> > So it all worked ok *except* for the the mgr deploy, this hang at the
> > key/caps modification stage (see attached). 
> 
> Hmm - sorry, managed to leave off the important bit of the log:
> [ceph1][WARNIN] No data was received after 300 seconds, disconnecting...

Opened http://tracker.ceph.com/issues/20666

Thanks!
sage
