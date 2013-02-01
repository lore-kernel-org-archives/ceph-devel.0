From: sheng qiu <herbert1984106@gmail.com>
Subject: some performance issue
Date: Fri, 1 Feb 2013 14:20:16 -0600
Message-ID: <CAB7xdinwhd6gmqbzeC7Gp+ugDbJhOcr1TwX-1KYg5=geWbT0+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46293 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267Ab3BAUUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 15:20:17 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so2599600iea.38
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 12:20:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

i did one experiment which gives some interesting result.

i create two OSD (ext4), each is a SSD attached on the same PC. i also
configure one monitor and one mds on that PC.
so generally, my OSDs, monitor and mds locate on the same node.

i set up the ceph service and mount the ceph also on a local directory
on that PC. so client, OSDs, monitor and mds all on the same node.
i suppose this will exclude the network communication cost.

i run fio benchmark which create one 10GB file (larger than main
memory) on the ceph mount point. it perform sequential read/write and
random read/write on the file, and generate the throughput result.

next i umount the ceph and stop ceph service. i create ext4 on the
same SSD that used as OSD before. then run the same workloads and get
the throughput result.

here are the results:

(throughput kb/s)Seq-read	Rand-read	Seq-write	Rand-write
ceph	                 7378	4740	           790	1211
ext4	                 58260	17334	 54697	34257

as you see, the ceph has huge performance down, even monitor, mds,
client and osds locate on the same physical machine.
another interesting thing is the seq-write has lower throughput
compared with random-write under ceph. not quite clear....

does anyone have idea about why ceph has that performance down?

Thanks,
Sheng


-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
