From: Wido den Hollander <wido@42on.com>
Subject: Re: ceph-brag ready
Date: Tue, 04 Mar 2014 12:15:55 +0100
Message-ID: <5315B5EB.80902@42on.com>
References: <78E29451-D203-4B1A-B825-E86894D940FB@enovance.com> <alpine.DEB.2.00.1402150942070.17892@cobra.newdream.net> <6FD0B3B6-DA32-4EBD-A807-2DDA3388E345@enovance.com> <alpine.DEB.2.00.1403031528410.17314@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:37320 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101AbaCDLP7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Mar 2014 06:15:59 -0500
In-Reply-To: <alpine.DEB.2.00.1403031528410.17314@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Sebastien Han <sebastien.han@enovance.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/04/2014 12:35 AM, Sage Weil wrote:
> Hi Sebastien,
>
> Good seeing you last week in Frankfurt!
>
> I meant to follow up earlier (or hack on this a bit myself) but haven=
't
> had time.  After taking a look, my wish list here would be:
>
> - simplify the 'bytes' info to just be bytes.
>
> - maybe prefix these all with 'num_'
>
> - for crush_types, make it a map of type to count, so we can tell how=
 many
> racks/rows/hosts/etc there are.
>
> - i wouldn't include the pool names in the pool metadata; that is pro=
bably
> too sensitive.
>

Ack, just the IDs are fine. Pool names can indeed have to much=20
information in them.

> - but, we can include 'type' (replicated|erasure) and change 'rep_siz=
e' to
> 'size' (which is a more general name)
>

Why not also include the num of PGs per pool? Now we only see the num o=
f=20
PGs in total, but we probably want this to map to the pools as well.

> - for sysinfo, i would remove nw_info entirely?  not sure what this w=
ould
> be for, but generally if there is any identifying info people will no=
t
> want to use this
>
> - for all the other metadata, i wonder if it would be better to break=
 it
> down into a histogram (like the crush types) with a value and count, =
so
> that we just see how many of each version/distro/kernel/os/arch/cpu/e=
tc
> are running.  unless people think it would be useful to see how they
> correlate?
>
> In general, it seems like the more compact the info is, the easier an=
d
> more likely it is for a person to look at it, see it is safe to share=
, and
> then do so.
>

I would also find out if a cluster is running on IPv4 or IPv6. Would be=
=20
interesting to see which it is using.

> Thanks!
> sage
>
>
>
>
> On Sun, 16 Feb 2014, Sebastien Han wrote:
>
>> Sorry for the late response Sage..
>> As discussed on IRC, LGPL is fine.
>>
>> Thanks for taking care of this :)
>>
>> Cheers.
>> =96=96=96=96
>> S=E9bastien Han
>> Cloud Engineer
>>
>> "Always give 100%. Unless you're giving blood.=94
>>
>> Phone: +33 (0)1 49 70 99 72
>> Mail: sebastien.han@enovance.com
>> Address : 10, rue de la Victoire - 75009 Paris
>> Web : www.enovance.com - Twitter : @enovance
>>
>> On 15 Feb 2014, at 18:43, Sage Weil <sage@inktank.com> wrote:
>>
>>> On Wed, 12 Feb 2014, Sebastien Han wrote:
>>>> Hi guys,
>>>>
>>>> First implementation of the ceph-brag is ready.
>>>> We have a public repo available here, so can try it out.
>>>>
>>>> https://github.com/enovance/ceph-brag
>>>>
>>>> However I don=92t have any idea on how to submit this to github.co=
m/ceph.
>>>> Can someone help me on that?
>>>
>>> I'm merging this into ceph.git now (src/brag/{client, server}).  I =
don't
>>> see Signed-off-by lines on the commits, though, or an indication of=
 what
>>> the license is.  Can you confirm whether this should be LGPL or MIT=
 or
>>> whatever?
>>>
>>> Thanks!
>>> sage
>>


--=20
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
