From: Samuel Just <sam.just@inktank.com>
Subject: Re: still recovery issues with cuttlefish
Date: Wed, 21 Aug 2013 11:05:38 -0700
Message-ID: <CA+4uBUabpeZXThuGzD16E+7Q=BnYAZgNLixv6aOKJDiOSdetbQ@mail.gmail.com>
References: <51FA1AC1.8040207@profihost.ag>
	<CA+4uBUZY-_jsnG+wfE4LXL-Dw2CtRkNuANwPMMJ4JyUU=4tdRQ@mail.gmail.com>
	<51FBFE85.5040700@profihost.ag>
	<5203A597.4060701@cloudapt.com>
	<5203DFAE.9070100@profihost.ag>
	<CA+4uBUYgLmP0EMv1+Gzd9ndR42o9ahTL6bnoAAD8QS+Cax7Yzg@mail.gmail.com>
	<52068FB6.1080209@profihost.ag>
	<CA+4uBUY9JiRG28MB_JqXSUe7OaK01uSOTOVCe+baFK2YuNLiaw@mail.gmail.com>
	<673B805F-B036-4066-B8AD-770E6464B64C@profihost.ag>
	<CA+4uBUYBGnCj5Mbj+v8=cFNLYqPrBiR5VqNUJD6m+dXgeHSHzQ@mail.gmail.com>
	<CA+4uBUaM2X4aR1vNqjHTdoBgbU0jRv9aKeZnbAuraWYWcFxEhQ@mail.gmail.com>
	<A2DD558D-3934-4E85-8B03-C8FC1EF9B8B3@profihost.ag>
	<CA+4uBUacvJhS1j_zE7QvidgWCYQcVwLqrz2D=OHdtE-Z05rt4A@mail.gmail.com>
	<520B2BF0.2030208@profihost.ag>
	<5214DCA1.3040003@cloudapt.com>
	<CA+4uBUY+XJzdW6SueB9iPLx4X=WUTgvpgrXM35ODV5cSkamE1Q@mail.gmail.com>
	<367CC0B0FC02EE47BF7482398BD623C55E3C2A21@DB3PRD0311MB416.eurprd03.prod.outlook.com>
	<CA+4uBUaEdV18VR3aT1rkfKp0b9NtDabpNChWO0DCRaDBFhH8Vw@mail.gmail.com>
	<5214FF12.1070903@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:62827 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab3HUSFj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 14:05:39 -0400
Received: by mail-vc0-f177.google.com with SMTP id gf12so480807vcb.8
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 11:05:38 -0700 (PDT)
In-Reply-To: <5214FF12.1070903@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: Yann ROBIN <yann.robin@youscribe.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "josh.durgin@inktank.com" <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If the raring guest was fine, I suspect that the issue is not on the OS=
Ds.
-Sam

On Wed, Aug 21, 2013 at 10:55 AM, Mike Dawson <mike.dawson@cloudapt.com=
> wrote:
> Sam,
>
> Tried it. Injected with 'ceph tell osd.* injectargs --
> --no_osd_recover_clone_overlap', then stopped one OSD for ~1 minute. =
Upon
> restart, all my Windows VMs have issues until HEALTH_OK.
>
> The recovery was taking an abnormally long time, so I reverted away f=
rom
> --no_osd_recover_clone_overlap after about 10mins, to get back to HEA=
LTH_OK.
>
> Interestingly, a Raring guest running a different video surveillance =
package
> proceeded without any issue whatsoever.
>
> Here is an image of the traffic to some of these Windows guests:
>
> http://www.gammacode.com/upload/rbd-hang-with-clone-overlap.jpg
>
> Ceph is outside of HEALTH_OK between ~12:55 and 13:10. Most of these
> instances rebooted due to an app error caused by the i/o hang shortly=
 after
> 13:10.
>
> These Windows instances are booted as COW clones from a Glance image =
using
> Cinder. They also have a second RBD volume for bulk storage. I'm usin=
g qemu
> 1.5.2.
>
> Thanks,
> Mike
>
>
>
> On 8/21/2013 1:12 PM, Samuel Just wrote:
>>
>> Ah, thanks for the correction.
>> -Sam
>>
>> On Wed, Aug 21, 2013 at 9:25 AM, Yann ROBIN <yann.robin@youscribe.co=
m>
>> wrote:
>>>
>>> It's osd recover clone overlap (see http://tracker.ceph.com/issues/=
5401)
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Samuel Just
>>> Sent: mercredi 21 ao=FBt 2013 17:33
>>> To: Mike Dawson
>>> Cc: Stefan Priebe - Profihost AG; josh.durgin@inktank.com;
>>> ceph-devel@vger.kernel.org
>>> Subject: Re: still recovery issues with cuttlefish
>>>
>>> Have you tried setting osd_recovery_clone_overlap to false?  That s=
eemed
>>> to help with Stefan's issue.
>>> -Sam
>>>
>>> On Wed, Aug 21, 2013 at 8:28 AM, Mike Dawson <mike.dawson@cloudapt.=
com>
>>> wrote:
>>>>
>>>> Sam/Josh,
>>>>
>>>> We upgraded from 0.61.7 to 0.67.1 during a maintenance window this
>>>> morning, hoping it would improve this situation, but there was no
>>>> appreciable change.
>>>>
>>>> One node in our cluster fsck'ed after a reboot and got a bit behin=
d.
>>>> Our instances backed by RBD volumes were OK at that point, but onc=
e
>>>> the node booted fully and the OSDs started, all Windows instances =
with
>>>> rbd volumes experienced very choppy performance and were unable to
>>>> ingest video surveillance traffic and commit it to disk. Once the
>>>> cluster got back to HEALTH_OK, they resumed normal operation.
>>>>
>>>> I tried for a time with conservative recovery settings (osd max
>>>> backfills =3D 1, osd recovery op priority =3D 1, and osd recovery =
max
>>>> active =3D 1). No improvement for the guests. So I went to more
>>>> aggressive settings to get things moving faster. That decreased th=
e
>>>> duration of the outage.
>>>>
>>>> During the entire period of recovery/backfill, the network looked
>>>> fine...no where close to saturation. iowait on all drives look fin=
e as
>>>> well.
>>>>
>>>> Any ideas?
>>>>
>>>> Thanks,
>>>> Mike Dawson
>>>>
>>>>
>>>>
>>>> On 8/14/2013 3:04 AM, Stefan Priebe - Profihost AG wrote:
>>>>>
>>>>>
>>>>> the same problem still occours. Will need to check when i've time=
 to
