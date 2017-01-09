From: Samuel Just <sjust@redhat.com>
Subject: Re: Safe maximum number of RADOS namespaces
Date: Mon, 9 Jan 2017 08:00:06 -0800
Message-ID: <CAN=+7FU7PfEiCRWr_wRJYSk1R=CJvGuUSy2xtvZ=oAXVoUvh9A@mail.gmail.com>
References: <592054113.6138.1483710244101@ox.pcextreme.nl> <CALe9h7dgsbZiwww87DUtDUsy29LHNbwGxxNGygRhsQyz97U6dg@mail.gmail.com>
 <308159841.6179.1483720942271@ox.pcextreme.nl> <CAN=+7FWbLpgDhoxH1QHgPBpMuDAUL2gg3QOhWGAE_9cKt=yBBA@mail.gmail.com>
 <CA+z5DsxYf7DGZTw2QCRMztQ13zFX5NZd3Kj62xFxmwhznosNmg@mail.gmail.com> <1927481418.6225.1483952382193@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36199 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965754AbdAIQAI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 11:00:08 -0500
Received: by mail-qt0-f182.google.com with SMTP id k15so369210574qtg.3
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 08:00:07 -0800 (PST)
In-Reply-To: <1927481418.6225.1483952382193@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Blair Bethwaite <blair.bethwaite@gmail.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

30M namespaces is not a problem since they are pretty much just object
name prefixes.  30M different cephx users probably would be a problem.
-Sam

On Mon, Jan 9, 2017 at 12:59 AM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 7 januari 2017 om 2:03 schreef Blair Bethwaite <blair.bethwaite@gmail.com>:
>>
>>
>> On 7 January 2017 at 04:04, Samuel Just <sjust@redhat.com> wrote:
>> > Namespaces are pretty much just a prefix, nothing tracks them.  Are
>> > you using them simply to avoid name conflicts?
>
> Yes, but also to be able to list objects (I know, slow!) per 'user'.
>
>>
>> I assumed for some sort of data and/or security segregation using
>> cephx? 30M pools is not exactly feasible...
>>
>
> Eventually yes. We have 30M users in this system now and using namespaces seems like a clean way to separate their data inside RADOS.
>
> Might use different cephx users in the future if we want to.
>
> Wido
>
>> --
>> Cheers,
>> ~Blairo
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
