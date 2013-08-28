From: James Dingwall <james.dingwall-9Rhf1UHGS49BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph + Xen - RBD io hang
Date: Wed, 28 Aug 2013 08:55:19 +0100
Message-ID: <521DACE7.4000802@zynstra.com>
References: <521C8368.6040102@zynstra.com>
	<alpine.DEB.2.00.1308270827280.2000@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1308270827280.2000-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Sage Weil wrote:
> Can you post the contents of the hung task warning so we can see where it
> is stuck?
The messages in the domU are:

[35284.544137] INFO: task dd:4903 blocked for more than 120 seconds.
[35284.544148] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[35284.544312] INFO: task flush-202:0:4904 blocked for more than 120 
seconds.
[35284.544315] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[35284.544450] INFO: task blkid:4906 blocked for more than 120 seconds.
[35284.544453] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.

As per the suggestion of Olivier I tried with 3.9.11 for dom0 but with 
this kernel I didn't get any writes to succeed from the domU at all.  
The complete set of commands that I executed are given below.

Regards,
James


dom0# uname -r
3.9.11

dom0# xl info
...
xen_major              : 4
xen_minor              : 3
xen_extra              : .0
...

dom0# rbd --version
ceph version 0.67.2 (eb4380dd036a0b644c6283869911d615ed729ac8)

dom0# ceph status
   cluster b85e8b00-baca-4d21-95d6-4b45f652dfd9
    health HEALTH_OK
    monmap e1: 1 mons at {a=ip-this-node:6789/0}, election epoch 1, 
quorum 0 a
    osdmap e1590: 4 osds: 4 up, 4 in
     pgmap v43252: 576 pgs: 576 active+clean; 33416 MB data, 72315 MB 
used, 1971 GB / 2048 GB avail
    mdsmap e30676: 1/1/1 up {0=a=up:active}

dom0# mount | grep osd
/dev/mapper/sysvg-ceph_osd0 on /var/lib/ceph/osd/ceph-0 type btrfs 
(rw,noatime)
/dev/mapper/sysvg-ceph_osd1 on /var/lib/ceph/osd/ceph-1 type btrfs 
(rw,noatime)

dom0# rbd create --size 32768 --image-format 1 ubuntu-test

dom0# rbd info ubuntu-test
rbd image 'ubuntu-test':
         size 32768 MB in 8192 objects
         order 22 (4096 KB objects)
         block_name_prefix: rb.0.422a.2ae8944a
         format: 1

dom0# rbd map rbd/ubuntu-test

dom0# rbd showmapped
id pool image       snap device
1  rbd  ubuntu-test -    /dev/rbd1

dom0# for i in $(seq 0 1023) ; do echo $i ; dd if=/dev/rbd1 of=/dev/null 
bs=1M count=64 skip=$(($i * 4)) ; done
...
1023
64+0 records in
64+0 records out
67108864 bytes (67 MB) copied, 0.430964 s, 156 MB/s

dom0# for i in $(seq 0 1023) ; do echo $i ; dd if=/dev/zero of=/dev/rbd1 
bs=1M count=64 seek=$(($i * 4)) ; done
...
1023
64+0 records in
64+0 records out
67108864 bytes (67 MB) copied, 0.0559911 s, 1.2 GB/s

dom0# xl create pv_ceph.cfg

dom0# for i in $(seq 0 1023) ; do echo $i ; dd if=/dev/rbd1 of=/dev/null 
bs=1M count=64 skip=$(($i * 4)) ; done
...
1023
64+0 records in
64+0 records out
67108864 bytes (67 MB) copied, 0.0651528 s, 1.0 GB/s

dom0# for i in $(seq 0 1023) ; do echo $i ; dd if=/dev/zero of=/dev/rbd1 
bs=1M count=64 seek=$(($i * 4)) ; done
...
1023
64+0 records in
64+0 records out
67108864 bytes (67 MB) copied, 0.705422 s, 95.1 MB/s
# The last two tests are to show that the rbd device is 
readable/writeable while passed through the domU until the domU tries a 
write

domU# lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 13.04
Release:        13.04
Codename:       raring

domU# uname -r
3.8.0-19-generic

