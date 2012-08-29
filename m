From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Unable to set pg_num property of pool "data"
Date: Wed, 29 Aug 2012 09:43:57 -0400
Message-ID: <CADvuQRF+Q2msar-z1qqn0zj5uPgqJ78SWJQ+eovmXYCcHv+vJw@mail.gmail.com>
References: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com>
 <503DE638.9020002@widodh.nl> <CAGfy=6m-hhwvG4CabDdUy=04ejkDHrnkPqyUCrOkEzETUEd8Uw@mail.gmail.com>
 <503E1C42.6040408@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39679 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab2H2NoS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 09:44:18 -0400
Received: by vbbff1 with SMTP id ff1so586924vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 06:44:17 -0700 (PDT)
In-Reply-To: <503E1C42.6040408@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: hemant surale <hemant.surale@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 29, 2012 at 9:42 AM, Wido den Hollander <wido@widodh.nl> wrote:
> So you are trying to decrease the number of PGs.
>
> Now, I'm not sure if that is supported. But why would you want to do this?

Support for pg shrinking will come pretty much exactly at the same
time as support for pg growing -- soon, but not yet.
