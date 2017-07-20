From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Luminous RC feedback - device classes and osd df weirdness
Date: Thu, 20 Jul 2017 13:31:43 +1200
Message-ID: <2463efe0-164e-0bee-ef1c-54d4a84258cc@catalyst.net.nz>
References: <71ce32a8-6232-0f5b-35a5-d86f30a045db@catalyst.net.nz>
 <f0536e0e-b9a1-6ef5-c96e-81e873bda624@catalyst.net.nz>
 <alpine.DEB.2.11.1707191451340.27271@piezo.novalocal>
 <77d9e88b-5f51-99b3-4bcd-b022e356d9ff@catalyst.net.nz>
 <832e525f-40df-a5e7-e027-262e4dd30232@catalyst.net.nz>
 <alpine.DEB.2.11.1707200111390.27271@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:39782
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932089AbdGTBbr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Jul 2017 21:31:47 -0400
In-Reply-To: <alpine.DEB.2.11.1707200111390.27271@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 20/07/17 13:14, Sage Weil wrote:

> On Thu, 20 Jul 2017, Mark Kirkwood wrote:
>> On 20/07/17 10:46, Mark Kirkwood wrote:
>>> On 20/07/17 02:53, Sage Weil wrote:
>>>> On Wed, 19 Jul 2017, Mark Kirkwood wrote:
>>>>
>>>>> One (I think) new thing compared to the 12.1.0 is that restarting the
>>>>> services
>>>>> blitzes the modified crushmap, and we get back to:
>>>>>
>>>>> $ sudo ceph osd tree
>>>>> ID CLASS WEIGHT  TYPE NAME      UP/DOWN REWEIGHT PRI-AFF
>>>>> -1       0.32996 root default
>>>>> -2       0.08199     host ceph1
>>>>>    0   hdd 0.02399         osd.0       up  1.00000 1.00000
>>>>>    4   hdd 0.05699         osd.4       up  1.00000 1.00000
>>>>> -3       0.08299     host ceph2
>>>>>    1   hdd 0.02399         osd.1       up  1.00000 1.00000
>>>>>    5   hdd 0.05899         osd.5       up  1.00000 1.00000
>>>>> -4       0.08199     host ceph3
>>>>>    2   hdd 0.02399         osd.2       up  1.00000 1.00000
>>>>>    6   hdd 0.05699         osd.6       up  1.00000 1.00000
>>>>> -5       0.08299     host ceph4
>>>>>    3   hdd 0.02399         osd.3       up  1.00000 1.00000
>>>>>    7   hdd 0.05899         osd.7       up  1.00000 1.00000
>>>>>
>>>>> ...and all the PG are remapped again. Now I might have just missed this
>>>>> happening with 12.1.0 - but I'm (moderately) confident that I did
>>>>> restart
>>>>> stuff and not see this happening. For now I've added:
>>>>>
>>>>> osd crush update on start = false
>>>>>
>>>>> to my ceph.conf to avoid being caught by this.
>>> Actually setting the above does *not* prevent the crushmap getting changed.
>>>
>>>> Can you share teh output of 'ceph osd metadata 0' vs 'cpeh osd metadata
>>>> 4'?  I'm not sure why it's getting the class wrong.  I haven't seen this
>>>> on my cluster (it's bluestore; maybe that's the difference).
>>>>
>>>>
>>> Yes, and it is quite interesting: osd 0 is filestore on hdd, osd 4 is
>>> bluestore on ssd but (see below) the metadata suggests ceph thinks it is hdd
>>> (the fact that the hosts are VMs might be not helping here):
>>>
>>> $ sudo ceph osd metadata 0
>>> {
>>>      "id": 0,
>>>      "arch": "x86_64",
>>>      "back_addr": "192.168.122.21:6806/1712",
>>>      "backend_filestore_dev_node": "unknown",
>>>      "backend_filestore_partition_path": "unknown",
>>>      "ceph_version": "ceph version 12.1.1
>>> (f3e663a190bf2ed12c7e3cda288b9a159572c800) luminous (rc)",
>>>      "cpu": "QEMU Virtual CPU version 1.7.0",
>>>      "distro": "ubuntu",
>>>      "distro_description": "Ubuntu 16.04.2 LTS",
>>>      "distro_version": "16.04",
>>>      "filestore_backend": "xfs",
>>>      "filestore_f_type": "0x58465342",
>>>      "front_addr": "192.168.122.21:6805/1712",
>>>      "hb_back_addr": "192.168.122.21:6807/1712",
>>>      "hb_front_addr": "192.168.122.21:6808/1712",
>>>      "hostname": "ceph1",
>>>      "kernel_description": "#106-Ubuntu SMP Mon Jun 26 17:54:43 UTC 2017",
>>>      "kernel_version": "4.4.0-83-generic",
>>>      "mem_swap_kb": "1047548",
>>>      "mem_total_kb": "2048188",
>>>      "os": "Linux",
>>>      "osd_data": "/var/lib/ceph/osd/ceph-0",
>>>      "osd_journal": "/var/lib/ceph/osd/ceph-0/journal",
>>>      "osd_objectstore": "filestore",
>>>      "rotational": "1"
>>> }
>>>
>>> $ sudo ceph osd metadata 4
>>> {
>>>      "id": 4,
>>>      "arch": "x86_64",
>>>      "back_addr": "192.168.122.21:6802/1488",
>>>      "bluefs": "1",
>>>      "bluefs_db_access_mode": "blk",
>>>      "bluefs_db_block_size": "4096",
>>>      "bluefs_db_dev": "253:32",
>>>      "bluefs_db_dev_node": "vdc",
>>>      "bluefs_db_driver": "KernelDevice",
>>>      "bluefs_db_model": "",
>>>      "bluefs_db_partition_path": "/dev/vdc2",
>>>      "bluefs_db_rotational": "1",
>>>      "bluefs_db_size": "63244840960",
>>>      "bluefs_db_type": "hdd",
>>>      "bluefs_single_shared_device": "1",
>>>      "bluestore_bdev_access_mode": "blk",
>>>      "bluestore_bdev_block_size": "4096",
>>>      "bluestore_bdev_dev": "253:32",
>>>      "bluestore_bdev_dev_node": "vdc",
>>>      "bluestore_bdev_driver": "KernelDevice",
>>>      "bluestore_bdev_model": "",
>>>      "bluestore_bdev_partition_path": "/dev/vdc2",
>>>      "bluestore_bdev_rotational": "1",
>>>      "bluestore_bdev_size": "63244840960",
>>>      "bluestore_bdev_type": "hdd",
>>>      "ceph_version": "ceph version 12.1.1
>>> (f3e663a190bf2ed12c7e3cda288b9a159572c800) luminous (rc)",
>>>      "cpu": "QEMU Virtual CPU version 1.7.0",
>>>      "distro": "ubuntu",
>>>      "distro_description": "Ubuntu 16.04.2 LTS",
>>>      "distro_version": "16.04",
>>>      "front_addr": "192.168.122.21:6801/1488",
>>>      "hb_back_addr": "192.168.122.21:6803/1488",
>>>      "hb_front_addr": "192.168.122.21:6804/1488",
>>>      "hostname": "ceph1",
>>>      "kernel_description": "#106-Ubuntu SMP Mon Jun 26 17:54:43 UTC 2017",
>>>      "kernel_version": "4.4.0-83-generic",
>>>      "mem_swap_kb": "1047548",
>>>      "mem_total_kb": "2048188",
>>>      "os": "Linux",
>>>      "osd_data": "/var/lib/ceph/osd/ceph-4",
>>>      "osd_journal": "/var/lib/ceph/osd/ceph-4/journal",
>>>      "osd_objectstore": "bluestore",
>>>      "rotational": "1"
>>> }
>>>
>>>
>> I note that /sys/block/vdc/queue/rotational is 1 , so this looks like libvirt
>> is being dense about the virtual disk...if I cat '0' into the file then the
>> osd restarts *do not* blitz the crushmap anymore - so it looks the previous
>> behaviour is brought on by my use of VMs - I'll try mashing it with a udev
>> rule to get the 0 in there :-)
>>
>> It is possibly worthy of a doco note about how this detection works at the
>> Ceph level, just in case there are some weird SSD firmwares out there that
>> result in the flag being set wrong in bare metal environments.
> Yeah.  Note that there is also a PR in flight streamlining some of the
> device class code that could potentially make the class more difficult to
> change, specifically to avoid situations like this.  For example, if the
> class is already set, the update on OSD start could be a no-op (do not
> change), and only set it if there is no class at all.  To change, you
> would (from the cli), 'ceph osd crush rm-device-class osd.0' and then
> 'ceph osd crush set-device-class osd.0' (or restart the osd, or perhaps
> pass a --force flag to set-device-class.  Does that seem like a reasonable
> path?
>
> I'm mostly worried about future changes to our auto-detect class logic.
> If we change anything (intentionally or not) we don't want to trigger a
> ton of data rebalancing on OSD restart because the class changes from,
> say, 'ssd' to 'nvme' due to improved detection logic.
>
>

Yeah, some resistance to change once a class is set sounds like a good plan!

regards

Mark

