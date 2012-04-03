From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Setting iotune limits on rbd
Date: Tue, 03 Apr 2012 10:45:33 +0200
Message-ID: <4F7AB8AD.30205@widodh.nl>
References: <CABYiri81Jku1F7DjHYT80FPAq_swMfPkYGSnUpEaNsxs0BG6=w@mail.gmail.com> <4F7AB2F4.2060905@widodh.nl> <CABYiri_D64hnf1NqEnW93RXWbUj9BQKsMadfQC41Py-a1j0ZwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:52857 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2DCIpf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Apr 2012 04:45:35 -0400
In-Reply-To: <CABYiri_D64hnf1NqEnW93RXWbUj9BQKsMadfQC41Py-a1j0ZwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

Op 3-4-2012 10:28, Andrey Korolyov schreef:
> But I am able to set static limits in the config for rbd :) All I want
> is a change on-the-fly.
>
> It is NOT cgroups mechanism, but completely qemu-driven.

Are you sure about that? 
http://libvirt.org/formatdomain.html#elementsBlockTuning

Browsing through the source code I found that this is indeed related to 
libvirt.

In the Qemu driver:

     if (disk->type != VIR_DOMAIN_DISK_TYPE_BLOCK &&
         disk->type != VIR_DOMAIN_DISK_TYPE_FILE)
         goto cleanup;
...
...
cleanup:
     if (!ret) {
         qemuReportError(VIR_ERR_INVALID_ARG,
                         "%s", _("No device found for specified path"));
     }


RBD devices are however of the type: VIR_DOMAIN_DISK_TYPE_NETWORK

That's why you get this error, it's assuming the device you want to set 
the limits on is a block device or a regular file.

Wido

>
> On Tue, Apr 3, 2012 at 12:21 PM, Wido den Hollander<wido@widodh.nl>  wrote:
>> Hi,
>>
>> Op 3-4-2012 10:02, Andrey Korolyov schreef:
>>
>>> Hi,
>>>
>>> # virsh blkdeviotune Test vdb --write_iops_sec 50 //file block device
>>>
>>> # virsh blkdeviotune Test vda --write_iops_sec 50 //rbd block device
>>> error: Unable to change block I/O throttle
>>> error: invalid argument: No device found for specified path
>>
>>
>> That is correct. As far as I know iotune uses the underlying cgroups from
>> the OS.
>>
>> RBD devices (when using Qemu) are not block devices which can be managed by
>> cgroups. That's why it's not working and you get the error that the device
>> can't be found.
>>
>> There is however somebody working on DiskIoThrottling inside Qemu:
>> http://wiki.qemu.org/Features/DiskIOLimits
>>
>> That would work with RBD (he even names Ceph :) )
>>
>> Wido
>>
>>>
>>> 2012-04-03 07:38:49.170+0000: 30171: debug :
>>> virDomainSetBlockIoTune:18317 : dom=0x1114590, (VM: name=Test,
>>> uuid=8c27bf32-82dc-315a-d0ba-4653b1b3d595), disk=vda,
>>> params=0x1114600, nparams=1, flags=0
>>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>>> virEventPollMakePollFDs:383 : Prepare n=8 w=11, f=16 e=1 d=0
>>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>>> virEventPollCalculateTimeout:325 : Calculate expiry of 4 timers
>>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>>> virEventPollCalculateTimeout:331 : Got a timeout scheduled for
>>> 1333438734170
>>> 2012-04-03 07:38:49.170+0000: 30171: error : qemuDiskPathToAlias:11338
>>> : invalid argument: No device found for specified path
>>> 2012-04-03 07:38:49.170+0000: 30171: debug : virDomainFree:2313 :
>>> dom=0x1114590, (VM: name=Test,
>>> uuid=8c27bf32-82dc-315a-d0ba-4653b1b3d595)
>>> 2012-04-03 07:38:49.170+0000: 30171: debug : virUnrefDomain:276 :
>>> unref domain 0x1114590 Test 1
>>> 2012-04-03 07:38:49.170+0000: 30171: debug : virReleaseDomain:238 :
>>> release domain 0x1114590 Test 8c27bf32-82dc-315a-d0ba-4653b1b3d595
>>> 2012-04-03 07:38:49.170+0000: 30169: debug :
>>> virEventPollCalculateTimeout:351 : Timeout at 1333438734170 due in
>>> 5000 ms
>>> 2012-04-03 07:38:49.170+0000: 30169: debug : virEventPollRunOnce:619 :
>>> EVENT_POLL_RUN: nhandles=9 imeout=5000
>>> 2012-04-03 07:38:49.170+0000: 30171: debug : virReleaseDomain:246 :
>>> unref connection 0x1177b10 2
>>>
>>> libvir 0.9.10, json-escape patch applied, but seems that this problem
>>> related to another incorrect path handle.
>>>
>>> I`m in doubt if it belongs to libvirt ml or here.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

