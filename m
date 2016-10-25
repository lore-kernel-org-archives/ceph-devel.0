From: kefu chai <tchaikov@gmail.com>
Subject: Re: jewel 10.2.4 freeze
Date: Tue, 25 Oct 2016 20:40:16 +0800
Message-ID: <CAJE9aOPP=6V6Y1TUERYoCYeNykVns_2+_Dh+Uu-Fw_g_iBT_dw@mail.gmail.com>
References: <580E1C53.6060503@dachary.org> <87funlerf5.fsf@suse.com>
 <CA+aFP1C4DSn+skaQ_UL3KSABdiBZLBZ7SP0y9AE_4ANZ6PQUEQ@mail.gmail.com> <580F35B2.9050609@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33173 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941715AbcJYMkS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2016 08:40:18 -0400
Received: by mail-qt0-f170.google.com with SMTP id s49so139202242qta.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Oct 2016 05:40:17 -0700 (PDT)
In-Reply-To: <580F35B2.9050609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: dillaman@redhat.com, Ceph Development <ceph-devel@vger.kernel.org>

Lo=C3=AFc,

would be ideal if we can have https://github.com/ceph/ceph/pull/11642
also. it's a simple and low-risk one.

On Tue, Oct 25, 2016 at 6:36 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Jason,
>
> Ok, will wait for them to be merged before moving forward.
>
> Cheers
>
> On 25/10/2016 05:27, Jason Dillaman wrote:
>> Nack for RBD pending the following:
>>
>> https://github.com/ceph/ceph/pull/11467
>> https://github.com/ceph/ceph/pull/11634
>>
>> On Mon, Oct 24, 2016 at 10:46 AM, Abhishek L <abhishek@suse.com> wrote:
>>>
>>> Loic Dachary writes:
>>>
>>>> Hi Abhishek,
>>>>
>>>> If we were to freeze jewel 10.2.4 today it would have 115 backports[0]=
. Do you think it we should stop merging new backports and prepare for the =
release ? If so, I'll ask the lead of each component to make sure nothing i=
s missing from their point of view.
>>>
>>> Yes, lets start getting the ack from the leads
>>>>
>>>> You can find the progress of the jewel 10.2.4 release in the ttp://tra=
cker.ceph.com/issues/17487.
>>>>
>>>> Cheers
>>>>
>>>> [0] issues backported and merged in jewel 10.2.4 http://tracker.ceph.c=
om/versions/524
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>>
>>> Best,
>>> Abhishek
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
