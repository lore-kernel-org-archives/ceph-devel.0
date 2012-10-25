From: "Stephen Perkins" <perkins@netmass.com>
Subject: Proper configuration of the SSDs in a storage brick
Date: Thu, 25 Oct 2012 08:30:49 -0500
Message-ID: <002401cdb2b4$f259c800$d70d5800$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 142.122.233.72.static.reverse.ltdomains.com ([72.233.122.142]:61819
	"EHLO stgateway01.netmass.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759382Ab2JYNaz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Oct 2012 09:30:55 -0400
Content-Language: en-us
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

In looking at the design of a storage brick (just OSDs), I have found a dual
power hardware solution that allows for 10 hot-swap drives and has a
motherboard with 2 SATA III 6G ports (for the SSDs) and 8 SATA II 3G (for
physical drives).  No RAID card. This seems a good match to me given my
needs.  This system also supports 10G Ethernet via an add in card, so please
assume that for the questions.  I'm also assuming 2TB or 3TB drives for the
8 hot swap.  My workload is throughput intensive (writes mainly) and not IOP
heavy.

I have 2 questions and would love to hear from the group.

Question 1: What is the most appropriate configuration for the journal SSDs?

I'm not entirely sure what happens when you lose a journal drive.  If the
whole brick goes offline (i.e. all OSDs stop communicating with ceph), does
it make since to configure the SSDs into RAID1?

Alternatively, it seems that there is a performance benefit to having 2
independent SSDs since you get potentially twice the journal rate.  If a
journal drive goes offline. do you only have to recover half the brick?

If having 2 drives does not provide a performance benefit, it there a
benefit other than RAID 1 for redundancy?


Question 2:  How to handle the OS?

I need to install an OS on each brick?   I'm guessing the SSDs are the
device of choice. Not being entirely familiar with the journal drives:

Should I create a separate drive partition for the OS?  

Or. can the journals write to the same partition as the OS?  

Should I dedicate one drive to the OS and one drive to the journal?

RAID1 or independent?

Use a mechanical drive?

Alternately. the 10G NIC cards support remote iSCSI boot.  This allows both
SSDs to be dedicated to journaling. Seems like more complexity. 

I would appreciate hearing the thoughts of the group.

Best regards,

- Steve



