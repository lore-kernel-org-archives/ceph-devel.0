From: "Stephen Perkins" <perkins@netmass.com>
Subject: ESXi and ideal hardware spec
Date: Mon, 27 Aug 2012 13:17:12 -0500
Message-ID: <00b501cd8480$2dc46b60$894d4220$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 142.122.233.72.static.reverse.ltdomains.com ([72.233.122.142]:56759
	"EHLO stgateway01.netmass.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752231Ab2H0SRO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Aug 2012 14:17:14 -0400
Received: from stgateway01.netmass.com (localhost [127.0.0.1])
	by stgateway01.netmass.com (Postfix) with ESMTP id BD717422068
	for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 13:17:13 -0500 (CDT)
Received: from sidney (sidney.netmass.com [10.10.120.10])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by stgateway01.netmass.com (Postfix) with ESMTPS id 3F1B8422069
	for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 13:17:12 -0500 (CDT)
Content-Language: en-us
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

As part of the ideal hardware spec thread that has been going around, I
wanted to ask comments on virtualizing the OS.  Since my deployment would
eventually be co-located at a remote "lights out" environment,  I require
that I have support for:

	out of band remote access on dedicated port
		- Dell DRAC
		- HP iLO
		- SuperMicro IPMI with KVM
		- ASUS with Remote Management Chip
		- VMWare on the actual virtual machine instances.

	Remote monitoring of physical hardware
		- Dell OpenManage
		- HP Insight Manager
		- SuperMicro SuperDoctor III
		- VMWare

	Integration with a Service Monitor solution
		- Nagios
		- Zabbix
		- VMWare

One thing that integrates well with all of these is the free VMWare ESXi
Hypervisor.

Are there any thoughts on placing all Ceph nodes as single virtual machines
running on top of an ESXi hypervisor?   What I mean by this is that each
brick runs ESXi and then only runs one virtual machine.  

Are there any advantages of running the MON and MDS servers as independent
virtual machines on the same physical brick as an OSD virtual machine
(rather than just running the processes)?  Multi-port Ethernet systems can
segregate traffic between the instances...

- Steve


