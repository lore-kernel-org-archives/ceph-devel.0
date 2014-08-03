From: Samuel Just <sam.just@inktank.com>
Subject: Re: firefly backports
Date: Sun, 3 Aug 2014 13:07:09 -0700
Message-ID: <CA+4uBUb0+vFxFH5tUnUU_urJ==5bs4fPZB-7487SVmtw_-rnRQ@mail.gmail.com>
References: <alpine.DEB.2.00.1408011756300.1270@cobra.newdream.net>
	<CABBk=J-=9R3PUgZX6_5+v90+Rgx1BZih2cu0KrFqnXGJT7kmfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:33226 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbaHCUHK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Aug 2014 16:07:10 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so9796817vcb.30
        for <ceph-devel@vger.kernel.org>; Sun, 03 Aug 2014 13:07:10 -0700 (PDT)
In-Reply-To: <CABBk=J-=9R3PUgZX6_5+v90+Rgx1BZih2cu0KrFqnXGJT7kmfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Added 8701.
-Sam

On Sat, Aug 2, 2014 at 8:44 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> I pushed fixes for the following:
>
>  - 8586
>  - 8702
>  - 8937
>  - 8928
>  - 8442
>  - 8972
>
> There is follow up fix for 8937 that will need to go in, but it'll
> need to make it to master first (there's a pull request).
>
> Yehuda
>
> On Fri, Aug 1, 2014 at 6:00 PM, Sage Weil <sage@inktank.com> wrote:
>> Sam, Yehuda,
>>
>> I backported a ton of pending stuff to firefly-next.  A bunch of it was
>> the cephtool tests and unwinding it from the mds cli changes.  Also did
>> ceph df writeable space (with fix).
>>
>> I didn't do some of the core OSD stuff, though, namely
>>
>>  8438 ec objeccts are not cleaned up
>>  8701 scrub found obsolete rollback object
>>  7999 pgs share info that isn't persisted
>>  8733 crash in ECBackend::handle_sub_read
>>
>> Those are the 'pending backport' bugs at least; I suspect there are other
>> OSD fixes that should be included.
>>
>> I also didn't do any of the rgw patches, or the s3-tests.
>>
>> Can you take a look at some point and put them in firefly-next?  I'd like
>> to get this point going through the firefly suite soon so that it bakes
>> there for as long as possible before the next point release.
>>
>> Thanks!
>> sage
