From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Setting iotune limits on rbd
Date: Tue, 3 Apr 2012 13:43:01 +0400
Message-ID: <CABYiri9fs=r3C3agBtvJeK1Y_43d94aDUKLFbgEeM4VZg7HMhQ@mail.gmail.com>
References: <CABYiri81Jku1F7DjHYT80FPAq_swMfPkYGSnUpEaNsxs0BG6=w@mail.gmail.com>
 <4F7AB2F4.2060905@widodh.nl> <CABYiri_D64hnf1NqEnW93RXWbUj9BQKsMadfQC41Py-a1j0ZwA@mail.gmail.com>
 <4F7AB8AD.30205@widodh.nl> <CABYiri_1z1pALbNTk2ASuf77G9zQT4xAR19PYRa7n8ZWVKrvgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50444 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2DCJnW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Apr 2012 05:43:22 -0400
Received: by wgbdr13 with SMTP id dr13so3554365wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Apr 2012 02:43:21 -0700 (PDT)
In-Reply-To: <CABYiri_1z1pALbNTk2ASuf77G9zQT4xAR19PYRa7n8ZWVKrvgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Suggested hack works, seems that libvirt devs does not remove block
limitation as they count this feature as experimental, or forgot about
it.

On Tue, Apr 3, 2012 at 12:55 PM, Andrey Korolyov <andrey@xdel.ru> wrote=
:
> At least, elements under <iotune> block applies to rbd and you can
> test it by running fio, for example. I have suggested by reading
> libvirt code that blkdeviotune call can be applied to pseudo-devices,
> there are no counterpoints in code that shows different behavior for
> iotune and blkdeviotune calls at all. Seems that libvirt folks did no=
t
> pushed workaround for sheepdog/ceph at all. I`ll try a dirty hack in
> this code snippet (somehow, I overlooked such idea that there is no
> non-block workaround) and report soon.
>
> On Tue, Apr 3, 2012 at 12:45 PM, Wido den Hollander <wido@widodh.nl> =
wrote:
>> Op 3-4-2012 10:28, Andrey Korolyov schreef:
>>
>>> But I am able to set static limits in the config for rbd :) All I w=
ant
>>> is a change on-the-fly.
>>>
>>> It is NOT cgroups mechanism, but completely qemu-driven.
>>
>>
>> Are you sure about that?
>> http://libvirt.org/formatdomain.html#elementsBlockTuning
>>
>> Browsing through the source code I found that this is indeed related=
 to
>> libvirt.
>>
>> In the Qemu driver:
>>
>> =C2=A0 =C2=A0if (disk->type !=3D VIR_DOMAIN_DISK_TYPE_BLOCK &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0disk->type !=3D VIR_DOMAIN_DISK_TYPE_FILE=
)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;
>> ...
>> ...
>> cleanup:
>> =C2=A0 =C2=A0if (!ret) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0qemuReportError(VIR_ERR_INVALID_ARG,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"%s", _("No device found for specified path"));
>> =C2=A0 =C2=A0}
>>
>>
>> RBD devices are however of the type: VIR_DOMAIN_DISK_TYPE_NETWORK
>>
>> That's why you get this error, it's assuming the device you want to =
set the
>> limits on is a block device or a regular file.
>>
>> Wido
>>
>>
>>>
>>> On Tue, Apr 3, 2012 at 12:21 PM, Wido den Hollander<wido@widodh.nl>
>>> =C2=A0wrote:
>>>>
>>>> Hi,
>>>>
>>>> Op 3-4-2012 10:02, Andrey Korolyov schreef:
>>>>
>>>>> Hi,
>>>>>
>>>>> # virsh blkdeviotune Test vdb --write_iops_sec 50 //file block de=
vice
>>>>>
>>>>> # virsh blkdeviotune Test vda --write_iops_sec 50 //rbd block dev=
ice
>>>>> error: Unable to change block I/O throttle
>>>>> error: invalid argument: No device found for specified path
>>>>
>>>>
>>>>
>>>> That is correct. As far as I know iotune uses the underlying cgrou=
ps from
>>>> the OS.
>>>>
>>>> RBD devices (when using Qemu) are not block devices which can be m=
anaged
>>>> by
>>>> cgroups. That's why it's not working and you get the error that th=
e
>>>> device
>>>> can't be found.
>>>>
>>>> There is however somebody working on DiskIoThrottling inside Qemu:
>>>> http://wiki.qemu.org/Features/DiskIOLimits
>>>>
>>>> That would work with RBD (he even names Ceph :) )
>>>>
>>>> Wido
>>>>
>>>>>
>>>>> 2012-04-03 07:38:49.170+0000: 30171: debug :
>>>>> virDomainSetBlockIoTune:18317 : dom=3D0x1114590, (VM: name=3DTest=
,
>>>>> uuid=3D8c27bf32-82dc-315a-d0ba-4653b1b3d595), disk=3Dvda,
>>>>> params=3D0x1114600, nparams=3D1, flags=3D0
>>>>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>>>>> virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D11, f=3D16 e=3D1 =
d=3D0
>>>>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>>>>> virEventPollCalculateTimeout:325 : Calculate expiry of 4 timers
>>>>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>>>>> virEventPollCalculateTimeout:331 : Got a timeout scheduled for
>>>>> 1333438734170
>>>>> 2012-04-03 07:38:49.170+0000: 30171: error : qemuDiskPathToAlias:=
11338
>>>>> : invalid argument: No device found for specified path
>>>>> 2012-04-03 07:38:49.170+0000: 30171: debug : virDomainFree:2313 :
>>>>> dom=3D0x1114590, (VM: name=3DTest,
>>>>> uuid=3D8c27bf32-82dc-315a-d0ba-4653b1b3d595)
>>>>> 2012-04-03 07:38:49.170+0000: 30171: debug : virUnrefDomain:276 :
>>>>> unref domain 0x1114590 Test 1
>>>>> 2012-04-03 07:38:49.170+0000: 30171: debug : virReleaseDomain:238=
 :
>>>>> release domain 0x1114590 Test 8c27bf32-82dc-315a-d0ba-4653b1b3d59=
5
>>>>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>>>>> virEventPollCalculateTimeout:351 : Timeout at 1333438734170 due i=
n
>>>>> 5000 ms
>>>>> 2012-04-03 07:38:49.170+0000: 30169: debug : virEventPollRunOnce:=
619 :
>>>>> EVENT_POLL_RUN: nhandles=3D9 imeout=3D5000
>>>>> 2012-04-03 07:38:49.170+0000: 30171: debug : virReleaseDomain:246=
 :
>>>>> unref connection 0x1177b10 2
>>>>>
>>>>> libvir 0.9.10, json-escape patch applied, but seems that this pro=
blem
>>>>> related to another incorrect path handle.
>>>>>
>>>>> I`m in doubt if it belongs to libvirt ml or here.
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-inf=
o.html
>>>>
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
