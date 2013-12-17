From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW CORS fixes for Access-Control-Request-Headers
Date: Tue, 17 Dec 2013 00:17:23 -0800
Message-ID: <CABBk=J_1yAsmHvnPfZSd_dm1wo+QcAv0SBjZcvajPcfzM9fiwA@mail.gmail.com>
References: <robbat2-20131215T205912-773698930Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:60901 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3LQIRY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 03:17:24 -0500
Received: by mail-qa0-f53.google.com with SMTP id j5so2348712qaq.5
        for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 00:17:24 -0800 (PST)
In-Reply-To: <robbat2-20131215T205912-773698930Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Dec 15, 2013 at 1:16 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> Hi,
>
> I was trying to use the RGW CORS support, and found that it flubbed
> handling of the Access-Control-Request-Headers header badly.
>
> It was expecting Access-Control-Allow-Headers in the request where it
> should have taken the Access-Control-Request-Headers, and it was also
> validating the content in a case-sensitive manner, when the CORS
> standard (6.2.6) requires that headers are validated case-insensitive.
>
> I have submitted a pull request with the fixes:
> https://github.com/ceph/ceph/pull/949
>
> I think they should be backported to emperor as well.
>

Overall it looks ok, I still want to run the test suite against it.
Can you open corresponding issues in the ceph tracker?
(tracker.ceph.com).

Thanks,
Yehuda
