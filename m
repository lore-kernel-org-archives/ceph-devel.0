From: sverre stoltenberg <sverrest@opera.com>
Subject: Re: Truncated file on posix mount
Date: Fri, 15 Jun 2012 14:55:53 +0200
Message-ID: <4FDB30D9.2090009@opera.com>
References: <4FDB03CD.5010202@opera.com> <4FDB1D3C.1040309@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.opera.com ([213.236.208.81]:46877 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756823Ab2FOM4A (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Jun 2012 08:56:00 -0400
In-Reply-To: <4FDB1D3C.1040309@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On 06/15/2012 01:32 PM, Wido den Hollander wrote:
> Hi,
>
> On 15-06-12 11:43, sverre stoltenberg wrote:
>> I have a ceph posix mount for openstack instances, and have found some
>> of my kernels truncated. It looks rather random, and I have not found a
>> way to reproduce it, but it will happen from time to time with normal
>> use.
>>
>
> Can you share the following information?
>
> - Kernel version
> - Ceph version
> - "ceph -s" output

The ceph filesystem is running on 3 debian wheezy boxes:

Linux t06-13 3.1.0-1-amd64 #1 SMP Tue Jan 10 05:01:58 UTC 2012 x86_64 
GNU/Linux

root@t06-13:~# ceph --version
ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)

root@t06-13:~# ceph -s
2012-06-15 14:36:59.978738    pg v696676: 800 pgs: 800 active+clean; 
65033 MB data, 158 GB used, 245 GB / 408 GB avail
2012-06-15 14:36:59.998849   mds e87: 1/1/1 up 
{0=t06-13-iscsi=up:active}, 2 up:standby
2012-06-15 14:36:59.998887   osd e1331: 4 osds: 3 up, 3 in
2012-06-15 14:37:00.010743   log 2012-06-11 10:55:04.785427 osd.2 
10.20.230.11:6801/31505 9228 : [WRN] old request 
osd_op(client.2822106.1:1146772 1000000007f.0000000f [write 
880640~4096,startsync 0~0] 0.c3ee5287 snapc 1=[] ordersnap) received at 
2012-06-11 10:54:34.667593 currently waiting for sub ops
2012-06-15 14:37:00.010870   mon e1: 3 mons at 
{0=10.20.230.13:6789/0,1=10.20.230.12:6789/0,2=10.20.230.11:6789/0}

The machine that is trying to mount the filesystem is ubuntu 12.04

Linux t06-16 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10 20:39:51 UTC 
2012 x86_64 x86_64 x86_64 GNU/Linux

root@t06-16:/var/log# ceph --version
ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)


Did not see this when running everything on ceph 0.46, so I will try to 
upgrade the debian boxes.

> The MDS / POSIX filesystem hasn't been tested very well at the moment,
> in the next sprint (starting soon) the developers will start focusing on
> the POSIX filesystem.

That's good news. Thanks a lot!

-- 
/S.
