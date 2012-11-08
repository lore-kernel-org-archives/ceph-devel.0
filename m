From: Wido den Hollander <wido@widodh.nl>
Subject: Re: clock syncronisation
Date: Thu, 08 Nov 2012 13:00:24 +0100
Message-ID: <509B9ED8.6010907@widodh.nl>
References: <509B7595.1010809@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:48503 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2KHMA1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 07:00:27 -0500
In-Reply-To: <509B7595.1010809@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 08-11-12 10:04, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> is there any prefered way to use clock syncronisation?
>
> I've tried running openntpd and ntpd on all servers but i'm still getting:
> 2012-11-08 09:55:38.255928 mon.0 [WRN] message from mon.2 was stamped
> 0.063136s in the future, clocks not synchronized
> 2012-11-08 09:55:39.328639 mon.0 [WRN] message from mon.2 was stamped
> 0.063285s in the future, clocks not synchronized
> 2012-11-08 09:55:39.328833 mon.0 [WRN] message from mon.2 was stamped
> 0.063301s in the future, clocks not synchronized
> 2012-11-08 09:55:40.819975 mon.0 [WRN] message from mon.2 was stamped
> 0.063360s in the future, clocks not synchronized
>

What NTP server are you using? Network latency might cause the clocks 
not to be synchronised.

Wido

> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
