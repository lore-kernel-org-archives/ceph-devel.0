From: Xing Lin <xinglin@cs.utah.edu>
Subject: questions with rbd sequential read throughputs inside kvm/qemu VMs
Date: Tue, 27 Nov 2012 16:36:46 -0700
Message-ID: <50B54E8E.8040205@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:54148 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2K0XqD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 18:46:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 3A42B6500B9
	for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 16:36:47 -0700 (MST)
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (mail-svr1.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eWDxgYg3nSF2 for <ceph-devel@vger.kernel.org>;
	Tue, 27 Nov 2012 16:36:46 -0700 (MST)
Received: from [155.99.177.51] (155-99-177-51.uconnect.utah.edu [155.99.177.51])
	by smtps.cs.utah.edu (Postfix) with ESMTPSA id D800565009E
	for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 16:36:46 -0700 (MST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am interested to use rbd block devices inside kvm/qemu VMs. I set up a 
tiny ceph cluster using one server machines and used 6 SCSI disks for 
storing data. At the client machine, the sequential read throughput 
seems to be reasonable (~60 MB/s) when I run fio against rbd block 
devices mounted outside of VMs. The read throughput does not seem to be 
reasonable when I use rbd block devices as block devices inside kvm/qemu 
VMs: it jumps to be as high as 200 MB/s. 'tcpdump' shows read requests 
do reach the ceph server. What makes things confusing is the 'iotop' 
does not show any I/O for sequential reads while 'top' shows 'ceph-osd' 
is utilizing CPU at 100%.

This is the section for the rbd disk in VM's xml file.
--------------------------------------------------------
     <disk type='network' device='disk'>
       <driver name='qemu' type='raw'/>
       <source protocol='rbd' name='rbd/image3'>
         <host name='node-0' port='6789'/>
       </source>
       <target dev='vda' bus='virtio'/>
       <address type='pci' domain='0x0000' bus='0x00' slot='0x05' 
function='0x0'/>
     </disk>
--------------------------------------------------------

This is the fio job file I used to measure throughputs.
------------------------------
[global]
rw=read
bs=4m
thread=0
time_based=1
runtime=300
invalidate=1

direct=1
sync=1
ioengine=sync

[sr-vda]
filename=${DEV}
---------------------------------

Does anyone have some suggestions or hints for me to try? Thank you very 
much!

Xing
