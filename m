From: Jeff Layton <jlayton@redhat.com>
Subject: Re: lingering caps outstanding after client shutdown?
Date: Tue, 26 Sep 2017 10:06:53 -0400
Message-ID: <1506434813.3182.27.camel@redhat.com>
References: <1506432289.3182.16.camel@redhat.com>
         <alpine.DEB.2.11.1709261330380.27895@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:54258 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937263AbdIZOG5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Sep 2017 10:06:57 -0400
Received: by mail-qt0-f176.google.com with SMTP id 47so10408529qts.10
        for <ceph-devel@vger.kernel.org>; Tue, 26 Sep 2017 07:06:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709261330380.27895@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "open list:CEPH DISTRIBUTED..." <ceph-devel@vger.kernel.org>

On Tue, 2017-09-26 at 13:31 +0000, Sage Weil wrote:
> On Tue, 26 Sep 2017, Jeff Layton wrote:
> > In order to get the correct semantics for a delegation or oplock,
> we
> > need to be able to break delegations on open.
> 
> Can you explain this part?  How do the delegation/oplock semantics
> relate 
> to open(2)?  I would assume they are related to reads and writes (and
> data 
> consistency).  Unless it's a CIFS thing?


You're correct that we only really need to break delegations on
conflicting access, but there is a problem here:

NFS clients can cache shared/deny mode locks if they hold a delegation.
Once you've granted an open, it's too late to go back and enforce it
once you go to recall the delegation.

Since we don't enforce deny mode locks in cephfs, we could argue that
all of that is the purview of the NFS server and not worry about
it...at least until we toss something like samba into the mix, at which
point things get a bit more complicated...

-- 
Jeff Layton <jlayton@redhat.com>
