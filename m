From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph osd create XX
Date: Wed, 12 Dec 2012 23:25:19 +0100
Message-ID: <50C9044F.3000608@profihost.ag>
References: <50C8F7AC.9070600@profihost.ag> <CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com> <50C8F939.6080400@profihost.ag> <CAPYLRzjvZWx4T4T9OHPwaY_4cuOuZW2pgPDpwVR-1Afvi=-LeA@mail.gmail.com> <50C8FA80.7060808@profihost.ag> <CAPYLRzifpCB77z=YjbcxAPJ2TRF-NfH+MzgCbnGhFxrBLLs17Q@mail.gmail.com> <50C8FE97.4020302@profihost.ag> <CAPYLRzhq2DMvRoLPsEG0FJ-AejwQ7KyjhZs8iwZbEtecUpA6Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41978 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab2LLWZU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 17:25:20 -0500
In-Reply-To: <CAPYLRzhq2DMvRoLPsEG0FJ-AejwQ7KyjhZs8iwZbEtecUpA6Ug@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: John Wilkins <john.wilkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

ah OK good to know.

UUIDs are a good decision but right now the journal devices (if you use 
a block device) are still absolute.

[osd.23]
         host = cloud1-ceph2
         public addr = 10.255.0.101
         cluster addr = 10.255.0.101
         osd journal  = /dev/sdd1

Greets,
Stefan

Am 12.12.2012 23:09, schrieb Gregory Farnum:
> On Wed, Dec 12, 2012 at 2:00 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> Hi Greg,
>>
>> thanks for explanation. I'm using current next branch.
>>
>> I'm using:
>> host1:
>> osd 11 .. 14
>> host2:
>> osd 21 .. 24
>> host3:
>> osd 31 .. 34
>> host4:
>> osd 41 .. 44
>> host5:
>> osd 51 .. 54
>>
>> Right now i want to add host6. But i still don't know even with your
>> explanation how to add osd 61-64 to osdmap.
>
> Yeah, it's not going to let you allocate non-sequential IDs at this
> point, sorry. We are slowly divorcing the ID and the name, but it's
> not done yet...
>
