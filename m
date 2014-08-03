From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: firefly backports
Date: Sat, 2 Aug 2014 20:44:03 -0700
Message-ID: <CABBk=J-=9R3PUgZX6_5+v90+Rgx1BZih2cu0KrFqnXGJT7kmfA@mail.gmail.com>
References: <alpine.DEB.2.00.1408011756300.1270@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33759 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbaHCDoE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Aug 2014 23:44:04 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so8110917iec.30
        for <ceph-devel@vger.kernel.org>; Sat, 02 Aug 2014 20:44:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408011756300.1270@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

I pushed fixes for the following:

 - 8586
 - 8702
 - 8937
 - 8928
 - 8442
 - 8972

There is follow up fix for 8937 that will need to go in, but it'll
need to make it to master first (there's a pull request).

Yehuda

On Fri, Aug 1, 2014 at 6:00 PM, Sage Weil <sage@inktank.com> wrote:
> Sam, Yehuda,
>
> I backported a ton of pending stuff to firefly-next.  A bunch of it was
> the cephtool tests and unwinding it from the mds cli changes.  Also did
> ceph df writeable space (with fix).
>
> I didn't do some of the core OSD stuff, though, namely
>
>  8438 ec objeccts are not cleaned up
>  8701 scrub found obsolete rollback object
>  7999 pgs share info that isn't persisted
>  8733 crash in ECBackend::handle_sub_read
>
> Those are the 'pending backport' bugs at least; I suspect there are other
> OSD fixes that should be included.
>
> I also didn't do any of the rgw patches, or the s3-tests.
>
> Can you take a look at some point and put them in firefly-next?  I'd like
> to get this point going through the firefly suite soon so that it bakes
> there for as long as possible before the next point release.
>
> Thanks!
> sage
