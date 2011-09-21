From: Martin Mailand <martin@tuxadero.com>
Subject: RDB Performance
Date: Wed, 21 Sep 2011 22:48:30 +0200
Message-ID: <4E7A4D9E.3070305@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:41489 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1IUUsi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2011 16:48:38 -0400
Received: from [192.168.1.106] (e178239038.adsl.alicedsl.de [85.178.239.38])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8LKmVg6017438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2011 22:48:36 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,
I have a few question about the rbd performance. I have a small ceph 
installation, three osd server one monitor server and one compute node 
which maps a rbd image to a block device, all server a connectet via a 
dedicated 1Gbs network.
Each osd is capable of doing around 90MB/s tested with osd bench.
But if I test the write speed of the rbd block device the performance 
ist quite poor.

I do the test with
dd if=/dev/zero of=/dev/rbd0 bs=1M count=10000 oflag=direct,
I get a throughput around 25MB/s.
I used wireshark to graph the network throughput, the image is
http://tuxadero.com/multistorage/ceph.jpg
as you can see the throughput is not smooth.

The graph for the test without the oflag=direct is
http://tuxadero.com/multistorage/ceph2.jpg
which is much better, but I the compute node uses around 4-5G of it's 
RAM as a writeback cache, which is not acceptable for my application.

For comparison the graph for a scp transfer.
http://tuxadero.com/multistorage/scp.jpg

I read in the ceph doku, that ever "package" has to be commited to the 
disk on the osd, before it is acknowledged to the client, could you 
please expalain what a package is? Probably not a TCP package.

And on the mailinglist was a discussion about a writeback window, to my 
understanding it say how many byte can be
unacknowledged in transit, is that right?

How could I activate it?

Thanks for your time.

Best Regards,
  martin
