From: jie sun <0maidou0@gmail.com>
Subject: Re:
Date: Wed, 24 Oct 2012 13:48:22 +0800
Message-ID: <CAB6Jr7QbWZ7Xe+VZrPwC7rWcZ7_F6kLm=A+zq1NEAmcGvgky-A@mail.gmail.com>
References: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com>
	<50868471.1070105@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55719 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab2JXFsX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 01:48:23 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so126665oag.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Oct 2012 22:48:22 -0700 (PDT)
In-Reply-To: <50868471.1070105@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

My vm kernel version is "Linux ubuntu12 3.2.0-23-generic".

"ceph-s" shows
"  health HEALTH_OK
   monmap e1: 1 mons at {a=10.100.211.146:6789/0}, election epoch 0, quorum 0 a
   osdmap e152: 10 osds: 9 up, 9 in
    pgmap v48479: 2112 pgs: 2112 active+clean; 23161 MB data, 46323 MB
used, 2451 GB / 2514 GB avail
   mdsmap e31: 1/1/1 up {0=a=up:active} "

In my vm, I do operations like:
I install 4 debs on my vm, such as libnss3, libnspr4, librados2,
librbd1. And then execute "modprobe rbd" so that I can map a image to
my vm.
Then "rbd create foo --size 10240 -m $monIP(my ceph mon IP)",
         "rbd map foo -m $monIP" ------ Here a device /dev/rbd0 can be
used as a local device
         "mkfs -t ext4 /dev/rbd0"
         "mount /dev/rbd0 /mnt(or some other directory)"
After the operations above, I can use this device. But it oftern
prompt some log like "libceph: osd9 10.100.211.68:6809 socket closed".
I just want to mount a device to my vm, so I didn't install a ceph
client. Is this proper to do so?

Thank  you for youer answer!




2012/10/23 Wido den Hollander <wido@widodh.nl>:
> On 10/23/2012 06:12 AM, jie sun wrote:
>>
>> Hi,
>>
>> I created and mounted a rbd for a virtual machine. And it can be used
>> as a block device normally, but often prompt some log like below:
>
>
> Could you provide us a bit more information?
>
> What kernel are you using?
>
> What does "ceph -s" show you?
>
> Are you running KVM virtual machines and connecting /dev/rbd0 as a device to
> the virtual machine?
>
> Wido
>
>> "Oct 23 10:30:22 ubuntu12 kernel: [321506.941606] libceph: osd3
>> 10.100.211.146:6810 socket closed
>> Oct 23 10:30:59 ubuntu12 kernel: [321544.337856] libceph: osd9
>> 10.100.211.68:6809 socket closed
>> Oct 23 10:45:22 ubuntu12 kernel: [322407.233090] libceph: osd3
>> 10.100.211.146:6810 socket closed
>> Oct 23 10:45:59 ubuntu12 kernel: [322444.766796] libceph: osd9
>> 10.100.211.68:6809 socket closed
>> Oct 23 11:00:22 ubuntu12 kernel: [323307.529098] libceph: osd3
>> 10.100.211.146:6810 socket closed
>> Oct 23 11:01:00 ubuntu12 kernel: [323345.241679] libceph: osd9
>> 10.100.211.68:6809 socket closed
>> Oct 23 11:15:22 ubuntu12 kernel: [324207.821113] libceph: osd3
>> 10.100.211.146:6810 socket closed
>> Oct 23 11:16:00 ubuntu12 kernel: [324245.717747] libceph: osd9
>> 10.100.211.68:6809 socket closed
>> Oct 23 11:17:01 ubuntu12 CRON[10529]: (root) CMD (   cd / && run-parts
>> --report /etc/cron.hourly)
>> Oct 23 11:30:23 ubuntu12 kernel: [325108.117134] libceph: osd3
>> 10.100.211.146:6810 socket closed"
>>
>> These log also can be found in "/var/log/syslog".
>> I google something about this problem,but didn't understand what
>> you've wrote in "http://tracker.newdream.net/issues/2260" exactly.
>> How can I resolve this problem? My ceph version is 0.48.
>> Should I change some files, or modify some content of some file?
>>
>> Thank you !
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
