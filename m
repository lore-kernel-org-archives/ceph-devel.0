From: hemant surale <hemant.surale@gmail.com>
Subject: Re: Unable to set pg_num property of pool "data"
Date: Fri, 31 Aug 2012 12:30:50 +0530
Message-ID: <CAGfy=6kMkE3Qnovpg8QDD8ifuH6cN4238z7SCiRGkT9xj1SpXw@mail.gmail.com>
References: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com>
	<503DE638.9020002@widodh.nl>
	<CAGfy=6m-hhwvG4CabDdUy=04ejkDHrnkPqyUCrOkEzETUEd8Uw@mail.gmail.com>
	<503E1C42.6040408@widodh.nl>
	<CADvuQRF+Q2msar-z1qqn0zj5uPgqJ78SWJQ+eovmXYCcHv+vJw@mail.gmail.com>
	<CAGfy=6kZSF=4p4v6GJBEwhnUPPzdquZOefudfE1Vf282979Piw@mail.gmail.com>
	<CAF6-1L7vz-aaa2ydAXi1bQByP8ckpYNB6r691aUfcKbLnHoMrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55006 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2HaHAv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 03:00:51 -0400
Received: by vbbff1 with SMTP id ff1so2854120vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 00:00:50 -0700 (PDT)
In-Reply-To: <CAF6-1L7vz-aaa2ydAXi1bQByP8ckpYNB6r691aUfcKbLnHoMrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Tommi Virtanen <tv@inktank.com>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanx for your valuable information..


-
Hemant Surale

On Thu, Aug 30, 2012 at 4:37 PM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
>> I was able to increase the PG_num property but only problem is to
>> reduce it. Anyways thanks for your  valuable reply.
>
> AFAIK the old tool allowed you to do that but it didn't really work
> internally if the pool wasn't empty.
> In the new version it has been removed completely because it wasn't
> really working anyway (despite what the command line might lead you to
> believe).
>
> And it will be implemented soon-ish properly.
>
> Cheers,
>
>     Sylvain
