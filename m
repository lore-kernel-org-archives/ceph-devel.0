From: Josh Durgin <joshd@hq.newdream.net>
Subject: Re: [libvirt] [PATCH] support sheepdog volumes
Date: Fri, 19 Nov 2010 14:56:35 -0800
Message-ID: <4CE700A3.6090408@hq.newdream.net>
References: <1289985598-20565-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>	<20101118104630.GX15851@redhat.com> <4CE5C7F2.2080606@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51061 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006Ab0KSW4g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Nov 2010 17:56:36 -0500
In-Reply-To: <4CE5C7F2.2080606@lab.ntt.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org

On 11/18/2010 04:42 PM, MORITA Kazutaka wrote:
> On 2010/11/18 19:46, Daniel P. Berrange wrote:
>> On Wed, Nov 17, 2010 at 06:19:58PM +0900, MORITA Kazutaka wrote:
>>> Sheepdog is a distributed storage system for QEMU. It provides highly
>>> available block level storage volumes to VMs like Amazon EBS.  This
>>> patch adds support for Sheepdog; we can create VMs with sheepdog
>>> volumes, and attach sheepdog volumes to running machines via the
>>> attach-device command.
>>>
>>> Sheepdog volumes can be declared like this:
>>>
>>>      <disk type='sheepdog' device='disk'>
>>>        <driver name='qemu' type='raw' />
>>>        <source vdi='volume_name' host='hostname' port='7000'/>
>>>        <target dev='vda' bus='virtio' />
>>>      </disk>
>>>
>>> 'host' and 'port' in the source element are optional.  If they are not
>>> specified, sheepdog clients use the default value (localhost:7000).
>>
>> I'm not too familiar with sheepdog implementation, but I understand
>> that each block device is stored across multiple hosts, but you're
>> only listing one hostname here.  In the proposal for supporting RBD/
>> CEPH in libvirt/QEMU, there's tan option to give multiple hostnames.
>> Is the need to give multiple hostnames going to be something that
>> is also relevant for Sheepdog, or does it cope with this in an
>> entirely different way ?
>
> We use the hostname as like a gateway to access sheepdog volumes.
> Though we could extend it to multiple hostnames to achieve high
> availability, how to use these parameters as qemu arguments needs to
> be discussed.

For RBD, the monitor hostnames can be set through the environment. It
looks like this is easy to add to the libvirt QEMU driver. Would
environment variables work for sheepdog as well?

>>
>> As mentioned in the RBD thread[1], I'm wondering whether we should aim
>> for separate 'types' for each network block device or try to merge
>> them into one common syntax like
>>
>>       <disk type="network" device="disk">
>>         <driver name="qemu" type="raw" />
>>         <source protocol='rbd|sheepdog|nbd' name="...some image identifier...">
>>           <host name="mon1.example.org" port="6000">
>>           <host name="mon2.example.org" port="6000">
>>           <host name="mon3.example.org" port="6000">
>>         </source>
>>         <target dev="vda" bus="virtio" />
>>       </disk>
>
> Are monitor addresses necessary in the above syntax for RBD?  I guess
> the monitor addresses are parameters to create a rbd image, but not
> ones to use a rbd image.  If so, we can make the syntax a bit simpler like

The monitors serve as gateways for RBD. All need to be specified
so that RBD can still access the cluster if some monitors go down.

>       <disk type="network" device="disk">
>         <driver name="qemu" type="raw" />
>         <source protocol='rbd|sheepdog|nbd' name="..." host="hostname" port="6000" />
>         <target dev="vda" bus="virtio" />
>       </disk>
>
>
> Thannks,
>
> Kazutaka

Thanks,
Josh
