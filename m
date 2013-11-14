From: Gregory Farnum <greg@inktank.com>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Thu, 14 Nov 2013 13:31:36 -0800
Message-ID: <CAPYLRzgYQdmeNBH+OajLRHcRyhzWkr6Wb2Djqv-tb2OF=4YuZA@mail.gmail.com>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
	<CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
	<CABZ+qq=SQman+HPvKany0HigYrtMn766itdU_7ZsYm6SOaQzcQ@mail.gmail.com>
	<CAPYLRzhKNT6Tx9LRV6bfHXpAsG1m3MhWriK-i-T+wSGfBVwh-A@mail.gmail.com>
	<CABZ+qqnfkEOVH2QRM8fu95eGEVBZ8JHX-KLGRAca76AymXothg@mail.gmail.com>
	<CAPYLRzh=DfpVx1Z04+XhbYY9yiyGD9HvG4rRp8=xi9B3SKb50A@mail.gmail.com>
	<92F612DDE3CDEA439793C598481F5702CDE43FD2@CERNXCHG02.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:39907 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757935Ab3KNVbi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Nov 2013 16:31:38 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn6so109020wib.4
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 13:31:37 -0800 (PST)
In-Reply-To: <92F612DDE3CDEA439793C598481F5702CDE43FD2@CERNXCHG02.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Arne Wiebalck <Arne.Wiebalck@cern.ch>
Cc: Dan van der Ster <dan@vanderster.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Andrea Ieri <andrea.ieri@cern.ch>

On Thu, Nov 14, 2013 at 12:30 PM, Arne Wiebalck <Arne.Wiebalck@cern.ch> wrote:
>
> On Nov 14, 2013, at 5:37 PM, Gregory Farnum <greg@inktank.com>
>  wrote:
>
>> On Thu, Nov 14, 2013 at 8:21 AM, Dan van der Ster <dan@vanderster.com> wrote:
>>> On Thu, Nov 14, 2013 at 4:55 PM, Gregory Farnum <greg@inktank.com> wrote:
>>>> Ah, I hadn't gotten that from skimming the blueprint. So this isn't
>>>> just about hooking into Kerberos when we do a mount, you want to
>>>> dynamically retrieve different caps from the monitors as users log on,
>>>> and have that single client choose between them based on who's making
>>>> the request?
>>>
>>> In our proposal the "additional capabilities" (which allow IOs with a
>>> particular file/object) are encrypted and sent by the MDS to the
>>> client who passes it on to the OSD for object IOs.
>>
>> I'm confused; if two different people are using the same client mount,
>> the MDS can't distinguish between them unless the client is
>> cooperating. Isn't that what you were saying it needs to do?
>
> It's the "who passes it on" which created the confusion? This was to say that
> the client kernel module can't decrypt the additional capability (as it does not
> have the corresponding key). That does however not mean that the MDS or
> the CephFS client module can't distinguish between users as all communication
> is done using session keys. That's at least how I understood it :)

Yeah, this sequence is what I'm confused about. As I understand it,
you're going to have an existing client with existing sessions to the
monitor and MDS, and then a user is going to log in and the client is
going to add additional keys to the monitor session, and then switch
back and forth between each user's tickets for different messages to
the MDS? And the MDS will send back "data access" tickets which the
client will further switch between for each OSD op?
-Greg
