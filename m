From: Christoph Raible <c.raible@science-computing.de>
Subject: Re: kernel errors, timeouts and qemu-img usage
Date: Wed, 04 May 2011 11:33:51 +0200
Message-ID: <4DC11D7F.2000306@science-computing.de>
References: <4DBFEC14.1040102@science-computing.de> <20110503164334.GC20739@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.belwue.de ([129.143.2.12]:44822 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab1EDJqE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 05:46:04 -0400
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp1.belwue.de with ESMTP id p449XrEM021909
	for <ceph-devel@vger.kernel.org>; Wed, 4 May 2011 11:33:53 +0200 (MEST)
	env-from (prvs=098264eeb=c.raible@science-computing.de)
In-Reply-To: <20110503164334.GC20739@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Am 03.05.2011 18:43, schrieb Tommi Virtanen:
> On Tue, May 03, 2011 at 01:50:44PM +0200, Christoph Raible wrote:
>> First I alwas get on  ceph -w following "error":
>>
>> "[WRN] message from mon2 was stamped 12.271440s in the future clocks
>> not synchronized"
>>
>> But i have synchronized my clocks 1 min befor with the same
>> ntp-server..
>
> Just running ntp doesn't mean your clocks are synced. For example, it
> will refuse to synchronize automatically if the gap is too large.
>
> Here's how you demonstrate your clocks are good:
>
> [0 tv@dreamer ~]$ host pool.ntp.org
> pool.ntp.org has address 204.235.61.9
> pool.ntp.org has address 66.219.59.208
> pool.ntp.org has address 169.229.70.95
> [0 tv@dreamer ~]$ ssh sepia32.ceph.dreamhost.com ntpdate -q 204.235.61.9
> server 204.235.61.9, stratum 2, offset -31.351031, delay 0.09187
>   3 May 09:25:27 ntpdate[8303]: step time server 204.235.61.9 offset -31.351031 sec
> [0 tv@dreamer ~]$ ssh sepia80.ceph.dreamhost.com ntpdate -q 204.235.61.9
> server 204.235.61.9, stratum 2, offset 0.000159, delay 0.09181
>   3 May 09:24:59 ntpdate[373]: adjust time server 204.235.61.9 offset 0.000159 sec
> [0 tv@dreamer ~]$
>
> See how one of the clocks is more than 30 seconds off, and the other
> one is near-perfect.

I synchronized with ntpdate but there is an other error. I will look at 
this. If i got a solution I will report ;)

>
>> ----------------------------
>>
>> The second error is, that I can't create / start an qemu-image on
>> the ceph-filesystem. I want to start a kvm virtual machine with the
>> virt-manager.
>>
>> I create an image with
>>
>>    "qemu-img create -f qcow2 Platte-qcow2.img 10G"
>>
>> When I chose those image an want to start a virtual machine with
>> that image. The virtual machine never starts. It hangs on look for
>> the "harddisk"
>>
>> Creating an Image with virt-manager doesn't work. There is after 2-3
>> minutes a timout and I have to kill the virt-manager job.
>>
>> Are there some experiences with this?
>
> Are you using rbd, or just qcow2 images in files stored in a Ceph
> mount?


I only use qcow2 Images stored in a Ceph mount. I can't use rbd because 
I have to copy Images from one location to Ceph mount.


> If rbd, please provide more details on what exactly you did.
>
> If just qcow2 files on ceph, then this seems to be very similar to the
> problems you reported below; your setup seems unable to handle heavy
> IO, for some reason.

No that's not the problem after I resolved the problem with the I/O I 
also can't connect / use any qemu / kvm images. I tested with following 
image types qcow2, raw & img



>> -----------------------------
>>
>> The third error I got is the following shown in the /var/log/messages file:
>>
>> http://pastebin.com/dnwVRf5F
>>
>> Are those timeouts normal?
>
> They look somewhat similar to the issues I've seen with more than MDS
> and a write-heavy workload. At this point you probably don't want two
> MDSes active. All of my problems went away when I started testing
> against clusters with just one MDS.
>

I have now testet with only one MDS and it works fine :D that's strange, 
it looks like a Problem between the MDS synchronisation.


>> -----------------------------
>>
>> The last error I got for today is the following:
>>
>> http://pastebin.com/UmrCRuhq
>>
>>
>> This happend when I was creating a dummy file with:
>>
>>    dd if=/dev/zero of=meineDatei count=5000000
>
> This one looks like the underlying filesystem cannot handle the write
> load, and makes the OSD daemon hang.
>
> Your ceph.conf says "osd data = /data/osd$id", but your partition list
> earlier claimed /dev/sda6 is "ceph fs mounted to /mnt/data". I'm
> assuming you these are supposed to be the same, and you're using ext4.

I'm sorry I have posted the wrong link to my ceph.conf :( This is the 
right (I updated both ;) )

http://pastebin.com/VanmWmX5

>
> I don't recall seeing many people having this kind of problems with
> ext4. You might want to check what happens if you shut off ceph,
> and try that dd directly to the underlying disk. If that works well,
> please check back and we can continue figuring that one out.

This works fine  with an average speed of 40 MB/s (not full speed ;) )


> BTW, your config says "devs = /dev/sda1".. The actual config option is
> "btrfs devs", so that should be ignored completely, but it seems
> there's some confusion in the air.

-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 


