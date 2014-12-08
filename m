From: Sage Weil <sage@newdream.net>
Subject: Re: Three times retries on write
Date: Mon, 8 Dec 2014 06:32:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412080631390.18213@cobra.newdream.net>
References: <06E7D85B3BA36C4DB207FEDE871C53489677C5@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43611 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbaLHOcH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Dec 2014 09:32:07 -0500
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C53489677C5@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 8 Dec 2014, Wang, Zhiqiang wrote:
> Hi all,
> 
> I wrote some proxy write code and is doing testing now. I use 'rados put' to write a full object. I notice that every time when the cache tier OSD sends the object to the base tier OSD through the Objecter::mutate interface, it retries 3 times. Looks like the 3rd try is a success. I verified the object in the base tier. It is what I wrote. The logs are showing below. Any hints on what is causing this?
> 
> 2014-12-08 15:37:28.721769 7f4ac5764700  0 osd.22 pg_epoch: 27412 pg[45.0( v 26979'3108 (0'0,26979'3108] local-les=27409 n=28 ec=25839 les/c 27409/27409 27408/27408/27408) [22,16] r=0 lpr=27408 crt=26979'3102 lcod 0'0 mlcod 0'0 active+clean] do_proxy_write Start proxy write for osd_op(client.127754.0:1 rb.0.17f51.6b8b4567.0000000008d  [writefull 0~4194304] 45.42df800 ondisk+write+known_if_redirected e27412) v4
> 2014-12-08 15:37:28.721951 7f4ac5764700  1 -- :/2913 --> 10.44.44.6:6835/3356 -- osd_op(osd.22.27408:1 rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] 14.42df800 ack+ondisk+write+ignore_cache+ignore_overlay+map_snap_clone+known_if_redirected e27412) v4 -- ?+0 0x3a937000 con 0x3b94c840
> 2014-12-08 15:37:28.901912 7f4ad7788700  1 -- 10.44.44.6:0/2913 --> 10.44.44.6:6835/3356 -- osd_op(osd.22.27408:1 rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] 14.42df800 RETRY=1 ack+ondisk+retry+write+ignore_cache+ignore_overlay+map_snap_clone+known_if_redirected e27412) v4 -- ?+0 0x3a937000 con 0x3b973dc0
> 2014-12-08 15:37:33.071380 7f4ade796700  1 -- 10.44.44.6:0/2913 --> 10.44.44.5:6801/62721 -- osd_op(osd.22.27408:1 rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] 14.42df800 RETRY=2 ack+ondisk+retry+write+ignore_cache+ignore_overlay+map_snap_clone+known_if_redirected e27413) v4 -- ?+0 0x3b7b3a00 con 0x3b473160
> 2014-12-08 15:37:34.259670 7f4ade796700  1 -- 10.44.44.6:0/2913 --> 10.44.44.6:6803/6847 -- osd_op(osd.22.27408:1 rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] 14.42df800 RETRY=3 ack+ondisk+retry+write+ignore_cache+ignore_overlay+map_snap_clone+known_if_redirected e27414) v4 -- ?+0 0x3a937000 con 0x3ac0d840
> 2014-12-08 15:37:35.443525 7f4ab49eb700  1 -- 10.44.44.6:0/2913 <== osd.13 10.44.44.6:6803/6847 1 ==== osd_op_reply(1 rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] v27412'10764 uv58186 ondisk = 0) v7 ==== 207+0+0 (2066479387 0 0) 0x3a796840 con 0x3ac0d840

That is very strange (and concerning)!  Can you reproduce this with

 debug objecter = 20

on the OSD?  That should tell us why it is resending.

sage

