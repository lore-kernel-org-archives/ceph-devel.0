From: Martin Mailand <martin@tuxadero.com>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 22:11:38 +0100
Message-ID: <509ACE8A.5090708@tuxadero.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com> <509A77CA.5030206@inktank.com> <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov> <509A8A32.9020701@inktank.com> <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov> <509A8F4F.7090404@inktank.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:43163 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab2KGVLv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 16:11:51 -0500
In-Reply-To: <509A8F4F.7090404@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "Atchley, Scott" <atchleyes@ornl.gov>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I have 16 SAS disk on a LSI 9266-8i and 4 Intel 520 SSD on a HBA, the 
node has dual 10G Ethernet. The clients are 4 nodes with dual 10GeB, as 
test I use rados bench on each client. The aggregated write speed is 
around 1,6GB/s with single replication.

In the first configuration, I had the SSDs on the raidcontroller as 
well, but then I saturated the PCIe 2.0 x8 interface of the 
raidcontroller, therefore I use a second controller for the SSDs.


-martin


Am 07.11.2012 17:41, schrieb Mark Nelson:
> Well, local, but still over tcp.  Right now I'm focusing on pushing the
> osds/filestores as far as I can, and after that I'm going to setup a
> bonded 10GbE network to see what kind of messenger bottlenecks I run
> into.  Sadly the testing is going slower than I would like.

