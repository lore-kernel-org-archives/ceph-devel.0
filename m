From: Mark Nelson <mnelson@redhat.com>
Subject: Re: dependency on parted: just ceph-osd, or more?
Date: Tue, 31 May 2016 17:04:10 -0500
Message-ID: <5bd661c7-9b72-2a6b-44c0-0f90228e3019@redhat.com>
References: <CALqRxCwBRjx8OXceg1j+5dCNNDfKdLksJjnuNcmJFD+t6ZEfPQ@mail.gmail.com>
 <574E0581.3030705@dachary.org>
 <CAJ4mKGYBY9e-mC5EcgnKUsp3Wno7BpvxkfrzWdWK8LvdpQ-_zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbcEaWEQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2016 18:04:16 -0400
In-Reply-To: <CAJ4mKGYBY9e-mC5EcgnKUsp3Wno7BpvxkfrzWdWK8LvdpQ-_zA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Even the OSD doesn't really need parted since it'll happily run on any=20
compliant filesystem.  it's only really ceph-disk itself that needs it=20
to prepare the partition and eventually the filesystem for the OSD.

Mark

On 05/31/2016 04:55 PM, Gregory Farnum wrote:
> On Tue, May 31, 2016 at 2:43 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi Ken,
>>
>> On 31/05/2016 23:06, Ken Dreyer wrote:
>>> Hi Loic, is there anything in ceph outside of the ceph-osd package
>>> that requires parted?
>>>
>>> I'm wondering if we can move the parted dependency to the ceph-osd
>>> sub-package, http://tracker.ceph.com/issues/16095
>>>
>>> Among other things, this would make Mon and MDS containers lighter.
>>
>> I'm sure the mon do not need parted. I'd be surprised if mds need it=
 but I'm only 99% sure ;-)
>
> I'm pretty sure as well. This is for the local disk shenanigans,
> right? MDS definitely doesn't do anything there. :)
> -Greg
>
>>
>> Cheers
>>
>>>
>>> - Ken
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