domU# for i in $(seq 0 1023) ; do echo $i ; dd if=/dev/xvda of=/dev/null 
bs=1M count=64 skip=$(($i * 4)) ; done
...
1023
64+0 records in
64+0 records out
67108864 bytes (67 MB) copied, 1.1602 s, 57.8 MB/s
# The domU has no problems reading from the virtual block device

domU# for i in $(seq 0 1023) ; do echo $i ; dd if=/dev/zero of=/dev/xvda 
bs=1M count=64 seek=$(($i * 4)) ; done
0
[35284.544137] INFO: task dd:4903 blocked for more than 120 seconds.
[35284.544148] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[35284.544312] INFO: task flush-202:0:4904 blocked for more than 120 
seconds.
[35284.544315] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[35284.544450] INFO: task blkid:4906 blocked for more than 120 seconds.
[35284.544453] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
# repeated every two minutes, a similar test with a 3.10.9 dom0 usually 
managed a small number of iterations of the loop

dom0# dmesg | tail
# these messages start before trying the write test in domU but perhaps 
they are important
[43395.355813] libceph: osd3 ip-other-node:6804 socket closed (con state 
OPEN)
[43395.358203] rbd: obj_request ffff8800474793c0 was already done

[44295.663754] libceph: osd3 ip-other-node:6804 socket closed (con state 
OPEN)
[44295.666140] rbd: obj_request ffff8800474793c0 was already done

[45195.971648] libceph: osd3 ip-other-node:6804 socket closed (con state 
OPEN)
[45195.974044] rbd: obj_request ffff8800474793c0 was already done

dom0# for i in $(seq 0 1023) ; do echo $i ; dd if=/dev/rbd1 of=/dev/null 
bs=1M count=64 skip=$(($i * 4)) ; done
# dd is now hung, kernel debug options are not enabled in the config but 
I would expect
# similar messages to domU if they were.  I can recompile the dom0 
kernel to include the hung task check if that
# may produce useful information.  dd does not respond to a kill -USR1
0

dom0# ps auxw | grep [r]bd1
root      6484  0.0  0.0 111344  1724 pts/1    D+   07:18   0:00 dd 
if=/dev/rbd1 of=/dev/null bs=1M count=64 skip=0

dom0# xl destroy pv_ceph
libxl: error: libxl_device.c:894:device_backend_callback: unable to 
remove device with path /local/domain/0/backend/vbd/1/51712
libxl: error: libxl_device.c:894:device_backend_callback: unable to 
remove device with path /local/domain/0/backend/vif/1/0
libxl: error: libxl.c:1451:devices_destroy_cb: libxl__devices_destroy 
failed for 1

# dom0 locked up shortly afterwards, power reset required.  This lock 
was not observed when testing with a 3.10.9 dom0 kernel.

> On Tue, 27 Aug 2013, James Dingwall wrote:
>
>> Hi,
>>
>> I am doing some experimentation with Ceph and Xen (on the same host) and I'm
>> experiencing some problems with the rbd device that I'm using as the block
>> device.  My environment is:
>>
>> 2 node Ceph 0.67.2 cluster, 4x OSD (btrfs) and 1x mon
>> Xen 4.3.0
>> Kernel 3.10.9
>>
>> The domU I'm trying to build is from the Ubuntu 13.04 desktop release.  When I
>> pass through the rbd (format 1 or 2) device as phy:/dev/rbd/rbd/ubuntu-test
>> then the domU has no problems reading data from it, the test I ran was:
>>
>> for i in $(seq 0 1023) ; do
>>      dd if=/dev/xvda of=/dev/null bs=4k count=1024 skip=$(($i * 4))
>> done
>>
>> However writing data causes the domU to hang while while i is still in single
>> figures but it doesn't seem consistent about the exact value.
>> for i in $(seq 0 1023) ; do
>>      dd of=/dev/xvda of=/dev/zero bs=4k count=1024 seek=$(($i * 4))
>> done
>>
>> eventually the kernel in the domU will print a hung task warning.  I have
>> tried the domU as pv and hvm (with xen_platform_pci = 1 and 0) but have the
>> same behaviour in both cases.  Once this state is triggered on the rbd device
>> then any interaction with it in dom0 will result in the same hang.  I'm
>> assuming that there is some unfavourable interaction between ceph/rbd and
>> blkback but I haven't found anything in the dom0 logs so I would like to know
>> if anyone has some suggestions about where to start trying to hunt this down.
>>
>> Thanks,
>> James
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
