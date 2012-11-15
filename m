From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Authorization issues in the 0.54
Date: Fri, 16 Nov 2012 02:40:37 +0300
Message-ID: <CABYiri-peCGv_Upd5Hf_GS8V_kMv9YgZ2rgha870XigXBQ-TAg@mail.gmail.com>
References: <CABYiri8E8Swk0798BR-yimm+Bk1TeoHVMrXZxeEwvvgLCuEOyw@mail.gmail.com>
 <CAC-hyiHwyXO3TEbpvktouf5iGcbb2wnu1dL2q+SH8DVaEmdtgw@mail.gmail.com> <CABYiri85Q9EEPb9TMRkoMYE5XF2_e2mnWxHyxr+FQrq3gHQgXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34108 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab2KOXk7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 18:40:59 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2271144obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 15:40:58 -0800 (PST)
In-Reply-To: <CABYiri85Q9EEPb9TMRkoMYE5XF2_e2mnWxHyxr+FQrq3gHQgXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 15, 2012 at 5:03 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
> On Thu, Nov 15, 2012 at 5:12 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>> On Wed, Nov 14, 2012 at 4:20 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>>> Hi,
>>> In the 0.54 cephx is probably broken somehow:
>>>
>>> $ ceph auth add client.qemukvm osd 'allow *' mon 'allow *' mds 'allow
>>> *' -i qemukvm.key
>>> 2012-11-14 15:51:23.153910 7ff06441f780 -1 read 65 bytes from qemukvm.key
>>> added key for client.qemukvm
>>>
>>> $ ceph auth list
>>> ...
>>> client.admin
>>>         key: [xxxxxx]
>>>         caps: [mds] allow *
>>
>> Note that for mds you just specify 'allow' and not 'allow *'. It
>> shouldn't affect the stuff that you're testing though.
>>
>
> Thanks for the hint!
>
>>>         caps: [mon] allow *
>>>         caps: [osd] allow *
>>> client.qemukvm
>>>         key: [yyyyyy]
>>>         caps: [mds] allow *
>>>         caps: [mon] allow *
>>>         caps: [osd] allow *
>>> ...
>>> $ virsh secret-set-value --secret uuid --base64 yyyyyy
>>> set username in the VM` xml...
>>> $ virsh start testvm
>>> kvm: -drive file=rbd:rbd/vm0:id=qemukvm:key=yyyyyy:auth_supported=cephx\;none:mon_host=192.168.10.125\:6789\;192.168.10.127\:6789\;192.168.10.129\:6789,if=none,id=drive-virtio-disk0,format=raw:
>>> could not open disk image
>>> rbd:rbd/vm0:id=qemukvm:key=yyyyyy:auth_supported=cephx\;none:mon_host=192.168.10.125\:6789\;192.168.10.127\:6789\;192.168.10.129\:6789:
>>> Operation not permitted
>>> $ virsh secret-set-value --secret uuid --base64 xxxxxx
>>> set username again to admin for the VM` disk
>>> $ virsh start testvm
>>> Finally, vm started successfully.
>>>
>>> All rbd commands issued from cli works okay with the appropriate
>>> credentials, qemu binary was linked with same librbd as running one.
>>> Does anyone have a suggestion?
>>
>> There wasn't any change that I'm aware of that should make that
>> happening. Can you reproduce it with 'debug ms = 1' and 'debug auth =
>> 20'?
>>
>
> I`ll provide detailed logs some time later, after I do an upgrade of
> production rack.
>
> The situation is a quite strange - when I did upgrade from older
> version (tested for 0.51 and 0.53), auth was stopped to work exactly
> as above, and any actions with key(importing and elevating privileges
> or importing with max possible privileges) does nothing for an
> rbd-backed QEMU vm, only ``admin'' credentials able to pass
> authentication. When I finally reformatted cluster using mkcephfs for
> 0.54, authentication works with ``rwx'' rights on osd, when earlier
> ``rw'' was enough. Seems that this is some kind of bug in the monfs
> resulting to misworking authentication, also 0.53 to 0.54 was the
> first upgrade which made impossible version rollback - mons
> complaining to an empty set of some ``missing features'' on start, so
> I recreated monfs on every mon during online downgrade(I know that
> downgrade is bad by nature, but since on-disk format for osd was
> fixed, I have trying to do it).


Sorry, it was three overlapping factors - my inattention, additional
``x'' attribute in the required key capabilities and ``backup'' mon
stayed from time of upgrade - I have simply forgot to kill it and this
mon alone caused to drop authentication requests from qemu VMs somehow
in meantime allowing plain cluster operations using ``rbd'' command
and same credentials (very very strange). By the way, it seems that
monitor not included in cluster can easily flood any of existing mons
if it have same name, even it is completely outside authentication
keyring. Output from flooded mon is very close to #2645 by footprint.
I have suggestion that it`ll be reasonable to introduce temporary bans
or any type of foolproof behavior for bad authentication requests on
the monitors in future.

Thanks!
