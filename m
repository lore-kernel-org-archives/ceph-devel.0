From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/2] libceph: validate timespec conversions
Date: Mon, 22 Apr 2013 11:25:20 -0500
Message-ID: <51756470.20605@inktank.com>
References: <2011602102.65.1366647123451.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32879 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab3DVQZX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 12:25:23 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so7326697iea.10
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 09:25:22 -0700 (PDT)
In-Reply-To: <2011602102.65.1366647123451.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 04/22/2013 11:12 AM, Matt W. Benjamin wrote:
> I was thinking about the seconds component.

I wondered the same thing.  It will most likely
have to some time in the next 25 years or so.

					-Alex

> ----- "Sage Weil" <sage@inktank.com> wrote:
> 
>> On Mon, 22 Apr 2013, Matt W. Benjamin wrote:
>>>
>>> ----- "Alex Elder" <elder@inktank.com> wrote:
>>>
>>>> A ceph timespec contains 32-bit unsigned values for its seconds
>> and
>>>> nanoseconds components.  For a standard timespec, both fields are
>>>> signed, and the seconds field is almost surely 64 bits.
>>>
>>> Is the Ceph timespec going to change at some point?
>>
>> I don't think so.  32-bits is enough for the billion nanoseconds in a
>>
>> second.  And I'm not sure if the signedness is used/useful... the ceph
>>
>> utime_t code always normalizes the ns result to be in [0, 1 billion).
>>
>> sage
> 
> 

