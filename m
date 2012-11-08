From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: clock syncronisation
Date: Thu, 08 Nov 2012 13:20:44 +0100
Message-ID: <509BA39C.2080508@profihost.ag>
References: <509B7595.1010809@profihost.ag> <509B9ED8.6010907@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:33663 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab2KHMUx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 07:20:53 -0500
In-Reply-To: <509B9ED8.6010907@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 08.11.2012 13:00, schrieb Wido den Hollander:
>
>
> On 08-11-12 10:04, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> is there any prefered way to use clock syncronisation?
>>
>> I've tried running openntpd and ntpd on all servers but i'm still
>> getting:
>> 2012-11-08 09:55:38.255928 mon.0 [WRN] message from mon.2 was stamped
>> 0.063136s in the future, clocks not synchronized
>> 2012-11-08 09:55:39.328639 mon.0 [WRN] message from mon.2 was stamped
>> 0.063285s in the future, clocks not synchronized
>> 2012-11-08 09:55:39.328833 mon.0 [WRN] message from mon.2 was stamped
>> 0.063301s in the future, clocks not synchronized
>> 2012-11-08 09:55:40.819975 mon.0 [WRN] message from mon.2 was stamped
>> 0.063360s in the future, clocks not synchronized
>>
>
> What NTP server are you using? Network latency might cause the clocks
> not to be synchronised.

pool.ntp.org

But i've now switched to debian chrony instead of ntp and that seems to 
work fine.

Haven't seen any messages again.

Stefan
