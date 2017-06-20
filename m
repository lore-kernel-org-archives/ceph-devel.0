From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Caught the first erroneous translated errorcode
Date: Tue, 20 Jun 2017 11:27:30 +0200
Message-ID: <99f5f500-796e-d4fc-e373-7c5a3583fc49@digiware.nl>
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
 <14973fcb-3ecf-fe71-17cf-95f916f18512@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:44257 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbdFTJ1d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Jun 2017 05:27:33 -0400
In-Reply-To: <14973fcb-3ecf-fe71-17cf-95f916f18512@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Jason Dillaman <dillaman@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 20-6-2017 10:23, Willem Jan Withagen wrote:
> On 20-6-2017 04:35, Sage Weil wrote:
>> Try changing
>>
>>   int32_t rval;
>>
>> in OSDOp in osd_types.h to errorcode32_t.
> 
> Nice suggestion, and I think it is a correct one.
> But I'm still getting -125 as error code.

I think this is the suspect part?
  for (unsigned i = 0;
       p != out_ops.end() && pb != op->out_bl.end();
       ++i, ++p, ++pb, ++pr, ++ph) {
    ldout(cct, 10) << " op " << i << " rval " << p->rval
                   << " len " << p->outdata.length() << dendl;
    if (*pb)
      **pb = p->outdata;
    // set rval before running handlers so that handlers
    // can change it if e.g. decoding fails
    if (*pr) {
      **pr = ceph_to_hostos_errno(p->rval);
      ldout(cct, 10) << "after  ceph_to_hostos_errno **pr: " << **pr <<
dendl;
    }
    if (*ph) {
      ldout(cct, 10) << " op " << i << " handler " << *ph << dendl;
      (*ph)->complete(ceph_to_hostos_errno(p->rval));
      *ph = NULL;
    }
  }

where it generates:
116: 2017-06-20 11:20:15.365583 80fc18800 10
client.4115.objecter:handle_osd_op_reply(3461) op 0 rval -125 len 0
116: 2017-06-20 11:20:15.365591 80fc18800 10
client.4115.objecter:handle_osd_op_reply(3461) op 1 rval 0 len 0

So neither of the if(*pr) or if(*ph) cases is taken.
And thus the error is not translated.

Note that this part of the code is in the original code before I started
working on this.

--WjW

