From: Chu Duc Minh <chu.ducminh@gmail.com>
Subject: Re: Make Openstack work with Ceph
Date: Thu, 08 Mar 2012 17:25:35 +0700
Message-ID: <4F58891F.4060808@gmail.com>
References: <4F586F49.4070703@gmail.com> <CAMvP8PCRdcmcM7wYid0_G7FMWGLO4LNUdxOKGi+24hWMdZyHjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48452 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab2CHKZj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 05:25:39 -0500
Received: by dajr28 with SMTP id r28so306948daj.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Mar 2012 02:25:39 -0800 (PST)
In-Reply-To: <CAMvP8PCRdcmcM7wYid0_G7FMWGLO4LNUdxOKGi+24hWMdZyHjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: ceph-devel@vger.kernel.org

I have some problem with "boot-from-volume" script. Maybe the reason is 
i'm using Keystone and this script is not compatible.
And I have problem with ceph-client-tools package(on Openstack cluster) 
because it's different with version of Ceph that i used to build 
Ceph-cluster.
I wil rebuild next day and report result.

Thanks you for fast response!
On 03/08/2012 03:58 PM, Tomasz Paszkowski wrote:
> Hi,
>
> Right now there's no clean way to do this. You need few scripts to
> achive this. First you need to create volume, prepopulate it with
> image from glance and later create an instance booting from it.
> Scripts below are doing this task.
>
> https://github.com/ceph/ceph-openstack-tools/blob/master/start-on-rbd.sh
> https://github.com/ceph/ceph-openstack-tools/blob/master/boot-from-volume
>
>
> This is good enough but I'am working on solution to implement volume
> imaging directly from nova-compute component. It's should be made
> public within 3/4 weeks.
>
>
>
> On Thu, Mar 8, 2012 at 9:35 AM, Chu Duc Minh<chu.ducminh@gmail.com>  wrote:
>> Hi, i have built a Ceph cluster and a Openstack cluster for dev
>> Ceph work quite smooth, i can mount it to client, or create disk image by
>> using rbd, qemu-img,... command.
>> But i dont' know how to make openstack use new Ceph cluster as the default
>> Block Device Storage.
>> (Openstack use KVM as default hypervisor and QCOW2 as default disk image
>> format)
>>
>> Can you give me some hint to configure Openstack(libvirt/..) to make it work
>> with Ceph, pls?
>>
>> Thanks very much, folks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

