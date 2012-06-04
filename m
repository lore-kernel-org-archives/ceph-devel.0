From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: Infiniband 40GB
Date: Mon, 4 Jun 2012 10:23:37 +0200
Message-ID: <CADdPHGvgE7ai6yjzsKmL9bfqEpyx+qxQaUKoOOYjiT4ZCJ-A0g@mail.gmail.com>
References: <4FCB1C0A.4050504@profihost.ag>
	<4FCB5EED.30909@inktank.com>
	<4FCC5431.6070002@suse.de>
	<4FCC6328.3020606@profihost.ag>
	<4FCC6644.8010106@suse.de>
	<4FCC6963.7090202@profihost.ag>
	<4FCC6B82.9080609@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59391 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab2FDIXi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 04:23:38 -0400
Received: by yhmm54 with SMTP id m54so2688847yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 01:23:37 -0700 (PDT)
In-Reply-To: <4FCC6B82.9080609@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Hannes,

our production environment is running on 10GB infrastructure. We had a
lot of troubles till we got to where we are today.
We use Intel X520 D2 cards on our OSD=B4s and nexus switch
infrastructure. All other cards we where testing failed horrible.

Some of the problems we encountered have been:
- page allocation failures in the ixgbe driver --> fixed in upstream
- problems with jumbo frames, we had to disable tso, gro, lro -- >
this is the most obscure thing
- various tuning via sysctl in the net.tcp and net.ipv4 area --> this
was also the outcome of stefan=B4s benchmarking odysee.

But after all this we a quite happy actully and are only limited by
the speed of the drives (2TB SATA).
The fsync is a fdatasync in fact which is available in newer glibc. If
you dont use btrfs (we use xfs) you need to use a recent glibc with
fdatasync support.

On Mon, Jun 4, 2012 at 10:02 AM, Hannes Reinecke <hare@suse.de> wrote:

hope this helps

Greetings
Stefan

> On 06/04/2012 09:53 AM, Stefan Priebe - Profihost AG wrote:
>> Am 04.06.2012 09:39, schrieb Hannes Reinecke:
>>> On 06/04/2012 09:26 AM, Stefan Priebe - Profihost AG wrote:
>>>> Am 04.06.2012 08:22, schrieb Hannes Reinecke:
>>>>> Hehe.
>>>>> Good luck with that.
>>>>>
>>>>> We've tried on 10GigE with _disastrous_ results.
>>>>> Up to the point where 1GigE was actually _faster_.
>>>>
>>>> So you mean you've tried 10GBE or 10GB ipoib with Infiniband?
>>
>> Could you please answer this question too? Thx.
>>
> This was plain 10GigE, ie TCP/IP. Not infiniband, I'm afraid.
>
> However, given that our problems have not been related to the actual
> transport I'd be very much surprised if they would not occur on
> Infiniband.
>
> And I would _definitely_ like to hear if someone managed to get any
> decent speed (notably write speed) on fast interconnects.
> There's always a chance we've messed things up and were just
> measuring our crap setup ...
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 zSeries & Sto=
rage
> hare@suse.de =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+49 9=
11 74053 688
> SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
> GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Stefan Majer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
