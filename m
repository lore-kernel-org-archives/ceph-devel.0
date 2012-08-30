From: hemant surale <hemant.surale@gmail.com>
Subject: Re: Unable to set pg_num property of pool "data"
Date: Thu, 30 Aug 2012 16:32:34 +0530
Message-ID: <CAGfy=6kZSF=4p4v6GJBEwhnUPPzdquZOefudfE1Vf282979Piw@mail.gmail.com>
References: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com>
	<503DE638.9020002@widodh.nl>
	<CAGfy=6m-hhwvG4CabDdUy=04ejkDHrnkPqyUCrOkEzETUEd8Uw@mail.gmail.com>
	<503E1C42.6040408@widodh.nl>
	<CADvuQRF+Q2msar-z1qqn0zj5uPgqJ78SWJQ+eovmXYCcHv+vJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51452 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab2H3LCf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 07:02:35 -0400
Received: by vcbfk26 with SMTP id fk26so1708762vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 04:02:34 -0700 (PDT)
In-Reply-To: <CADvuQRF+Q2msar-z1qqn0zj5uPgqJ78SWJQ+eovmXYCcHv+vJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I was able to increase the PG_num property but only problem is to
reduce it. Anyways thanks for your  valuable reply.


- Hemant Surale.

On Wed, Aug 29, 2012 at 7:13 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Wed, Aug 29, 2012 at 9:42 AM, Wido den Hollander <wido@widodh.nl> wrote:
>> So you are trying to decrease the number of PGs.
>>
>> Now, I'm not sure if that is supported. But why would you want to do this?
>
> Support for pg shrinking will come pretty much exactly at the same
> time as support for pg growing -- soon, but not yet.
