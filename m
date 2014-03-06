From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Ceph Ansible Repo
Date: Thu, 06 Mar 2014 13:28:30 +0000
Message-ID: <531877FE.6040106@cam.ac.uk>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>	<CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>	<53186512.6080405@cam.ac.uk> <CAJH6TXhSTRvn3NRqh=WXY5VdPhbW+HxPZAbUGCEqtX6rB6YFWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:41781 "EHLO
	ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaCFN2c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 08:28:32 -0500
In-Reply-To: <CAJH6TXhSTRvn3NRqh=WXY5VdPhbW+HxPZAbUGCEqtX6rB6YFWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Sebastien Han <sebastien.han@enovance.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>

On 06/03/14 13:19, Gandalf Corvotempesta wrote:
> 2014-03-06 13:07 GMT+01:00 David McBride <dwm37@cam.ac.uk>:
>> This causes the IO load to be nicely balanced across the two SSDs,
>> removing any hot spots, at the cost of enlarging the failure domain of
>> the loss of an SSD from half a node to a full node.
> 
> This is not a solution for me.
> Why not using LVM with a VG striped across both SSD ?
> I've never used LVM without raid, what happens in case of failure
> of a phisical disks?  The whole VG is lost ?

Yes.  A stripe-set depends on all of the members of an array, whether
managed through MD or LVM.

Thus, in a machine with two SSDs, which are striped together, the loss
of *either* SSD will cause all of the OSDs hosted by that machine to be
lost.

(Note: if you want to use LVM rather than GPTs on MD, you will probably
need to remove the '|dm-*' clause from the Ceph udev rules that govern
OSD assembly before they will work as expected.)

Kind regards,
David
-- 
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Computing Service
