From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Caught the first erroneous translated errorcode
Date: Tue, 20 Jun 2017 15:55:26 +0200
Message-ID: <b5967546-01d1-e084-3952-08320712a056@digiware.nl>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
 <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com>
 <5ca934f2-0f95-bb6c-0fce-267468cb59b4@digiware.nl>
 <028757af-a82b-d873-648d-294961984bbb@digiware.nl>
 <CA+aFP1BST9e4UV6kyxP=kLN0tN0=1EkV=41cBV2Y5d98hrED7A@mail.gmail.com>
 <95b2bd08-f38b-f5ff-ebfc-523dddb1398b@digiware.nl>
 <alpine.DEB.2.11.1706191430290.32269@piezo.novalocal>
 <6ec50c30-420b-2039-9af3-184665177149@digiware.nl>
 <CAJ4mKGaQWJk7dghda6pVOt2g0RfiTh7dw4t8mcqvsRoiR80Rog@mail.gmail.com>
 <e16d4ec0-7aa1-a793-80dc-4b46a0eb0793@digiware.nl>
 <748ac281-3574-e9dc-e421-b8863d70f34e@digiware.nl>
 <alpine.DEB.2.11.1706200235310.32269@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:57357 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbdFTNz3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Jun 2017 09:55:29 -0400
In-Reply-To: <alpine.DEB.2.11.1706200235310.32269@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Jason Dillaman <dillaman@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 20-6-2017 04:35, Sage Weil wrote:
> Try changing
> 
>   int32_t rval;
> 
> in OSDOp in osd_types.h to errorcode32_t.

That was essentially the correct pointer.
Needed to fix my own code. Wrote that late at night, obviously wasn't
too fresh at that point.
But it seems to work now.

https://github.com/ceph/ceph/pull/15780

Thanx for all the help, and TLC during finding this.

--WjW
