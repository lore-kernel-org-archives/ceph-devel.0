From: Joseph Glanville <joseph.glanville@orionvm.com.au>
Subject: Re: SSD journal suggestion / rsockets
Date: Fri, 9 Nov 2012 09:00:32 +1100
Message-ID: <CAOzFzEgvuRn6RK9QD9UxsX4DWhyRon4wB5Jm1MBbQsppMmSD_g@mail.gmail.com>
References: <509AD42A.9060108@tuxadero.com>
	<CAJH6TXhGU2BdSgHmxm9g=xPxZnOYCN-9t8iPGEQ5TJF372Z0mw@mail.gmail.com>
	<509AE330.7070808@tuxadero.com>
	<CAJH6TXjqMc3mOU7LLPW2oPp+jTC_V_r=JtRU2bGEmtH4vdb3ag@mail.gmail.com>
	<509AEAF4.30309@inktank.com>
	<CAJH6TXgoHTNKhfRTsZ4pSZs4Qk32e-ctr1-6NkBQ=BDiVSBM+g@mail.gmail.com>
	<FB2218CC-8F8F-480A-A5E5-DEF933100612@ornl.gov>
	<509BC407.4030406@inktank.com>
	<FB2859AE-F86A-4C4A-8EF5-5878CD8ABDC7@ornl.gov>
	<CAOzFzEjjmOx2b4L1QhUoeeQOW9o_A6P3OWCFnf3M7GGz7RXUsQ@mail.gmail.com>
	<20121108212130.GA15520@oder.kd-bie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36520 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195Ab2KHWAc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 17:00:32 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so5007145iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 14:00:32 -0800 (PST)
In-Reply-To: <20121108212130.GA15520@oder.kd-bie.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: "Atchley, Scott" <atchleyes@ornl.gov>, Mark Nelson <mark.nelson@inktank.com>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "martin@tuxadero.com" <martin@tuxadero.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>

On 9 November 2012 08:21, Dieter Kasper <d.kasper@kabelmail.de> wrote:
> Joseph,
>
> I've downloaded and read the presentation from 'Sean Hefty / Intel Corporation'
> about rsockets, which sounds very promising to me.
> Can you please teach me how to get access to the rsockets source ?
>
> Thanks,
> -Dieter
>
>

rsockets is distributed as part of librdmacm. You can clone the git
repository here:
git://beany.openfabrics.org/~shefty/librdmacm.git

I recommend using the latest master as it features much better support
for forking.

Joseph.

-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
