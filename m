From: Gregory Farnum <greg@gregs42.com>
Subject: Re: ceph tell osd bench
Date: Thu, 23 Apr 2015 11:40:58 -0700
Message-ID: <CAC6JEv8mjDn0+pX6e8+usSYUHkwfF_P0Le=URfE7=nkH4s-vSg@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916642BFFE@SATLEXDAG01.amd.com>
	<CAC6JEv8x-6hVBCiqSDH-oHPeMum3fe7d+V_fb8MoGmLdD4FQ+A@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF916642E209@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37244 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030437AbbDWSk7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Apr 2015 14:40:59 -0400
Received: by igblo3 with SMTP id lo3so30757768igb.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 11:40:59 -0700 (PDT)
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com. [209.85.223.175])
        by mx.google.com with ESMTPSA id hx3sm28246igb.5.2015.04.23.11.40.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2015 11:40:58 -0700 (PDT)
Received: by iedfl3 with SMTP id fl3so76038376ied.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 11:40:58 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF916642E209@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yes.

On Thu, Apr 23, 2015 at 11:35 AM, Deneau, Tom <tom.deneau@amd.com> wrote:
>> -----Original Message-----
>> From: Gregory Farnum [mailto:greg@gregs42.com]
>> Sent: Thursday, April 23, 2015 12:37 PM
>> To: Deneau, Tom
>> Cc: ceph-devel
>> Subject: Re: ceph tell osd bench
>>
>> On Thu, Apr 23, 2015 at 6:58 AM, Deneau, Tom <tom.deneau@amd.com> wrote:
>> > While running ceph tell osd bench and playing around with the total_bytes
>> and block_size parameters,
>> > I have noticed that if the total_bytes written is less than about 0.5G, the
>> bytes/sec is much higher.
>> > Why is that?
>>
>> It's probably only writing the data into the journal at that size. I'm
>> a bit surprised because I thought the osd bench took care to only
>> provide stable numbers, but maybe it's just using well-chosen defaults
>> and at half a gig you're running well below them.
>> -Greg
>
> so is an osd write (as used by tell osd bench) considered complete when
> it is written to the journal?
>
> -- Tom
>
