From: Peter Niemayer <niemayer@isg.de>
Subject: Re: Using other filesystems than btrfs with Ceph
Date: Fri, 11 Jun 2010 18:42:54 +0200
Message-ID: <hutp2e$od8$1@dough.gmane.org>
References: <hutgsk$oh4$1@dough.gmane.org> <AANLkTin6wleXQVepvMACh8JMr5sa1g4neVXD_Voi7rYT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33007 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab0FKQnO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Jun 2010 12:43:14 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ON7K3-0006Xa-M6
	for ceph-devel@vger.kernel.org; Fri, 11 Jun 2010 18:43:11 +0200
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jun 2010 18:43:11 +0200
Received: from niemayer by barriere.frankfurter-softwarefabrik.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jun 2010 18:43:11 +0200
In-Reply-To: <AANLkTin6wleXQVepvMACh8JMr5sa1g4neVXD_Voi7rYT@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 06/11/2010 06:26 PM, Gregory Farnum wrote:
>> Also, the documentation in the Wiki does not mention what would need
>> to be configured differently if another filesystem was to be used -
>> what would I have to use instead of "btrfs devs = /dev/sdy"?
> You can look at the ceph.conf file produced by the vstart script for a
> non-btrfs example -- just use
> osd data = path
> osd journal = path2
> osd journal size = [# in MB]

Thanks for this info!


> Well, it's possible that you could improve Ceph's performance in
> certain workloads by using different underlying filesystems, but in
> general Ceph's interfaces and protocols are going to matter a lot
> more, and btrfs works very well with it.

It would be interesting to me what would be a factor of slow-down
to be expected when setting up a minimalistic one-node-Ceph service,
where all daemons run on localhost, and just one local filesystem
is created for the OSD, in comparison to using btrfs directly on that
local filesystem?

Would you expect a significant decrease in sequential read/write throughput?
And what about latencies for small reads/writes?

I wonder what would be an acceptable design-goal when ruling
out physical network equipment or cabling for the moment...


Regards,

Peter Niemayer


