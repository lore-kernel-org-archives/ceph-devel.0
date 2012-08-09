From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Ceph RBD performance - random writes
Date: Thu, 09 Aug 2012 12:43:03 +1200
Message-ID: <50230797.8040008@catalyst.net.nz>
References: <5021F6D1.7000004@catalyst.net.nz> <5022B3F4.5050109@inktank.com> <5022E121.4070004@inktank.com> <5022F7EF.2020007@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49710 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758675Ab2HIAnH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 20:43:07 -0400
In-Reply-To: <5022F7EF.2020007@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On 09/08/12 11:36, Mark Kirkwood wrote:
> On 09/08/12 09:58, Mark Nelson wrote:
>>
>> For what it's worth, with mostly default settings I was seeing about 
>> 8MB/s to dell branded samsung SSDs with 4k IOs using rados bench.  
>> That was with 256 concurrent client requests.  This is definitely 
>> something we are working hard on tracking down.
>>
>
> Right (FWIW I think the Dells are actually Toshiba devices - and are 
> pretty good). This is what I get doing the rados bench for 1M and 4K 
> blocks:
>
>

Sorry Josh - I completely missed the word "Samsung" in your 
post...(we've been testing some Dell branded SSD for another project and 
it was like giving blood to get the actual brand and model out of them)...

>
> $ rados bench -b 1048576 -t 256 -p rbd 100  write
> Total writes made:      3879
> Write size:             1048576
> Bandwidth (MB/sec):     38.414
>
> Stddev Bandwidth:       40.157
> Max bandwidth (MB/sec): 174
> Min bandwidth (MB/sec): 0
> Average Latency:        6.57279
> Stddev Latency:         6.20373
> Max latency:            28.531
> Min latency:            0.435691
>
>
> $ rados bench -b 4096 -t 256 -p rbd 100  write
> Total writes made:      4851
> Write size:             4096
> Bandwidth (MB/sec):     0.179
>
> Stddev Bandwidth:       0.378904
> Max bandwidth (MB/sec): 3.22266
> Min bandwidth (MB/sec): 0
> Average Latency:        5.60013
> Stddev Latency:         8.18634
> Max latency:            22.6542
> Min latency:            0.020016
>
>

I tried out a raft of xfs config changes and also made the Ceph journal 
really big (10G):

$ mkfs.xfs -f -l internal,size=1024m -d agcount=4 /dev/sd[b,c]2

+ mount options with nobarrier,logbufs=8

The results improved a little, but still very slow for small request 
sizes...


$ rados bench -b 1048576 -t 256 -p rbd 100  write
Total writes made:      5165
Write size:             1048576
Bandwidth (MB/sec):     50.646

Stddev Bandwidth:       18.8124
Max bandwidth (MB/sec): 205
Min bandwidth (MB/sec): 0
Average Latency:        4.93633
Stddev Latency:         0.549063
Max latency:            5.58999
Min latency:            1.90631


$ rados bench -b 4096 -t 256 -p rbd 100  write
Write size:             4096
Bandwidth (MB/sec):     0.316

Stddev Bandwidth:       0.874144
Max bandwidth (MB/sec): 3.96484
Min bandwidth (MB/sec): 0
Average Latency:        3.16257
Stddev Latency:         11.9167
Max latency:            58.1325
Min latency:            0.017823




