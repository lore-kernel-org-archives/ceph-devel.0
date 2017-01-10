From: Samuel Just <sjust@redhat.com>
Subject: Re: Safe maximum number of RADOS namespaces
Date: Tue, 10 Jan 2017 07:56:06 -0800
Message-ID: <CAN=+7FU+mWsk5B+Y3KO+G1kF69uks4ktYECLJ-ei+OBO-Rui2g@mail.gmail.com>
References: <592054113.6138.1483710244101@ox.pcextreme.nl> <CALe9h7dgsbZiwww87DUtDUsy29LHNbwGxxNGygRhsQyz97U6dg@mail.gmail.com>
 <308159841.6179.1483720942271@ox.pcextreme.nl> <CAN=+7FWbLpgDhoxH1QHgPBpMuDAUL2gg3QOhWGAE_9cKt=yBBA@mail.gmail.com>
 <CA+z5DsxYf7DGZTw2QCRMztQ13zFX5NZd3Kj62xFxmwhznosNmg@mail.gmail.com>
 <1927481418.6225.1483952382193@ox.pcextreme.nl> <CAN=+7FU7PfEiCRWr_wRJYSk1R=CJvGuUSy2xtvZ=oAXVoUvh9A@mail.gmail.com>
 <CAJ4mKGZDc2=9Jg7EyWhvtnp2uBcmSA7ULx9_tHpc=d0nrLbajg@mail.gmail.com> <1695028895.6375.1484035196479@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33842 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755315AbdAJP4I (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2017 10:56:08 -0500
Received: by mail-qt0-f171.google.com with SMTP id l7so120254322qtd.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2017 07:56:08 -0800 (PST)
In-Reply-To: <1695028895.6375.1484035196479@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Blair Bethwaite <blair.bethwaite@gmail.com>

Notably, listing a namespace is pretty much just listing the entire
pool and filtering out everything not in that namespace.  Similarly,
there is no efficient way to list the set of namespaces with objects
in them.
-Sam

On Mon, Jan 9, 2017 at 11:59 PM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 9 januari 2017 om 23:34 schreef Gregory Farnum <gfarnum@redhat.com>:
>>
>>
>> On Mon, Jan 9, 2017 at 8:00 AM, Samuel Just <sjust@redhat.com> wrote:
>> > 30M namespaces is not a problem since they are pretty much just object
>> > name prefixes.  30M different cephx users probably would be a problem.
>> > -Sam
>>
>> This is sort of the interesting bit of the problem. If you have a
>> limited number of users you want to be able to collectively read 30M
>> namespaces (without wide permissions) then you need to *enumerate*
>> those 30M namespaces within their keyrings, and the OSDAuthCaps
>> structure is unlikely to handle that well (although we don't really
>> know).
>>
>
> Yes, it is. For us it is currently not a problem. We are just going to use the namespaces with a key that has access to all the data in a pool. We might do something in the future with limiting keys to a namespace, but that's not relevant right now for us.
>
> Good point though Greg.
>
> Wido
>
>> Otherwise, you need a different keyring for each namespace, and that
>> has two separate points of contention:
>> 1) If they're all online frequently, that's a whole bunch of
>> independent connections to the OSDs. (I sort of assume this is not
>> likely.)
>> 2) Storing each of those keyrings in the monitor LevelDB instances. I
>> think the only analogue here is the limited throughput of very large
>> RWG bucket indices; I think the situation ought to be quite a bit
>> better for the monitors — but I don't have any real data about it.
>> -Greg
>>
>> >
>> > On Mon, Jan 9, 2017 at 12:59 AM, Wido den Hollander <wido@42on.com> wrote:
>> >>
>> >>> Op 7 januari 2017 om 2:03 schreef Blair Bethwaite <blair.bethwaite@gmail.com>:
>> >>>
>> >>>
>> >>> On 7 January 2017 at 04:04, Samuel Just <sjust@redhat.com> wrote:
>> >>> > Namespaces are pretty much just a prefix, nothing tracks them.  Are
>> >>> > you using them simply to avoid name conflicts?
>> >>
>> >> Yes, but also to be able to list objects (I know, slow!) per 'user'.
>> >>
>> >>>
>> >>> I assumed for some sort of data and/or security segregation using
>> >>> cephx? 30M pools is not exactly feasible...
>> >>>
>> >>
>> >> Eventually yes. We have 30M users in this system now and using namespaces seems like a clean way to separate their data inside RADOS.
>> >>
>> >> Might use different cephx users in the future if we want to.
>> >>
>> >> Wido
>> >>
>> >>> --
>> >>> Cheers,
>> >>> ~Blairo
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>> the body of a message to majordomo@vger.kernel.org
>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
