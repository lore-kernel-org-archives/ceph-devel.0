From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 16:53:08 +0200
Message-ID: <4FC63454.3070007@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag>	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>	<4FC5FEC1.90103@profihost.ag>	<4FC60FC8.207@inktank.com>	<4FC61596.3050703@profihost.ag>	<CADdPHGsmr8Ht1pTWH1Oe8=NmAyM81SSdH+c_GV89D8ntfyUmgA@mail.gmail.com>	<4FC61E69.2030408@profihost.ag> <CADdPHGvxCmuViy+0==Vkdz_QjC1K+kD5kD1m7+0tYM2YDTtJbw@mail.gmail.com> <4FC63381.6090300@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47734 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab2E3OxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 10:53:09 -0400
In-Reply-To: <4FC63381.6090300@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Majer <stefan.majer@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 30.05.2012 16:49, schrieb Mark Nelson:
> On 05/30/2012 08:38 AM, Stefan Majer wrote:
>> No i dont think so either, this was just a example. Maybe it is totaly
>> different.
>
> You could try setting up a pool with a replication level of 1 and see
> how that does. It will be faster in any event, but it would be
> interesting to see how much faster.
is there an easier way than modifying the crush map?

PS: i also tested noop scheduler - same result.

Stefan
