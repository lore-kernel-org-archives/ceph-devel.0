From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: crushmap problem
Date: Thu, 17 Mar 2011 16:12:14 -0700
Message-ID: <4D82954E.4050508@hq.newdream.net>
References: <AANLkTimjPG41SSSFvCqEqVVqo9Z78=bnb8f51b3y7hd-@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50962 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab1CQXNe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2011 19:13:34 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8E4BCC06F
	for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2011 16:13:33 -0700 (PDT)
Received: from [10.0.1.162] (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8AFEDC065
	for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2011 16:13:33 -0700 (PDT)
In-Reply-To: <AANLkTimjPG41SSSFvCqEqVVqo9Z78=bnb8f51b3y7hd-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

  Actually, the problem does seem to be in the crushmap:

On 03/16/2011 03:08 PM, Ben De Luca wrote:
> Hi there, am setting up a new ceph cluster.
> I wondered if there was a problem with the following crushmap, my
> clients immediately lock up when I use this.
> I have 4 nodes each with 2 disks and 2 osd's
>
>
> # devices
> device 0 device0
> device 1 device1
> device 2 device2
> device 3 device3
> device 4 device4
> device 5 device5
> device 6 device6
> device 7 device7
> # types
> type 0 device
> type 1 host
> type 2 root
> # buckets
> host host0 {
> id -1 # do not change unnecessarily
> alg straw
> hash 0 # rjenkins1
> item device0 weight 1.000
> item device1 weight 1.000
> }
> host host1 {
> id -2 # do not change unnecessarily
> alg straw
> hash 0 # rjenkins1
> item device2 weight 1.000
> item device3 weight 1.000
> }
> host host2 {
> id -3 # do not change unnecessarily
> alg straw
> hash 0 # rjenkins1
> item device4 weight 1.000
> item device5 weight 1.000
> }
> host host3 {
> id -4 # do not change unnecessarily
> alg straw
> hash 0 # rjenkins1
> item device6 weight 1.000
> item device7 weight 1.000
> }
> root root {
> id -5 # do not change unnecessarily
> alg straw
> hash 0 # rjenkins1
> item host0 weight 2.000
> item host1 weight 2.000
> item host2 weight 2.000
> item host3 weight 2.000
> }
> # rules
> rule data {
> ruleset 1
> type replicated
> min_size 2
> max_size 2
> step take root
> step chooseleaf firstn 0 type host
> step emit
> }
> # end crush map
Here, ruleset 1 indicates that this rule applies only to pools with that 
ruleset.  e.g.

samuelj@slider:~/ceph/src$ ./ceph osd dump -o -
2011-03-17 16:27:40.889793 mon <- [osd,dump]
2011-03-17 16:27:40.890768 mon2 -> 'dumped osdmap epoch 5' (0)
epoch 5
fsid 45f39057-30cb-fc3c-8184-9aae0a07897b
created 2011-03-17 16:10:16.479195
modifed 2011-03-17 16:10:27.458120
flags

pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash 
rjenkins pg_num 8 pgp_num 8 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
pg_pool 1 'metadata' pg_pool(rep pg_size 2 crush_ruleset 1 object_hash 
rjenkins pg_num 8 pgp_num 8 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
pg_pool 2 'casdata' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash 
rjenkins pg_num 8 pgp_num 8 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
pg_pool 3 'rbd' pg_pool(rep pg_size 2 crush_ruleset 3 object_hash 
rjenkins pg_num 8 pgp_num 8 lpg_num 2 lpgp_num 2 last_change 1 owner 0)

max_osd 2
osd0 up   in  weight 1 up_from 2 up_thru 3 down_at 0 last_clean_interval 
0-0 10.0.1.204:6800/13842 10.0.1.204:6801/13842 10.0.1.204:6802/13842
osd1 up   in  weight 1 up_from 3 up_thru 3 down_at 0 last_clean_interval 
0-0 10.0.1.204:6803/14185 10.0.1.204:6804/14185 10.0.1.204:6805/14185

Here, only pool 1 has been assigned to use this rule (crush_ruleset is 
1).  A quick fix would be to duplicate that rule for rulesets 0,2, and 3.

Sorry for the confusion!
-Sam

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

