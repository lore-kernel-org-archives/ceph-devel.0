From: Sage Weil <sweil@redhat.com>
Subject: Re: Crashes with new encoding
Date: Thu, 20 Oct 2016 13:58:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610201354550.28765@piezo.us.to>
References: <CALe9h7frgSiSV0YkaP4h0nK0Z2p7R_QXe=xwf9ujvCg01ZusxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753428AbcJTN6c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Oct 2016 09:58:32 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E46F3BEAD
        for <ceph-devel@vger.kernel.org>; Thu, 20 Oct 2016 13:58:31 +0000 (UTC)
In-Reply-To: <CALe9h7frgSiSV0YkaP4h0nK0Z2p7R_QXe=xwf9ujvCg01ZusxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 20 Oct 2016, John Spray wrote:
> Latest master has the MDS crashing on startup:
> http://tracker.ceph.com/issues/17636
> https://github.com/ceph/ceph/pull/11577
> 
> My patch is kind of dumb, clearly the intent of the original code is
> to avoid any constructor overhead and it would be nice to do so, but
> the original code seems to make the assumption that no encode/decode
> implementations deferences the object they're passed.
> 
> Good motivation to go and immediately familiarise myself with the new
> code this morning though :-)

Hmm, what compiler version are you using?  The intent of the code is 
two-fold: avoid the ctor, as you mention, but also trigger a SEGV if the 
implementation of bound_encode for any traits::bounded type actually 
makes use of the (bogus) reference we're passing in.

Which type(s) did it fail on?  My guess is that it is either a malformed 
bound_encode (taking a value instead of a reference) or the implementation 
is broken (value-dependent).

Or, we are unlucky enough that the compiler is both turning const foo& 
into a pass-by-value and not optimizing it away when the implementation 
doesn't make use of it.  :/  Hopefully not!

sage

