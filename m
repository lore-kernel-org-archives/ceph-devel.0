From: <Eric_YH_Chen@wiwynn.com>
Subject: RE: High-availability testing of ceph
Date: Tue, 31 Jul 2012 07:31:30 +0000
Message-ID: <60E83269D669544E8069A09CB69135EA011D31@GDC-CLDMBX-P02.whq.wistron>
References: <60E83269D669544E8069A09CB69135EA011444@GDC-CLDMBX-P02.whq.wistron>
 <5017735D.3060206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:53849 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab2GaHbp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 03:31:45 -0400
In-Reply-To: <5017735D.3060206@inktank.com>
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi, Josh:

Thanks for your reply. However, I had asked a question about replica setting before.
http://www.spinics.net/lists/ceph-devel/msg07346.html

If the performance of rbd device is n MB/s under replica=2,
then that means the total io throughputs on hard disk is over 3 * n MB/s. 
Because I think the total number of copies is 3 in original.

So, it seems not correct now, the total number of copies is only 2. 
The total io through puts on disk should be 2 * n MB/s. Right?

-----Original Message-----
From: Josh Durgin [mailto:josh.durgin@inktank.com] 
Sent: Tuesday, July 31, 2012 1:56 PM
To: Eric YH Chen/WYHQ/Wiwynn
Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY Chang/WYHQ/Wiwynn
Subject: Re: High-availability testing of ceph

On 07/30/2012 07:46 PM, Eric_YH_Chen@wiwynn.com wrote:
> Hi, all:
>
> I am testing high-availability of ceph.
>
> Environment:  two servers, and 12 hard-disk on each server. Version: Ceph 0.48
>               Kernel: 3.2.0-27
>
> We create a ceph cluster with 24 osd.
> Osd.0 ~ osd.11 is on server1
> Osd.12 ~ osd.23 is on server2
>
> The crush rule is using default rule.
> rule rbd {
>          ruleset 2
>          type replicated
>          min_size 1
>          max_size 10
>          step take default
>          step chooseleaf firstn 0 type host
>          step emit
> }
>
> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 
> 1536 pgp_num 1536 last_change 1172 owner 0
>
> Test case 1:
> 1. Create a rbd device and read/write to it 2. Random turn off one osd 
> on server1  (service ceph stop osd.0) 3. check the read/write of rbd 
> device
>
> Test case 2:
> 1. Create a rbd device and read/write to it 2. Random turn off one osd 
> on server1  (service ceph stop osd.0) 2. Random turn off one osd on 
> server2  (service ceph stop osd.12) 3. check the read/write of rbd 
> device
>
> About test case 1, we can access the rbd device as normal. But about test case 2, we would hang there and no response.
> Is it a correct scenario ?
>
> I imagine that we can turn off any two osd when we set the replication as 2.
> Because without the master data, we have two other copies on two different osd.
> Even when we turn off two osd, we can find the data on third osd.
> Any misunderstanding? Thanks!

rep size is the total number of copies, so stopping two osds with rep size 2 may cause you to lose access to some objects.

Josh