>>>>> gather logs again.
>>>>>
>>>>> Am 14.08.2013 01:11, schrieb Samuel Just:
>>>>>>
>>>>>>
>>>>>> I'm not sure, but your logs did show that you had >16 recovery o=
ps
>>>>>> in flight, so it's worth a try.  If it doesn't help, you should
>>>>>> collect the same set of logs I'll look again.  Also, there are a=
 few
>>>>>> other patches between 61.7 and current cuttlefish which may help=
=2E
>>>>>> -Sam
>>>>>>
>>>>>> On Tue, Aug 13, 2013 at 2:03 PM, Stefan Priebe - Profihost AG
>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Am 13.08.2013 um 22:43 schrieb Samuel Just <sam.just@inktank.co=
m>:
>>>>>>>
>>>>>>>> I just backported a couple of patches from next to fix a bug w=
here
>>>>>>>> we weren't respecting the osd_recovery_max_active config in so=
me
>>>>>>>> cases (1ea6b56170fc9e223e7c30635db02fa2ad8f4b4e).  You can eit=
her
>>>>>>>> try the current cuttlefish branch or wait for a 61.8 release.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks! Are you sure that this is the issue? I don't believe th=
at
>>>>>>> but i'll give it a try. I already tested a branch from sage whe=
re
>>>>>>> he fixed a race regarding max active some weeks ago. So active
>>>>>>> recovering was max 1 but the issue didn't went away.
>>>>>>>
>>>>>>> Stefan
>>>>>>>
>>>>>>>> -Sam
>>>>>>>>
>>>>>>>> On Mon, Aug 12, 2013 at 10:34 PM, Samuel Just
>>>>>>>> <sam.just@inktank.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I got swamped today.  I should be able to look tomorrow.  Sor=
ry!
>>>>>>>>> -Sam
>>>>>>>>>
>>>>>>>>> On Mon, Aug 12, 2013 at 9:39 PM, Stefan Priebe - Profihost AG
>>>>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Did you take a look?
>>>>>>>>>>
>>>>>>>>>> Stefan
>>>>>>>>>>
>>>>>>>>>> Am 11.08.2013 um 05:50 schrieb Samuel Just <sam.just@inktank=
=2Ecom>:
>>>>>>>>>>
>>>>>>>>>>> Great!  I'll take a look on Monday.
>>>>>>>>>>> -Sam
>>>>>>>>>>>
>>>>>>>>>>> On Sat, Aug 10, 2013 at 12:08 PM, Stefan Priebe
>>>>>>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Samual,
>>>>>>>>>>>>
>>>>>>>>>>>> Am 09.08.2013 23:44, schrieb Samuel Just:
>>>>>>>>>>>>
>>>>>>>>>>>>> I think Stefan's problem is probably distinct from Mike's=
=2E
>>>>>>>>>>>>>
>>>>>>>>>>>>> Stefan: Can you reproduce the problem with
>>>>>>>>>>>>>
>>>>>>>>>>>>> debug osd =3D 20
>>>>>>>>>>>>> debug filestore =3D 20
>>>>>>>>>>>>> debug ms =3D 1
>>>>>>>>>>>>> debug optracker =3D 20
>>>>>>>>>>>>>
>>>>>>>>>>>>> on a few osds (including the restarted osd), and upload t=
hose
>>>>>>>>>>>>> osd logs along with the ceph.log from before killing the =
osd
>>>>>>>>>>>>> until after the cluster becomes clean again?
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> done - you'll find the logs at cephdrop folder:
>>>>>>>>>>>> slow_requests_recovering_cuttlefish
>>>>>>>>>>>>
>>>>>>>>>>>> osd.52 was the one recovering
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>
>>>>>>>>>>>> Greets,
>>>>>>>>>>>> Stefan
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>>> ceph-devel" in the body of a message to
>>>>>>>>>>> majordomo@vger.kernel.org More majordomo info at
>>>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> ceph-devel"
>>>>>>>> in
>>>>>>>> the body of a message to majordomo@vger.kernel.org More majord=
omo
>>>>>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.or=
g
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at
>>> http://vger.kernel.org/majordomo-info.html
>>>
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
