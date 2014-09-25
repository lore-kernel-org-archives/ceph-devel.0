From: John Spray <john.spray@redhat.com>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Thu, 25 Sep 2014 16:27:44 +0100
Message-ID: <CAGd4Wr3DUGJNU7EjsPUKFjeVWB1AyjrFTG=nbC_CxfciPB43cw@mail.gmail.com>
References: <alpine.DEB.2.00.1409250801580.14861@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:58481 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbaIYP1q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 11:27:46 -0400
Received: by mail-la0-f43.google.com with SMTP id gb8so3279131lab.16
        for <ceph-devel@vger.kernel.org>; Thu, 25 Sep 2014 08:27:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409250801580.14861@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Nice to see that coverity and lockdep agree :-)

This should go away with the fix for #9562.

John

On Thu, Sep 25, 2014 at 4:02 PM, Sage Weil <sweil@redhat.com> wrote:
>
>
> ---------- Forwarded message ----------
> From: scan-admin@coverity.com
> To: undisclosed-recipients:;
> Cc:
> Date: Thu, 25 Sep 2014 06:18:46 -0700
> Subject: New Defects reported by Coverity Scan for ceph
>
>
> Hi,
>
>
> Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.
>
> Defect(s) Reported-by: Coverity Scan
> Showing 1 of 1 defect(s)
>
>
> ** CID 1241497:  Thread deadlock  (ORDER_REVERSAL)
>
>
>
> ________________________________________________________________________________________________________
> *** CID 1241497:  Thread deadlock  (ORDER_REVERSAL)
> /osdc/Filer.cc: 314 in Filer::_do_purge_range(PurgeRange *, int)()
> 308         return;
> 309       }
> 310
> 311       int max = 10 - pr->uncommitted;
> 312       while (pr->num > 0 && max > 0) {
> 313         object_t oid = file_object_t(pr->ino, pr->first);
>>>>     CID 1241497:  Thread deadlock  (ORDER_REVERSAL)
>>>>     Calling "get_osdmap_read" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 15 / 30).
> 314         const OSDMap *osdmap = objecter->get_osdmap_read();
> 315         object_locator_t oloc = osdmap->file_to_object_locator(pr->layout);
> 316         objecter->put_osdmap_read();
> 317         objecter->remove(oid, oloc, pr->snapc, pr->mtime, pr->flags,
> 318                          NULL, new C_PurgeRange(this, pr));
> 319         pr->uncommitted++;
>
>
> ________________________________________________________________________________________________________
> To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview
>
> To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py
>
>
>
>
