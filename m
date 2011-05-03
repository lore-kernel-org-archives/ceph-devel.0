From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: kernel errors, timeouts and qemu-img usage
Date: Tue, 03 May 2011 18:14:28 +0200
Message-ID: <4DC029E4.3@provocation.net>
References: <4DBFEC14.1040102@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:51079 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1ECQOf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2011 12:14:35 -0400
In-Reply-To: <4DBFEC14.1040102@science-computing.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 05/03/2011 01:50 PM, Christoph Raible wrote:

> First I alwas get on  ceph -w following "error":
> "[WRN] message from mon2 was stamped 12.271440s in the future clocks not synchronized"
> But i have synchronized my clocks 1 min befor with the same ntp-server..

But are they really in sync?

> The second error is, that I can't create / start an qemu-image on the ceph-filesystem. 
> I want to start a kvm virtual machine with the virt-manager.
> I create an image with

>   "qemu-img create -f qcow2 Platte-qcow2.img 10G"

> The virtual machine never starts. It hangs on look for the "harddisk" 

The image file has to appear as a block device; I suspect you need
http://ceph.newdream.net/wiki/QEMU-RBD .

I have no clue about the third error; what were you doing when you got it?

The fourth error is a timeout too. The file you are trying to write is 2.4
GiB in size (dd defaults to 512 bytes, so 512*5000000 bytes). Your journal
is only 500 MB and you are replicating the data and you are logging 20 on
the same physical hard drive, so I suspect very serious I/O saturation.

Try bs= together with count= for better dd control and write a much smaller
file. Try disabling hung_task_timeout as the error message suggested. Try
also nice and ionice on dd. The problem might be something unrelated, but
this is a quick way to start figuring what's happening.

Z

