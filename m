From: Christoph Raible <c.raible@science-computing.de>
Subject: KVM / Qemu  Images doesn't work with ceph-fs
Date: Thu, 05 May 2011 11:45:27 +0200
Message-ID: <4DC271B7.10406@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.belwue.de ([129.143.2.12]:58044 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab1EEKBU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 06:01:20 -0400
Received: from mx4.science-computing.de (mx4.science-computing.de [193.197.16.30])
	by smtp1.belwue.de with ESMTP id p459jgP8016911
	for <ceph-devel@vger.kernel.org>; Thu, 5 May 2011 11:45:42 +0200 (MEST)
	env-from (prvs=0993b5628=c.raible@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id E4536414002
	for <ceph-devel@vger.kernel.org>; Thu,  5 May 2011 11:45:27 +0200 (CEST)
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tnXvVYwwVSGl for <ceph-devel@vger.kernel.org>;
	Thu,  5 May 2011 11:45:27 +0200 (CEST)
Received: from nerva.science-computing.de (nerva.science-computing.de [10.10.16.94])
	by scmail.science-computing.de (Postfix) with ESMTP id 51A12414001
	for <ceph-devel@vger.kernel.org>; Thu,  5 May 2011 11:45:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by nerva.science-computing.de (Postfix) with ESMTP id 3EB9BA3424
	for <ceph-devel@vger.kernel.org>; Thu,  5 May 2011 11:45:27 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi @all,

in an other mail (http://marc.info/?t=130442346600006&r=1&w=2)
I explained my Config. And after two changes in the config file
the ceph-fs works fine :)

Now I want to use image-files (qcow2, raw or img filetype) with KVM.

This doesn't work.

When I do a fresh isntallation / creation with virt-install:


virt-install --connect qemu:///system -n vm18 -r 512 --vcpus=2 -f 
/ceph/vm18.qcow2 -s 10 -c /tmp/debian-6.0.1a-amd64-netinst.iso --vnc 
--vncport=5961 --vnclisten=0.0.0.0 --noautoconsole --os-type linux 
--os-variant generic26 --accelerate --network=bridge:br0 --hvm

The creation of the file works but on installation following errors occur:

http://www.christoph-raible.de/diskerror.png
http://www.christoph-raible.de/diskerror2.png


When I create a VM with virt-manager the creation of the disk hangs on 
the following step (creating Domain):

http://www.christoph-raible.de/diskerror3.png



I have no idea whats wrong a

   dd if=/dev/zero of=meineDatei bs=1024 count=10000

works perfect...


I doesn't have any ideas what's wrong.
Creation of a VM directly on the filesystem (without ceph) works fine.



Regards,

Christoph
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


