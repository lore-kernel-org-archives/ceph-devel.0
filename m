From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: dependency on parted: just ceph-osd, or more?
Date: Tue, 31 May 2016 14:55:55 -0700
Message-ID: <CAJ4mKGYBY9e-mC5EcgnKUsp3Wno7BpvxkfrzWdWK8LvdpQ-_zA@mail.gmail.com>
References: <CALqRxCwBRjx8OXceg1j+5dCNNDfKdLksJjnuNcmJFD+t6ZEfPQ@mail.gmail.com>
	<574E0581.3030705@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36799 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcEaVz5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 17:55:57 -0400
Received: by mail-vk0-f50.google.com with SMTP id a6so1294979vkg.3
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 14:55:56 -0700 (PDT)
In-Reply-To: <574E0581.3030705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, May 31, 2016 at 2:43 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ken,
>
> On 31/05/2016 23:06, Ken Dreyer wrote:
>> Hi Loic, is there anything in ceph outside of the ceph-osd package
>> that requires parted?
>>
>> I'm wondering if we can move the parted dependency to the ceph-osd
>> sub-package, http://tracker.ceph.com/issues/16095
>>
>> Among other things, this would make Mon and MDS containers lighter.
>
> I'm sure the mon do not need parted. I'd be surprised if mds need it =
but I'm only 99% sure ;-)

I'm pretty sure as well. This is for the local disk shenanigans,
right? MDS definitely doesn't do anything there. :)
-Greg

>
> Cheers
>
>>
>> - Ken
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
