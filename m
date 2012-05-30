From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 09:56:43 -0500
Message-ID: <4FC6352B.8050501@inktank.com>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag>	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>	<4FC5FEC1.90103@profihost.ag>	<4FC60FC8.207@inktank.com>	<4FC61596.3050703@profihost.ag>	<CADdPHGsmr8Ht1pTWH1Oe8=NmAyM81SSdH+c_GV89D8ntfyUmgA@mail.gmail.com>	<4FC61E69.2030408@profihost.ag> <CADdPHGvxCmuViy+0==Vkdz_QjC1K+kD5kD1m7+0tYM2YDTtJbw@mail.gmail.com> <4FC63381.6090300@inktank.com> <4FC63454.3070007@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63782 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab2E3O4s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 10:56:48 -0400
Received: by obbtb18 with SMTP id tb18so8501641obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 07:56:48 -0700 (PDT)
In-Reply-To: <4FC63454.3070007@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Stefan Majer <stefan.majer@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/30/2012 09:53 AM, Stefan Priebe wrote:
> Am 30.05.2012 16:49, schrieb Mark Nelson:
>> On 05/30/2012 08:38 AM, Stefan Majer wrote:
>>> No i dont think so either, this was just a example. Maybe it is totaly
>>> different.
>>
>> You could try setting up a pool with a replication level of 1 and see
>> how that does. It will be faster in any event, but it would be
>> interesting to see how much faster.
> is there an easier way than modifying the crush map?
>
> PS: i also tested noop scheduler - same result.
>
> Stefan

something like:

ceph osd pool create POOL [pg_num [pgp_num]]

then:

ceph osd pool set POOL size VALUE


Mark
