From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: crushmap problem
Date: Wed, 16 Mar 2011 17:24:27 -0700
Message-ID: <4D8154BB.3030008@hq.newdream.net>
References: <AANLkTimjPG41SSSFvCqEqVVqo9Z78=bnb8f51b3y7hd-@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45798 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab1CQAZq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2011 20:25:46 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8A81CC066
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2011 17:25:46 -0700 (PDT)
Received: from [10.0.1.162] (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by mail.hq.newdream.net (Postfix) with ESMTP id 84E74C065
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2011 17:25:46 -0700 (PDT)
In-Reply-To: <AANLkTimjPG41SSSFvCqEqVVqo9Z78=bnb8f51b3y7hd-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

  Hi,

This crushmap seems to be valid.  I'll look into it more tomorrow.

-Sam

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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

