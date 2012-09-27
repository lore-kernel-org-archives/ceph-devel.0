From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Slow ceph fs performance
Date: Fri, 28 Sep 2012 11:40:07 +1200
Message-ID: <5064E3D7.6080002@catalyst.net.nz>
References: <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:46076 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2I0XkL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 19:40:11 -0400
In-Reply-To: <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@Virginia.EDU
Cc: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

Bryan -

Note that the default block size for the rados bench is 4MB...and 
performance decreases quite dramatically with smaller block sizes (-b 
option to rados bench).

On 27/09/12 08:54, Bryan K. Wright wrote:
>
> 	The rados benchmark was run on one of the OSD
> machines.  Read and write results looked like this (the
> objects size was just the default, which seems to be 4kB):
>
> # rados bench -p pbench 900 write
> Total time run:         900.549729
> Total writes made:      33819
> Write size:             4194304
> Bandwidth (MB/sec):     150.215
>
> Stddev Bandwidth:       16.2592
> Max bandwidth (MB/sec): 212
> Min bandwidth (MB/sec): 84
> Average Latency:        0.426028
> Stddev Latency:         0.24688
> Max latency:            1.59936
> Min latency:            0.06794
>
> # rados bench -p pbench 900 seq
> Total time run:        900.572788
> Total reads made:     33676
> Read size:            4194304
> Bandwidth (MB/sec):    149.576
>
> Average Latency:       0.427844
> Max latency:           1.48576
> Min latency:           0.015371
>
>
>
>

