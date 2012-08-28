From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Ceph benchmarks
Date: Tue, 28 Aug 2012 16:27:18 +1200
Message-ID: <503C48A6.5060205@catalyst.net.nz>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com> <503C2A86.8080503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49664 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab2H1E1W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 00:27:22 -0400
In-Reply-To: <503C2A86.8080503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

+1 to that. I've been seeing 4-6 MB/s for 4K writes for 1 OSD with 1 SSD 
for journal and another for data [1]. Interestingly I did see some nice 
scaling with 4K random reads: 2-4 MB/s per thread for up to 8 threads 
(looked like it plateaued thereafter).

Cheers

Mark

[1] FYI not on the box I posted about before - on a more modern pc with 
6Bbit/s SATA.

On 28/08/12 14:18, Mark Nelson wrote:
> 5) rados bench tests with smaller requests could be interesting on 15k 
> drives.  I typically see about 1-2MB/s per OSD for 4k requests with 
> 7200rpm SATA disks.

