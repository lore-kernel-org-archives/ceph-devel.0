From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: High-availability testing of ceph
Date: Mon, 30 Jul 2012 22:55:41 -0700
Message-ID: <5017735D.3060206@inktank.com>
References: <60E83269D669544E8069A09CB69135EA011444@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64246 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab2GaFzo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 01:55:44 -0400
Received: by pbbrp8 with SMTP id rp8so11111343pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 22:55:43 -0700 (PDT)
In-Reply-To: <60E83269D669544E8069A09CB69135EA011444@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

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
> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 1536 pgp_num 1536 last_change 1172 owner 0
>
> Test case 1:
> 1. Create a rbd device and read/write to it
> 2. Random turn off one osd on server1  (service ceph stop osd.0)
> 3. check the read/write of rbd device
>
> Test case 2:
> 1. Create a rbd device and read/write to it
> 2. Random turn off one osd on server1  (service ceph stop osd.0)
> 2. Random turn off one osd on server2  (service ceph stop osd.12)
> 3. check the read/write of rbd device
>
> About test case 1, we can access the rbd device as normal. But about test case 2, we would hang there and no response.
> Is it a correct scenario ?
>
> I imagine that we can turn off any two osd when we set the replication as 2.
> Because without the master data, we have two other copies on two different osd.
> Even when we turn off two osd, we can find the data on third osd.
> Any misunderstanding? Thanks!

rep size is the total number of copies, so stopping two osds with rep
size 2 may cause you to lose access to some objects.

Josh

