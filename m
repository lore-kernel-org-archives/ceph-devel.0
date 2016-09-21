From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: A design for CephFS forward scrub with multiple MDS
Date: Wed, 21 Sep 2016 09:25:47 -0400
Message-ID: <511F3635-C7D2-4F6B-9B0F-7AD9D9C9F7B2@redhat.com>
References: <45C6F82E-6242-41CE-BBA6-1F5200E0B9BC@redhat.com>
 <CALe9h7cTGVVkkuKxc4CCRFC-xpyiPRfKXFj3i5Kof09Z3yfWhg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36839 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932964AbcIUNZu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 09:25:50 -0400
Received: by mail-io0-f182.google.com with SMTP id m79so52433780ioo.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 06:25:50 -0700 (PDT)
In-Reply-To: <CALe9h7cTGVVkkuKxc4CCRFC-xpyiPRfKXFj3i5Kof09Z3yfWhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>


>> Outbound scrub requests will need to be tracked and restarted in the case of MDS failure.
> 
> One thing we didn't discuss was the backwards case, where I (an MDS)
> am told by another MDS to scrub a subtree, but he fails before I can
> tell him the result of my scrub.  Simplest thing seems to be to abort
> scrubs in this case, and say that (for the moment) a scrub is only
> guaranteed to complete if the MDS where it was initiated stays online?

That makes sense as a first pass. For the future, we could resend the completion to the new subtree root owner after reconnecting and at least update the rstats. The scrub may even complete in that case.