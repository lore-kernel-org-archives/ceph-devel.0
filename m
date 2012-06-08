From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 08 Jun 2012 07:50:36 -0700
Message-ID: <4FD2113C.3070906@inktank.com>
References: <21601270.dfB0BsVfyn@pc10> <4FD10575.7010300@inktank.com> <6535521.l6e0muMKBm@pc10> <4FD1FFD2.6050707@filoo.de> <Pine.LNX.4.64.1206080652031.10292@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37025 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab2FHOuj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 10:50:39 -0400
Received: by gglu4 with SMTP id u4so1307667ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 07:50:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206080652031.10292@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, Guido Winkelmann <guido-ceph@thisisnotatest.de>, ceph-devel@vger.kernel.org

On 06/08/2012 06:55 AM, Sage Weil wrote:
> On Fri, 8 Jun 2012, Oliver Francke wrote:
>> Hi Guido,
>>
>> yeah, there is something weird going on. I just started to establish=
 some
>> test-VM's. Freshly imported from running *.qcow2 images.
>> Kernel panic with INIT, seg-faults and other "funny" stuff.
>>
>> Just added the rbd_cache=3Dtrue in my config, voila. All is
>> fast-n-up-n-running...
>> All my testing was done with cache enabled... Since our errors all c=
ame from
>> rbd_writeback from former ceph-versions...
>
> Are you guys able to reproduce the corruption with 'debug osd =3D 20'=
 and
> 'debug ms =3D 1'?  Ideally we'd like to:
>
>   - reproduce from a fresh vm, with osd logs
>   - identify the bad file
>   - map that file to a block offset (see
>     http://ceph.com/qa/fiemap.[ch], linux_fiemap.h)
>   - use that to identify the badness in the log
>
> I suspect the cache is just masking the problem because it submits fe=
wer
> IOs...

The cache also doesn't do sparse reads. Is it still reproducible with
a fresh vm when you set filestore_fiemap_threshold =3D 0 for the osds,
and run without rbd caching?

Josh

> sage
>
>
>>
>> Josh? Sage? Help?!
>>
>> Oliver.
>>
>> On 06/08/2012 02:55 PM, Guido Winkelmann wrote:
>>> Am Donnerstag, 7. Juni 2012, 12:48:05 schrieben Sie:
>>>> On 06/07/2012 11:04 AM, Guido Winkelmann wrote:
>>>>> Hi,
>>>>>
>>>>> I'm using Ceph with RBD to provide network-transparent disk image=
s for
>>>>> KVM-
>>>>> based virtual servers. The last two days, I've been hunting some =
weird
>>>>> elusive bug where data in the virtual machines would be corrupted=
 in
>>>>> weird ways. It usually manifests in files having some random data=
 -
>>>>> usually zeroes - at the start before the actual contents that sho=
uld be
>>>>> in there start.
>>>> I definitely want to figure out what's going on with this.
>>>> A few questions:
>>>>
>>>> Are you using rbd caching? If so, what settings?
>>>>
>>>> In either case, does the corruption still occur if you
>>>> switch caching on/off? There are different I/O paths here,
>>>> and this might tell us if the problem is on the client side.
>>> Okay, I've tried enabling rbd caching now, and so far, the problem =
appears
>>> to
>>> be gone.
>>>
>>> I am using libvirt for starting and managing the virtual machines, =
and what
>>> I
>>> did was change the<source>   element for the virtual disk from
>>>
>>> <source protocol=3D'rbd' name=3D'rbd/name_of_image'>
>>>
>>> to
>>>
>>> <source protocol=3D'rbd' name=3D'rbd/name_of_image:rbd_cache=3Dtrue=
'>
>>>
>>> and then restart the VM.
>>> (I found that in one of your mails on this list; there does not app=
ear to be
>>> any proper documentation on this...)
>>>
>>> The iotester does not find any corruptions with these settings.
>>>
>>> The VM ist still horribly broken, but that's probably lingering fil=
esystem
>>> damage from yesterday. I'll try with a fresh image next.
>>>
>>> I did not change anything else in the setup. In particular, the OSD=
s still
>>> use
>>> btrfs. One of the OSD has been restarted, though. I will run anothe=
r test
>>> with
>>> a VM without rbd caching, to make sure it wasn't by random chance r=
estarting
>>> that one osd that made the real difference.
>>>
>>> Enabling btrfs did not appear to make any difference wrt performanc=
e, but
>>> that's probably because my tests mostly create sustained sequential=
 IO, for
>>> which caches are generally not very helpful.
>>>
>>> Enabling rbd caching is not a solution I particularly like, for two=
 reasons:
>>>
>>> 1. In my setup, migrating VMs from one host to another is a normal =
part of
>>> operation, and I still don't know ho to prevent data corruption (in=
 the form
>>> of silently lost writes) when combining rbd caching and migration.
>>>
>>> 2. I'm not really looking into speeding up single VM, I'm really mo=
re
>>> interested in just how many VMs I can run before performance starts
>>> degrading
>>> for everyone, and I don't think rbd caching will help with that.
>>>
>>> Regards,
>>> 	Guido
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>>
>> Oliver Francke
>>
>> filoo GmbH
>> Moltkestra=DFe 25a
>> 33330 G=FCtersloh
>> HRB4355 AG G=FCtersloh
>>
>> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
>>
>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
