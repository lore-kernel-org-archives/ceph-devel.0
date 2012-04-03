From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Setting iotune limits on rbd
Date: Tue, 3 Apr 2012 12:28:14 +0400
Message-ID: <CABYiri_D64hnf1NqEnW93RXWbUj9BQKsMadfQC41Py-a1j0ZwA@mail.gmail.com>
References: <CABYiri81Jku1F7DjHYT80FPAq_swMfPkYGSnUpEaNsxs0BG6=w@mail.gmail.com>
 <4F7AB2F4.2060905@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55658 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab2DCI2m convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Apr 2012 04:28:42 -0400
Received: by wibhj6 with SMTP id hj6so3404679wib.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Apr 2012 01:28:40 -0700 (PDT)
In-Reply-To: <4F7AB2F4.2060905@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

But I am able to set static limits in the config for rbd :) All I want
is a change on-the-fly.

It is NOT cgroups mechanism, but completely qemu-driven.

On Tue, Apr 3, 2012 at 12:21 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> Hi,
>
> Op 3-4-2012 10:02, Andrey Korolyov schreef:
>
>> Hi,
>>
>> # virsh blkdeviotune Test vdb --write_iops_sec 50 //file block devic=
e
>>
>> # virsh blkdeviotune Test vda --write_iops_sec 50 //rbd block device
>> error: Unable to change block I/O throttle
>> error: invalid argument: No device found for specified path
>
>
> That is correct. As far as I know iotune uses the underlying cgroups =
from
> the OS.
>
> RBD devices (when using Qemu) are not block devices which can be mana=
ged by
> cgroups. That's why it's not working and you get the error that the d=
evice
> can't be found.
>
> There is however somebody working on DiskIoThrottling inside Qemu:
> http://wiki.qemu.org/Features/DiskIOLimits
>
> That would work with RBD (he even names Ceph :) )
>
> Wido
>
>>
>> 2012-04-03 07:38:49.170+0000: 30171: debug :
>> virDomainSetBlockIoTune:18317 : dom=3D0x1114590, (VM: name=3DTest,
>> uuid=3D8c27bf32-82dc-315a-d0ba-4653b1b3d595), disk=3Dvda,
>> params=3D0x1114600, nparams=3D1, flags=3D0
>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>> virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D11, f=3D16 e=3D1 d=3D=
0
>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>> virEventPollCalculateTimeout:325 : Calculate expiry of 4 timers
>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>> virEventPollCalculateTimeout:331 : Got a timeout scheduled for
>> 1333438734170
>> 2012-04-03 07:38:49.170+0000: 30171: error : qemuDiskPathToAlias:113=
38
>> : invalid argument: No device found for specified path
>> 2012-04-03 07:38:49.170+0000: 30171: debug : virDomainFree:2313 :
>> dom=3D0x1114590, (VM: name=3DTest,
>> uuid=3D8c27bf32-82dc-315a-d0ba-4653b1b3d595)
>> 2012-04-03 07:38:49.170+0000: 30171: debug : virUnrefDomain:276 :
>> unref domain 0x1114590 Test 1
>> 2012-04-03 07:38:49.170+0000: 30171: debug : virReleaseDomain:238 :
>> release domain 0x1114590 Test 8c27bf32-82dc-315a-d0ba-4653b1b3d595
>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>> virEventPollCalculateTimeout:351 : Timeout at 1333438734170 due in
>> 5000 ms
>> 2012-04-03 07:38:49.170+0000: 30169: debug : virEventPollRunOnce:619=
 :
>> EVENT_POLL_RUN: nhandles=3D9 imeout=3D5000
>> 2012-04-03 07:38:49.170+0000: 30171: debug : virReleaseDomain:246 :
>> unref connection 0x1177b10 2
>>
>> libvir 0.9.10, json-escape patch applied, but seems that this proble=
m
>> related to another incorrect path handle.
>>
>> I`m in doubt if it belongs to libvirt ml or here.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
