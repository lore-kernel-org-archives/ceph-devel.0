From: Sage Weil <sage@newdream.net>
Subject: Re: CRUSH. What wrong?
Date: Sun, 29 May 2011 20:54:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105292052300.25744@cobra.newdream.net>
References: <4DE24862.5080109@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35259 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab1E3DxD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 May 2011 23:53:03 -0400
In-Reply-To: <4DE24862.5080109@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hi Fyodor,

The problem is your rules:

On Sun, 29 May 2011, Fyodor Ustinov wrote:
> # rules
> rule data {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take root
>         step choose firstn 0 type rack

This is giving you N _racks_.  You probably want

         step chooseleaf firstn 0 type rack

which will give you N devices from distinct racks.

BTW, you can verify that the map is behaving with something like

$ crushtool -i crushfile --test
devices weights (hex): 
[10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000]
rule 0 (data), x = 0..9999
 device 0:      2391
 device 1:      2446
 device 2:      2338
 device 3:      2332
 device 4:      2360
 device 5:      2450
 device 6:      0
 device 7:      1368
 device 8:      1460
 device 9:      1446
 device 10:     1409
 num results 2: 10000
rule 1 (metadata), x = 0..9999
 device 0:      2391
 device 1:      2446
 device 2:      2338
 device 3:      2332
 device 4:      2360
 device 5:      2450
 device 6:      0
 device 7:      1368
 device 8:      1460
 device 9:      1446
 device 10:     1409
 num results 2: 10000
rule 2 (rbd), x = 0..9999
 device 0:      2391
 device 1:      2446
 device 2:      2338
 device 3:      2332
 device 4:      2360
 device 5:      2450
 device 6:      0
 device 7:      1368
 device 8:      1460
 device 9:      1446
 device 10:     1409
 num results 2: 10000

(That's with 'choose' changed to 'chooseleaf'.  Your current map gives 0 
objects on every device.)

Cheers-
sage
