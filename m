From: Christoph Raible <c.raible@science-computing.de>
Subject: kernel errors, timeouts and qemu-img usage
Date: Tue, 03 May 2011 13:50:44 +0200
Message-ID: <4DBFEC14.1040102@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.belwue.de ([129.143.2.15]:55740 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab1ECLur convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2011 07:50:47 -0400
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp2.belwue.de with ESMTP id p43Bojp4006257
	for <ceph-devel@vger.kernel.org>; Tue, 3 May 2011 13:50:45 +0200 (MEST)
	env-from (prvs=097125fec=c.raible@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id E3A65AC002
	for <ceph-devel@vger.kernel.org>; Tue,  3 May 2011 13:50:44 +0200 (CEST)
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rmZ1Z4hZloKN for <ceph-devel@vger.kernel.org>;
	Tue,  3 May 2011 13:50:44 +0200 (CEST)
Received: from nerva.science-computing.de (nerva.science-computing.de [10.10.16.94])
	by scmail.science-computing.de (Postfix) with ESMTP id 55461AC001
	for <ceph-devel@vger.kernel.org>; Tue,  3 May 2011 13:50:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by nerva.science-computing.de (Postfix) with ESMTP id 43BA7A3424
	for <ceph-devel@vger.kernel.org>; Tue,  3 May 2011 13:50:44 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi @all,

I got some errors after compiling an configuring ceph on Scientific 
Linux 6. ( This works all fine with no errors)

First of all I want to explain my Systems:

Server0-3:

- Scientific Linux 6:
   - Self compiled Kernel 2.6.38.4 from Kernel.org with ceph-modules
   - 4 partitions:
     - /           <---  20 GB - ext4
     - /srv/cloud  <---  20 GB - ext4
     - /dev/sda5   <---   1 GB - ext4   ceph journaling system
     - /dev sda6   <---  50 GB - ext4   ceph fs mounted to /mnt/data

I didn't use brtfs, because ext4 is an requirement of my professor (I'm 
writing my bachelor thesis)


My ceph.conf:  http://pastebin.com/vdwfHNy3

- 3 OSD
- 2 MDS
- 3 Monitors




---------------------------

Now to my errors I got.



First I alwas get on  ceph -w following "error":

"[WRN] message from mon2 was stamped 12.271440s in the future clocks 
not synchronized"

But i have synchronized my clocks 1 min befor with the same ntp-server..



----------------------------

The second error is, that I can't create / start an qemu-image on the 
ceph-filesystem. I want to start a kvm virtual machine with the 
virt-manager.

I create an image with

   "qemu-img create -f qcow2 Platte-qcow2.img 10G"

When I chose those image an want to start a virtual machine with that 
image. The virtual machine never starts. It hangs on look for the "harddisk"

Creating an Image with virt-manager doesn't work. There is after 2-3 
minutes a timout and I have to kill the virt-manager job.

Are there some experiences with this?



-----------------------------


The third error I got is the following shown in the /var/log/messages file:

http://pastebin.com/dnwVRf5F

Are those timeouts normal?



-----------------------------


The last error I got for today is the following:

http://pastebin.com/UmrCRuhq


This happend when I was creating a dummy file with:

   dd if=/dev/zero of=meineDatei count=5000000




I hope it's not too much errors in one message, but I want to show them 
all in one email for the better look if depending to each other ;)



Thanks for you help.

With best regards,

Christoph Raible

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


