From: Sage Weil <sage@newdream.net>
Subject: Re: CRUSH
Date: Mon, 23 May 2011 15:09:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105231508350.30953@cobra.newdream.net>
References: <4DDA8933.4070504@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42971 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab1EWWI1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2011 18:08:27 -0400
In-Reply-To: <4DDA8933.4070504@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Mon, 23 May 2011, Fyodor Ustinov wrote:
> Hi!
> 
> Two questions.
> 
> 1-st. As I understand it - any usable changes of CRUSH map on active cluster
> can't destruct data? In the worst case (for example, I managed to put two osd
> in one rack, and now I have two copies of the data in a single rack) I get
> information about the degradation and this will be fixed automatically?

Right.

> 2-nd. How to correct edit crush map in case "rack"?
> 
> Let's say I have such a map:
> 
> device 0 device0
> device 1 device1
> device 2 device2
> device 3 device3
> device 4 device4
> 
> # types
> type 0 device
> type 1 host
> type 2 rack
> type 3 root
> 
> # buckets
> host host0 {
>         id -1
>         alg straw
>         hash 0  # rjenkins1
>         item device0 weight 1.000
> }
> ...
> host host4 {
>         id -5
>         alg straw
>         hash 0  # rjenkins1
>         item device4 weight 1.000
> }
> rack rack0 {
>         id -6
>         alg straw
>         hash 0  # rjenkins1
>         item host0 weight 1.000
> }
> ...
> rack rack4 {
>         id -10          # do not change unnecessarily
>         alg straw
>         hash 0  # rjenkins1
>         item host4 weight 1.000
> }
> root root {
>         id -11          # do not change unnecessarily
>         alg straw
>         hash 0  # rjenkins1
>         item rack0 weight 1.000
>         item rack1 weight 1.000
>         item rack2 weight 1.000
>         item rack3 weight 1.000
>         item rack4 weight 1.000
> }
> 
> # rules
> rule data {
>         ruleset 1
>         type replicated
>         min_size 2
>         max_size 2
>         step take root
>         step chooseleaf firstn 0 type host
>         step emit
> }
> 
> And now i want add one "rack" and add one "osd" to this rack. How should I
> deal with "id"?

If you leave the bucket id out, it will be automatically assigned the next 
unused value when you compile the map.  You do need to device the device 
explicitly, though.

sage
