From: Li Wang <liwang@ubuntukylin.com>
Subject: [RFC] Factors affect CephFS read performance
Date: Tue, 30 Jul 2013 23:35:52 +0800
Message-ID: <51F7DD58.2090302@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:52842 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab3G3Pf4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 11:35:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org

We measured Cephfs read performance by using iozone on a 32-node HPC 
cluster, the Ceph cluster configuration: 24 OSDs (one per node), 1 MDS, 
1 -4 Clients (one thread per client per per node). The hardware of a 
node: CPU and network are both very powerful to not be bottleneck during 
the test, memory: 64GB, IO throughput of OSD: 70MB/s (measured by 'dd' 
locally). We found the following factors do matter for Ceph read 
performance,

(1) Record size
Record size is performance-critical for 'Stride Read' and 'Random Read',
for example, for 'Random Read' with one client, with 'Record Size' from
256KB to 16MB, the throughput increases from 39MB/s to 166MB/s. However,
'Record Size' has no obvious impact on 'Sequential Read' performance,
no matter the 'Record Size' changing within [256KB, 16MB], the 
throughput remains [170MB/s, 190MB/s].

(2) Multiple access
Multiple access are performance-critical for all the read patterns. For 
example, although 'Sequential Read' performance remains stable (and also 
relatively slow) in terms of 'Record Size', it increases from 170MB/s to 
580MB/s when number of clients increase from 1 to 4 when 'Record 
Size'=4MB. 'Random Read' throughput from 80MB/s to 400MB/s.
We think it because the latency of single Ceph read transaction is 
relatively large, multiple access could linearly scale the throughput.

(3) Read ahead
We are inspired to test this due to the results of 'Sequential Read', as 
mentioned above, unlike other read patterns, it does not scale with 
'Record Size', it seems something has reached the bottleneck even with a 
small 'Record Size'=256KB. So we guess it is the read ahead window size. 
Part of results are below,

  Iozone sequential read throughput (MB/s)
Number of clients     1          2         4
Default resize    180.0954   324.4836   591.5851
Resize = 256MB    645.3347   1022.998    1267.631

The complete iozone parameter for one client is,
iozone -t 1 -+m /tmp/iozone.nodelist.50305030 -s 64G -r 4M -i 0 -+n -w 
-c -e -b /tmp/iozone.nodelist.50305030.output, on each client node, only 
one thread is started.

for two clients, it is,
iozone -t 2 -+m /tmp/iozone.nodelist.50305030 -s 32G -r 4M -i 0 -+n -w 
-c -e -b /tmp/iozone.nodelist.50305030.output

(2) and (3) is easy to understand, however, why does 'Record Size' 
matter? And, any similar experience to share?

Cheers,
Li Wang
