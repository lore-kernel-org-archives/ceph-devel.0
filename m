From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: CRUSH. What wrong?
Date: Mon, 30 May 2011 09:50:42 +0000
Message-ID: <1306749042.1527.8.camel@localhost>
References: <4DE24862.5080109@ufm.su>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:9790 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752256Ab1E3Buc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 May 2011 21:50:32 -0400
In-Reply-To: <4DE24862.5080109@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ,
Could you attach the detail reproducing steps?
Are you using the following steps to get crush.new.txt and base on it to
modify new crush ?
$ ceph osd getcrushmap -o crush.new
$ crushtool -d crush.new -o crush.new.txt

Maybe , you could refer to the following commands to create crush.new
file,for instance:
$ crushtool --num_osds 8 -o crush.new --build host straw 8 rack straw 8
root straw 0
$ crushtool -d crush.new -o crush.new.txt

I had filed two bug at :
http://tracker.newdream.net/issues/1016
http://tracker.newdream.net/issues/1017


Jeff ,Wu


On Sun, 2011-05-29 at 21:21 +0800, Fyodor Ustinov wrote:
> Hi!
> 
> Now, I made an attempt to create my own CRUSH.
> 
> After I applied it to existing cluster everything stopped (rebalance not 
> start, unable to mount cluster)
> 
> "Ok", I said and created new cluster with this crush.
> 
> Cluster turned out as the real thing. But id did not work (initial 
> scrubbing not start, unable to mount).
> 
> What I did wrong?
> 
> My crush map:
> 
> # begin crush map
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
> device 8 device8
> device 9 device9
> device 10 device10
> 
> # types
> type 0 device
> type 1 host
> type 2 rack
> type 3 root
> 
> # buckets
> host host0 {
>          id -1           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item device0 weight 3.842
> }
> host host1 {
>          id -2           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item device1 weight 3.842
> }
> host host2 {
>          id -3           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item device2 weight 3.842
> }
> host host3 {
>          id -4           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item device3 weight 3.842
> }
> host host4 {
>          id -5           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item device4 weight 3.842
> }
> host host5 {
>          id -6           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item device5 weight 3.842
> }
> host host6 {
>          id -7           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
> }
> host host7 {
>          id -8           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item device7 weight 3.842
>          item device8 weight 3.905
>          item device9 weight 3.905
>          item device10 weight 3.905
> }
> rack rack0 {
>          id -9           # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item host0 weight 3.844
> }
> rack rack1 {
>          id -10          # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item host1 weight 3.844
> }
> rack rack2 {
>          id -11          # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item host2 weight 3.842
> }
> rack rack3 {
>          id -12          # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item host3 weight 3.842
> }
> rack rack4 {
>          id -13          # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item host4 weight 3.842
> }
> rack rack5 {
>          id -14          # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item host5 weight 3.842
> }
> rack rack6 {
>          id -15          # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item host6 weight 3.842
> }
> rack rack7 {
>          id -16          # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item host7 weight 15.557
> }
> root root {
>          id -17          # do not change unnecessarily
>          alg straw
>          hash 0  # rjenkins1
>          item rack0 weight 3.844
>          item rack1 weight 3.844
>          item rack2 weight 3.842
>          item rack3 weight 3.842
>          item rack4 weight 3.842
>          item rack5 weight 3.842
>          item rack6 weight 3.842
>          item rack7 weight 15.557
> }
> 
> # rules
> rule data {
>          ruleset 0
>          type replicated
>          min_size 1
>          max_size 10
>          step take root
>          step choose firstn 0 type rack
>          step emit
> }
> rule metadata {
>          ruleset 1
>          type replicated
>          min_size 1
>          max_size 10
>          step take root
>          step choose firstn 0 type rack
>          step emit
> }
> rule rbd {
>          ruleset 2
>          type replicated
>          min_size 1
>          max_size 10
>          step take root
>          step choose firstn 0 type rack
>          step emit
> }
> 
> # end crush map
> 
> WBR,
>      Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

