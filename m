From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Ceph RBD performance - random writes
Date: Tue, 14 Aug 2012 17:41:44 +1200
Message-ID: <5029E518.5070500@catalyst.net.nz>
References: <5021F6D1.7000004@catalyst.net.nz> <5022B3F4.5050109@inktank.com> <5022E121.4070004@inktank.com> <5022F7EF.2020007@catalyst.net.nz> <50230797.8040008@catalyst.net.nz> <5023347B.6060806@catalyst.net.nz> <5023A22C.10100@inktank.com> <50244863.3030907@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:37586 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab2HNFls (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 01:41:48 -0400
In-Reply-To: <50244863.3030907@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On 10/08/12 11:31, Mark Kirkwood wrote:
>
>
> There could well be an additional factor connected with xfs and lots 
> of files on these Intel 520s - I have just had a conversation with a 
> workmate who switched xfs to ext4 due to this. I will see if ext4 or 
> btrfs (scary) do any better on these drives...
>

Actually that seems to be a different issue (mass deletion of many small 
files)...I am not seeing significant differences using ext4 or btrfs. So 
back to using xfs again :-)

One thing that *does* seems to have made a difference is upgrading from 
0.48 to 0.50 (also Ubuntu kernel patched from 3.2.0-27 to 3.2.0-29):

$ rados bench -b 4096 -t 256 -p rbd 100  write
Total writes made:      65202
Write size:             4096
Bandwidth (MB/sec):     2.534

Stddev Bandwidth:       0.851288
Max bandwidth (MB/sec): 4.67969
Min bandwidth (MB/sec): 0
Average Latency:        0.39456
Stddev Latency:         0.283639
Max latency:            4.07996
Min latency:            0.022397

(Recall Bandwidth was about 0.3 MB/sec previously). Typical iostat looks 
much happier:

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s wMB/s avgrq-sz 
avgqu-sz   await r_await w_await  svctm  %util
sdc               0.00     0.00    0.00  364.00     0.00 4.14    
23.30     0.06    0.18    0.00    0.18   0.18   6.40
sdb               0.00  1006.00    0.00 1091.00     0.00 10.77    
20.21    12.77   11.66    0.00   11.66   0.66  72.00


I'll get collectl info using this version unless Mark especially wants 
the data for 0.48 (but it *looks* like some nice improvements are in 
there already with the later version).

Cheers

Mark


