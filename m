From: Gregory Farnum <greg@inktank.com>
Subject: Re: How to increase the number of pgs at pool creation time?
Date: Thu, 23 Aug 2012 17:58:44 -0400
Message-ID: <CAPYLRzj-FftgaMVop-wXrgB9ZzKtZO8hxHQQm6xiv56ZMpqmvQ@mail.gmail.com>
References: <CANLRBoxdu7iPvBU45T5Nk0zDYT1QSX9-oyo4g1nEav-+ybGA4g@mail.gmail.com>
	<50369DDB.8020905@sandia.gov>
	<CANLRBozjtrpsKJ-cE=RxP0ihdkO4cYjV9bx=c+rb+F8HzZ=zmw@mail.gmail.com>
	<5036A527.5020001@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54062 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753164Ab2HWV6q convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Aug 2012 17:58:46 -0400
Received: by lagy9 with SMTP id y9so764793lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Aug 2012 14:58:44 -0700 (PDT)
In-Reply-To: <5036A527.5020001@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Tren Blackburn <tren@eotnetworks.com>, ceph-devel@vger.kernel.org

On Thu, Aug 23, 2012 at 5:48 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 08/23/2012 03:26 PM, Tren Blackburn wrote:
>>
>> On Thu, Aug 23, 2012 at 2:17 PM, Jim Schutt<jaschut@sandia.gov>  wro=
te:
>>>
>>> On 08/23/2012 02:39 PM, Tren Blackburn wrote:
>>>>
>>>>
>>>> 2) Increase the number of pgs via ceph.conf (osd pg bits =3D 7) an=
d
>>>> create the cluster. This does not work either as the cluster comes=
 up
>>>> with 6 pgs bits per osd still.
>>>>       re:http://ceph.com/docs/master/config-cluster/osd-config-ref=
/
>>>
>>>
>>>
>>> I use this regularly.  Do you have that in your global section, i.e=
=2E
>>>
>>> [global]
>>>          osd pg bits =3D 7
>>>          osd pgp bits =3D 7
>>>
>> Hi Jim;
>>
>> Sorry about the direct reply. I have cc'ed the list. To answer your
>> question I put that setting in the [osd] section, not the [global]
>> section. How would a person know these settings go in [global]?
>
>
> I'm sorry to admit I haven't learned how to know this
> either.  I recall trying it in the [osd] section and
> not having it work, and thinking maybe the monitor
> would need to know, and putting it in the [global]
> section would give it access.  It worked, so I moved on.

Generally speaking, the first word in the config option is the section
it belongs in =97 except when it isn't, as with here. You want it in th=
e
global section since both the monitors and several of the config tools
invoked by mkcephfs need to see this value.

>> Also,
>> I could not find documentation about "pgp bits" What is a "placement
>> group p bit"?
>
>
> Again, I'm not sure.  The default config has pg bits and
> pgp bits set to the same value, so I think I assumed it
> would be best to have them the same if I changed pg bits.

Wherever you see a reference to pgp, it stands for PG placement. It
gives us the ability to place x PGs as if they were really only y PGs
(x > y, obviously). For now, these should just always match.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
