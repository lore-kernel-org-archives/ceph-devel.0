From: Sage Weil <sweil@redhat.com>
Subject: Re: question about the 'r' value in CRUSH
Date: Sun, 24 Jan 2016 09:34:35 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601240933230.5707@cpach.fuggernut.com>
References: <FF8D83DAE5DF57468726B79904321E0603CA9DE5@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58471 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbcAXOe0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 Jan 2016 09:34:26 -0500
In-Reply-To: <FF8D83DAE5DF57468726B79904321E0603CA9DE5@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 23 Jan 2016, Xusangdi wrote:
> Hi Sage,
> 
> Recently we encountered an interesting case when learning about CRUSH, please see below:
> 
> root root {
>     id -4       # do not change unnecessarily
>     # weight 36.000
>     alg straw2
>     hash 0  # rjenkins1
>     item host0 weight 3.000
>     item host1 weight 3.000
>     item host2 weight 30.000
> }
> 
> CRUSHCHOOSE_LEAF bucket -4 x 3 outpos 0 numrep 3 tries 51 recurse_tries 1 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -4 x=3 r=0
>   item -3 type 1
> CHOOSE bucket -3 x 3 outpos 0 numrep 1 tries 1 recurse_tries 0 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -3 x=3 r=0
>   item 8 type 0
> CHOOSE got 8
> CHOOSE returns 1
> CHOOSE got -3
>  crush_bucket_choose -4 x=3 r=1
>   item -3 type 1
>   reject 0  collide 1  ftotal 1  flocal 1
>  crush_bucket_choose -4 x=3 r=2
>   item -3 type 1
>   reject 0  collide 1  ftotal 2  flocal 1
>  crush_bucket_choose -4 x=3 r=3
>   item -3 type 1
>   reject 0  collide 1  ftotal 3  flocal 1
>  crush_bucket_choose -4 x=3 r=4
>   item -3 type 1
>   reject 0  collide 1  ftotal 4  flocal 1
>  crush_bucket_choose -4 x=3 r=5
>   item -3 type 1
>   reject 0  collide 1  ftotal 5  flocal 1
>  crush_bucket_choose -4 x=3 r=6
>   item -3 type 1
>   reject 0  collide 1  ftotal 6  flocal 1
>  crush_bucket_choose -4 x=3 r=7
>   item -3 type 1
>   reject 0  collide 1  ftotal 7  flocal 1
>  crush_bucket_choose -4 x=3 r=8
>   item -3 type 1
>   reject 0  collide 1  ftotal 8  flocal 1
>  crush_bucket_choose -4 x=3 r=9
>   item -3 type 1
>   reject 0  collide 1  ftotal 9  flocal 1
>  crush_bucket_choose -4 x=3 r=10
>   item -3 type 1
>   reject 0  collide 1  ftotal 10  flocal 1
>  crush_bucket_choose -4 x=3 r=11
>   item -3 type 1
>   reject 0  collide 1  ftotal 11  flocal 1
>  crush_bucket_choose -4 x=3 r=12
>   item -3 type 1
>   reject 0  collide 1  ftotal 12  flocal 1
>  crush_bucket_choose -4 x=3 r=13
>   item -3 type 1
>   reject 0  collide 1  ftotal 13  flocal 1
>  crush_bucket_choose -4 x=3 r=14
>   item -3 type 1
>   reject 0  collide 1  ftotal 14  flocal 1
>  crush_bucket_choose -4 x=3 r=15
>   item -3 type 1
>   reject 0  collide 1  ftotal 15  flocal 1
>  crush_bucket_choose -4 x=3 r=16
>   item -3 type 1
>   reject 0  collide 1  ftotal 16  flocal 1
>  crush_bucket_choose -4 x=3 r=17
>   item -3 type 1
>   reject 0  collide 1  ftotal 17  flocal 1
>  crush_bucket_choose -4 x=3 r=18
>   item -3 type 1
>   reject 0  collide 1  ftotal 18  flocal 1
>  crush_bucket_choose -4 x=3 r=19
>   item -2 type 1
> CHOOSE bucket -2 x 3 outpos 1 numrep 2 tries 1 recurse_tries 0 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -2 x=3 r=1
>   item 4 type 0
> CHOOSE got 4
> CHOOSE returns 2
> CHOOSE got -2
>  crush_bucket_choose -4 x=3 r=2
>   item -3 type 1
>   reject 0  collide 1  ftotal 1  flocal 1
>  crush_bucket_choose -4 x=3 r=3
>   item -3 type 1
>   reject 0  collide 1  ftotal 2  flocal 1
>  crush_bucket_choose -4 x=3 r=4
>   item -3 type 1
>   reject 0  collide 1  ftotal 3  flocal 1
>  crush_bucket_choose -4 x=3 r=5
>   item -3 type 1
>   reject 0  collide 1  ftotal 4  flocal 1
>  crush_bucket_choose -4 x=3 r=6
>   item -3 type 1
>   reject 0  collide 1  ftotal 5  flocal 1
>  crush_bucket_choose -4 x=3 r=7
>   item -3 type 1
>   reject 0  collide 1  ftotal 6  flocal 1
>  crush_bucket_choose -4 x=3 r=8
>   item -3 type 1
>   reject 0  collide 1  ftotal 7  flocal 1
>  crush_bucket_choose -4 x=3 r=9
>   item -3 type 1
>   reject 0  collide 1  ftotal 8  flocal 1
>  crush_bucket_choose -4 x=3 r=10
>   item -3 type 1
>   reject 0  collide 1  ftotal 9  flocal 1
>  crush_bucket_choose -4 x=3 r=11
>   item -3 type 1
>   reject 0  collide 1  ftotal 10  flocal 1
>  crush_bucket_choose -4 x=3 r=12
>   item -3 type 1
>   reject 0  collide 1  ftotal 11  flocal 1
>  crush_bucket_choose -4 x=3 r=13
>   item -3 type 1
>   reject 0  collide 1  ftotal 12  flocal 1
>  crush_bucket_choose -4 x=3 r=14
>   item -3 type 1
>   reject 0  collide 1  ftotal 13  flocal 1
>  crush_bucket_choose -4 x=3 r=15
>   item -3 type 1
>   reject 0  collide 1  ftotal 14  flocal 1
>  crush_bucket_choose -4 x=3 r=16
>   item -3 type 1
>   reject 0  collide 1  ftotal 15  flocal 1
>  crush_bucket_choose -4 x=3 r=17
>   item -3 type 1
>   reject 0  collide 1  ftotal 16  flocal 1
>  crush_bucket_choose -4 x=3 r=18
>   item -3 type 1
>   reject 0  collide 1  ftotal 17  flocal 1
>  crush_bucket_choose -4 x=3 r=19
>   item -2 type 1
>   reject 0  collide 1  ftotal 18  flocal 1
>  crush_bucket_choose -4 x=3 r=20
>   item -2 type 1
>   reject 0  collide 1  ftotal 19  flocal 1
>  crush_bucket_choose -4 x=3 r=21
>   item -3 type 1
>   reject 0  collide 1  ftotal 20  flocal 1
>  crush_bucket_choose -4 x=3 r=22
>   item -3 type 1
>   reject 0  collide 1  ftotal 21  flocal 1
>  crush_bucket_choose -4 x=3 r=23
>   item -1 type 1
> CHOOSE bucket -1 x 3 outpos 2 numrep 3 tries 1 recurse_tries 0 local_retries 0 local_fallback_retries 0 parent_r 0 stable 0
>  crush_bucket_choose -1 x=3 r=2
>   item 0 type 0
> CHOOSE got 0
> CHOOSE returns 3
> CHOOSE got -1
> CHOOSE returns 3
>  rule 0 x 3 [8,4,0]
> 
> It looks that when choosing the third replica, we repeat a lot of tries which have already tried for the second one.
> Is this intended or maybe an issue?

It's because one bucket is weighted so much more heavily than the others.  
You're asking for something that's somewhat impossible: 3 replicas coming 
from 3 items with different weights.  Since we're sampling, if the weights 
are too skewed you'll run out of tries (r values) and it'll give up with 
only 2 results.

sage
