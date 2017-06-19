From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Caught the first erroneous translated errorcode
Date: Mon, 19 Jun 2017 07:55:34 -0700
Message-ID: <CAJ4mKGaQWJk7dghda6pVOt2g0RfiTh7dw4t8mcqvsRoiR80Rog@mail.gmail.com>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
 <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com>
 <5ca934f2-0f95-bb6c-0fce-267468cb59b4@digiware.nl> <028757af-a82b-d873-648d-294961984bbb@digiware.nl>
 <CA+aFP1BST9e4UV6kyxP=kLN0tN0=1EkV=41cBV2Y5d98hrED7A@mail.gmail.com>
 <95b2bd08-f38b-f5ff-ebfc-523dddb1398b@digiware.nl> <alpine.DEB.2.11.1706191430290.32269@piezo.novalocal>
 <6ec50c30-420b-2039-9af3-184665177149@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35754 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbdFSOzg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jun 2017 10:55:36 -0400
Received: by mail-io0-f174.google.com with SMTP id k93so65974064ioi.2
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 07:55:35 -0700 (PDT)
In-Reply-To: <6ec50c30-420b-2039-9af3-184665177149@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sweil@redhat.com>, Jason Dillaman <dillaman@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 19, 2017 at 7:46 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Op 19-6-2017 om 16:31 schreef Sage Weil:
>>
>> On Mon, 19 Jun 2017, Willem Jan Withagen wrote:
>>>
>>> On 19-6-2017 14:56, Jason Dillaman wrote:
>>>>
>>>> On Sun, Jun 18, 2017 at 1:18 PM, Willem Jan Withagen <wjw@digiware.nl>
>>>> wrote:
>>>>>
>>>>> librbd/io/AioCompletion.cc:199:ssize_t
>>>>> AioCompletion::get_return_value() {
>>>>
>>>>
>>>> librbd just wraps librados, so I would think all the error codes
>>>> should have already been properly translated before it reaches this
>>>> level since otherwise any internal librbd error logging will output
>>>> the incorrect failure reason. I'd suspect most of the client-side
>>>> handling should probably be handled inside osdc/Objecter.h/cc..
>>>
>>> Hi Jason,
>>>
>>> Thanx for the pointer. Changing any of the librbd stuff did indeed not
>>> result in a working rados-stripper.sh
>>>
>>> Objecter.{h,cc} already had the forward error rewrite. I added the
>>> reverse in the original patch. But obviously that is not enough (yet)
>>> So I'll start digging a bit more in the librados files as you suggested.
>>
>> I think the place to do this is in MOSDOpReply.. that alone should be
>> enough to do the translate as the value passes over the wire.
>
>
> Hi Sage,
>
> Tehe interesting part of this is that ALL tests but one actually work. So
> all tests that start
> a cluster thru vstart actually do work. EXCEPT for rados-stiper.sh.
>
> Now this make me question what is different with the stiper code that causes
> an ECANCEL
> to not be translated back ot FreeBSD code.

I'm not sure exactly how it's arranged, but libradosstriper is layered
on top of librados and I don't think anybody's done any of the errno
translation work for other platforms that you got pointed at.
Depending on how it's done that may mean it's missing big chunks --
for instance, if libradosstriper embeds error codes that aren't
touched by librados, it will need to do its own translation.
-Greg
