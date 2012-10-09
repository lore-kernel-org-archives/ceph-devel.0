From: James Horner <james.horner@precedent.co.uk>
Subject: Client Location
Date: Tue, 9 Oct 2012 14:14:06 +0100 (BST)
Message-ID: <1467968321.440.1349788446710.JavaMail.root@corellia.pncl.co.uk>
References: <1253073523.409.1349787553083.JavaMail.root@corellia.pncl.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from corellia.pncl.co.uk ([195.224.14.166]:60393 "EHLO
	corellia.pncl.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab2JINO1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 09:14:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by corellia.pncl.co.uk (Postfix) with ESMTP id 03BC26F2C6E
	for <ceph-devel@vger.kernel.org>; Tue,  9 Oct 2012 14:14:07 +0100 (BST)
Received: from corellia.pncl.co.uk ([127.0.0.1])
	by localhost (corellia.pncl.co.uk [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U3pVTcHuyST9 for <ceph-devel@vger.kernel.org>;
	Tue,  9 Oct 2012 14:14:06 +0100 (BST)
Received: from corellia.pncl.co.uk (kili.pncl.co.uk [192.168.3.166])
	by corellia.pncl.co.uk (Postfix) with ESMTP id C5C4F6F2C6C
	for <ceph-devel@vger.kernel.org>; Tue,  9 Oct 2012 14:14:06 +0100 (BST)
In-Reply-To: <1253073523.409.1349787553083.JavaMail.root@corellia.pncl.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi There 




I have a simple test cluster spread across 2 datacenters setup as follows 

DC1: 
mon.w 
mon.x 
mds.w 
mds.x 
osd1 

DC2: 
mon.e 
mds.e 
osd2 

Each DC has a hypervisor(Proxmox running qemu 1.1.1) which can connect to the cluster fine. I think I have the crush map setup to replicate between the datacenters but when I run a VM with a disk on the cluster the hv's connect to the OSD's in the other datacenter. Is there a way to tell qemu that it is DC1 or DC2 and to prefer those osd's? 

Thanks. 
James 



# begin crush map 

# devices 
device 0 osd.0 
device 1 osd.1 

# types 
type 0 osd 
type 1 host 
type 2 rack 
type 3 row 
type 4 room 
type 5 datacenter 
type 6 pool 

# buckets 
host ceph-test-dc1-osd1 { 
id -2 # do not change unnecessarily 
# weight 1.000 
alg straw 
hash 0 # rjenkins1 
item osd.0 weight 1.000 
} 
host ceph-test-dc2-osd1 { 
id -4 # do not change unnecessarily 
# weight 1.000 
alg straw 
hash 0 # rjenkins1 
item osd.1 weight 1.000 
} 
rack dc1-rack1 { 
id -3 # do not change unnecessarily 
# weight 2.000 
alg straw 
hash 0 # rjenkins1 
item ceph-test-dc1-osd1 weight 1.000 
} 

rack dc2-rack1 { 
id -5 
alg straw 
hash 0 
item ceph-test-dc2-osd1 weight 1.000 
} 

datacenter dc1 { 
id -6 
alg straw 
hash 0 
item dc1-rack1 weight 1.000 
} 

datacenter dc2 { 
id -7 
alg straw 
hash 0 
item dc2-rack1 weight 1.000 
} 

pool proxmox { 
id -1 # do not change unnecessarily 
# weight 2.000 
alg straw 
hash 0 # rjenkins1 
item dc1 weight 2.000 
item dc2 weight 2.000 
} 

# rules 
rule proxmox { 
ruleset 0 
type replicated 
min_size 1 
max_size 10 
step take default 
step chooseleaf firstn 0 type datacenter 

step emit 
} 


# end crush map 


