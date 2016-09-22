From: Sage Weil <sage@newdream.net>
Subject: Re: async messenger --debug-ms=1 too verbose?
Date: Thu, 22 Sep 2016 17:39:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609221738400.15794@piezo.us.to>
References: <CALe9h7cUtAL7Rw5r01=d=KXwmG_Fwc-ULjKBuY1NUsHyKSijcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57518 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965265AbcIVRjw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 13:39:52 -0400
In-Reply-To: <CALe9h7cUtAL7Rw5r01=d=KXwmG_Fwc-ULjKBuY1NUsHyKSijcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 22 Sep 2016, John Spray wrote:
> Hi all,
> 
> Minor thing, I'm finding --debug-ms=1 harder to read with my squishy
> mammal brain since we switched to async messenger (comparison here:
> http://pastebin.com/LcG2Z91m).  There is just more noise in the screen
> now and it's harder to read as a list of messages.
> 
> Any thoughts?  Was it kind of accidental or is there a strong need for
> the extra stuff?

Accidental, I think... it's just using the normal debug prefix in all its 
glory.  I agree it's hard to read.  I'll patch it to have something more 
concise for the rx/tx messages...

sage
