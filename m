From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph cluster hangs when rebooting one node
Date: Mon, 12 Nov 2012 16:24:37 +0100
Message-ID: <50A114B5.30104@profihost.ag>
References: <50A1101A.4070401@profihost.ag> <alpine.DEB.2.00.1211120710330.2293@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41880 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2KLPYk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 10:24:40 -0500
In-Reply-To: <alpine.DEB.2.00.1211120710330.2293@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 12.11.2012 16:11, schrieb Sage Weil:
> On Mon, 12 Nov 2012, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> i was checking what happens if i reboot a ceph node.
>>
>> Sadly if i reboot one node, the whole ceph cluster hangs and no I/O is
>> possible.
>
> If you are using the current master, the new 'min_size' may be biting you;
> ceph osd dump | grep ^pool and see if you see min_size for your pools.
> You can change that back to the norma behavior with

No i don't see any min size:
# ceph osd dump | grep ^pool
pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 
1344 pgp_num 1344 last_change 1 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 
1344 pgp_num 1344 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 1344 
pgp_num 1344 last_change 1 owner 0
pool 3 'kvmpool1' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 
3000 pgp_num 3000 last_change 958 owner 0

>   ceph osd pool set <poolname> min_size 1
Yes this helps! But min_size is still not shown in ceph osd dump. Also 
when i reboot a node it takes up to 10s-20s until all osds from this 
node are set to failed and the I/O starts again. Should i issue an ceph 
osd out command before?

But i had already this set for all my rules in my crushmap
         min_size 1
         max_size 2

in my crushmap for each rule.

Stefan
