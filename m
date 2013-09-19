From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: [ceph-users] Scaling RBD module
Date: Thu, 19 Sep 2013 19:04:31 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A6AF@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A040@SACMBXIP01.sdcorp.global.sandisk.com>
 <523A4EFB.8040601@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:30539
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752045Ab3ISTEh convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Sep 2013 15:04:37 -0400
In-Reply-To: <523A4EFB.8040601@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Anirban Ray <Anirban.Ray@sandisk.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Josh,
Thanks for the information. I am trying to add the following but hitting some permission issue.

root@emsclient:/etc# echo <mon-1>:6789,<mon-2>:6789,<mon-3>:6789 name=admin,key=client.admin,noshare test_rbd ceph_block_test' > /sys/bus/rbd/add
-bash: echo: write error: Operation not permitted

Here is the contents of rbd directory..

root@emsclient:/sys/bus/rbd# ll
total 0
drwxr-xr-x  4 root root    0 Sep 19 11:59 ./
drwxr-xr-x 30 root root    0 Sep 13 11:41 ../
--w-------  1 root root 4096 Sep 19 11:59 add
drwxr-xr-x  2 root root    0 Sep 19 12:03 devices/
drwxr-xr-x  2 root root    0 Sep 19 12:03 drivers/
-rw-r--r--  1 root root 4096 Sep 19 12:03 drivers_autoprobe
--w-------  1 root root 4096 Sep 19 12:03 drivers_probe
--w-------  1 root root 4096 Sep 19 12:03 remove
--w-------  1 root root 4096 Sep 19 11:59 uevent


I checked even if I am logged in as root , I can't write anything on /sys.

Here is the Ubuntu version I am using..

root@emsclient:/etc# lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 13.04
Release:        13.04
Codename:       raring

Here is the mount information....

root@emsclient:/etc# mount
/dev/mapper/emsclient--vg-root on / type ext4 (rw,errors=remount-ro)
proc on /proc type proc (rw,noexec,nosuid,nodev)
sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
none on /sys/fs/cgroup type tmpfs (rw)
none on /sys/fs/fuse/connections type fusectl (rw)
none on /sys/kernel/debug type debugfs (rw)
none on /sys/kernel/security type securityfs (rw)
udev on /dev type devtmpfs (rw,mode=0755)
devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
none on /run/shm type tmpfs (rw,nosuid,nodev)
none on /run/user type tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
/dev/sda1 on /boot type ext2 (rw)
/dev/mapper/emsclient--vg-home on /home type ext4 (rw)


Any idea what went wrong here ?

Thanks & Regards
Somnath

-----Original Message-----
From: Josh Durgin [mailto:josh.durgin@inktank.com]
Sent: Wednesday, September 18, 2013 6:10 PM
To: Somnath Roy
Cc: Sage Weil; ceph-devel@vger.kernel.org; Anirban Ray; ceph-users@lists.ceph.com
Subject: Re: [ceph-users] Scaling RBD module

On 09/17/2013 03:30 PM, Somnath Roy wrote:
> Hi,
> I am running Ceph on a 3 node cluster and each of my server node is running 10 OSDs, one for each disk. I have one admin node and all the nodes are connected with 2 X 10G network. One network is for cluster and other one configured as public network.
>
> Here is the status of my cluster.
>
> ~/fio_test# ceph -s
>
>    cluster b2e0b4db-6342-490e-9c28-0aadf0188023
>     health HEALTH_WARN clock skew detected on mon. <server-name-2>, mon. <server-name-3>
>     monmap e1: 3 mons at {<server-name-1>=xxx.xxx.xxx.xxx:6789/0, <server-name-2>=xxx.xxx.xxx.xxx:6789/0, <server-name-3>=xxx.xxx.xxx.xxx:6789/0}, election epoch 64, quorum 0,1,2 <server-name-1>,<server-name-2>,<server-name-3>
>     osdmap e391: 30 osds: 30 up, 30 in
>      pgmap v5202: 30912 pgs: 30912 active+clean; 8494 MB data, 27912 MB used, 11145 GB / 11172 GB avail
>     mdsmap e1: 0/0/1 up
>
>
> I started with rados bench command to benchmark the read performance of this Cluster on a large pool (~10K PGs) and found that each rados client has a limitation. Each client can only drive up to a certain mark. Each server  node cpu utilization shows it is  around 85-90% idle and the admin node (from where rados client is running) is around ~80-85% idle. I am trying with 4K object size.

Note that rados bench with 4k objects is different from rbd with 4k-sized I/Os - rados bench sends each request to a new object, while rbd objects are 4M by default.

> Now, I started running more clients on the admin node and the performance is scaling till it hits the client cpu limit. Server still has the cpu of 30-35% idle. With small object size I must say that the ceph per osd cpu utilization is not promising!
>
> After this, I started testing the rados block interface with kernel rbd module from my admin node.
> I have created 8 images mapped on the pool having around 10K PGs and I am not able to scale up the performance by running fio (either by creating a software raid or running on individual /dev/rbd* instances). For example, running multiple fio instances (one in /dev/rbd1 and the other in /dev/rbd2)  the performance I am getting is half of what I am getting if running one instance. Here is my fio job script.
>
> [random-reads]
> ioengine=libaio
> iodepth=32
> filename=/dev/rbd1
> rw=randread
> bs=4k
> direct=1
> size=2G
> numjobs=64
>
> Let me know if I am following the proper procedure or not.
>
> But, If my understanding is correct, kernel rbd module is acting as a client to the cluster and in one admin node I can run only one of such kernel instance.
> If so, I am then limited to the client bottleneck that I stated earlier. The cpu utilization of the server side is around 85-90% idle, so, it is clear that client is not driving.
>
> My question is, is there any way to hit the cluster  with more client from a single box while testing the rbd module ?

You can run multiple librbd instances easily (for example with multiple runs of the rbd bench-write command).

The kernel rbd driver uses the same rados client instance for multiple block devices by default. There's an option (noshare) to use a new rados client instance for a newly mapped device, but it's not exposed by the rbd cli. You need to use the sysfs interface that 'rbd map' uses instead.

Once you've used rbd map once on a machine, the kernel will already have the auth key stored, and you can use:

echo '1.2.3.4:6789 name=admin,key=client.admin,noshare poolname imagename' > /sys/bus/rbd/add

Where 1.2.3.4:6789 is the address of a monitor, and you're connecting as client.admin.

You can use 'rbd unmap' as usual.

Josh


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).


