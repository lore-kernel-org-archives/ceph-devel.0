From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Recommended number of pools, one Q. ever wanted to ask
Date: Tue, 28 Feb 2012 10:50:56 +0100
Message-ID: <4F4CA380.2010004@filoo.de>
References: <4F4C9FE9.7000808@filoo.de> <4F4CA17F.4070007@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:51721 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab2B1Ju7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 04:50:59 -0500
In-Reply-To: <4F4CA17F.4070007@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Well,

On 02/28/2012 10:42 AM, Wido den Hollander wrote:
> Hi,
>
> On 02/28/2012 10:35 AM, Oliver Francke wrote:
>> Hi *,
>>
>> well, there was once a comment on our layout in means of "too many=20
>> pools".
>> Our setup is to have a pool per customer, to simplify the view on us=
ed
>> storage
>> capacity.
>> So, if we have - in a couple of months, we hope - more then some hun=
dred
>> customers, this setup was not recommended, cause the whole system is=
 not
>> designed for handling that. ( Sage)
>>
>> What does "not recommended" mean? Is it, that per OSD the used memor=
y
>> will be
>> too high?
>
> Yes. Every new pool you create will consume some memory on the OSD. S=
o=20
> if you start creating a lot of pools, you will also start consuming=20
> more and more memory.
>
> I haven't followed this lately, but that is the current information I=
=20
> have.
>
> The number of objects in a pool is also not a problem, you can have=20
> millions without any issues. It's the number of pools which will haun=
t=20
> you later on.

thnx for the quick reply, so if we can imagine, that the number of pool=
=20
per OSD is
the limiting factor, we shall not have more than let's say ~100, means,=
=20
we shall be
safe.

>
> Wido

best regards,

Oliver.

>
>> Is this a general performance issue?
>>
>> Well, if we read "pool", this gave us the basic idea/concept to put =
all
>> per-customers
>> data into it.
>>
>> Please sched some light in 8-)
>>
>> Kind regards,
>>
>> Oliver.
>>
>


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
