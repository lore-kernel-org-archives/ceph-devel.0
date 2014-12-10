From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: Three times retries on write
Date: Wed, 10 Dec 2014 07:46:40 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489680EA@SHSMSX101.ccr.corp.intel.com>
References: <06E7D85B3BA36C4DB207FEDE871C53489677C5@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1412080631390.18213@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C5348967DB3@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10389 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbaLJHrE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 02:47:04 -0500
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348967DB3@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Got this fixed. This is because of the following assertion in the function 'eval_repop' of the base tier code.

assert(entity_name_t::TYPE_OSD != m->get_connection()->peer_type);

When moving to proxy write, this assertion doesn't hold any more. After removing it, the problem is fixed now.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wang, Zhiqiang
Sent: Tuesday, December 9, 2014 11:38 AM
To: Sage Weil
Cc: ceph-devel@vger.kernel.org
Subject: RE: Three times retries on write

Hi Sage,

I aslo set debug ms to 20. The log file is in https://drive.google.com/file/d/0B1aauR3uQ9ECTjk1TUJ0OHMzQVk/view?usp=sharing

Seems like the problem is in the pipe.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Monday, December 8, 2014 10:32 PM
To: Wang, Zhiqiang
Cc: ceph-devel@vger.kernel.org
Subject: Re: Three times retries on write

On Mon, 8 Dec 2014, Wang, Zhiqiang wrote:
> Hi all,
> 
> I wrote some proxy write code and is doing testing now. I use 'rados put' to write a full object. I notice that every time when the cache tier OSD sends the object to the base tier OSD through the Objecter::mutate interface, it retries 3 times. Looks like the 3rd try is a success. I verified the object in the base tier. It is what I wrote. The logs are showing below. Any hints on what is causing this?
> 
> 2014-12-08 15:37:28.721769 7f4ac5764700  0 osd.22 pg_epoch: 27412 
> pg[45.0( v 26979'3108 (0'0,26979'3108] local-les=27409 n=28 ec=25839 
> les/c 27409/27409 27408/27408/27408) [22,16] r=0 lpr=27408
> crt=26979'3102 lcod 0'0 mlcod 0'0 active+clean] do_proxy_write Start 
> proxy write for osd_op(client.127754.0:1 
> rb.0.17f51.6b8b4567.0000000008d  [writefull 0~4194304] 45.42df800
> ondisk+write+known_if_redirected e27412) v4
> 2014-12-08 15:37:28.721951 7f4ac5764700  1 -- :/2913 -->
> 10.44.44.6:6835/3356 -- osd_op(osd.22.27408:1 
> rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] 14.42df800
> ack+ondisk+write+ignore_cache+ignore_overlay+map_snap_clone+known_if_r
> edirected e27412) v4 -- ?+0 0x3a937000 con 0x3b94c840
> 2014-12-08 15:37:28.901912 7f4ad7788700  1 -- 10.44.44.6:0/2913 -->
> 10.44.44.6:6835/3356 -- osd_op(osd.22.27408:1 
> rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] 14.42df800
> RETRY=1
> ack+ondisk+retry+write+ignore_cache+ignore_overlay+map_snap_clone+know
> n_if_redirected e27412) v4 -- ?+0 0x3a937000 con 0x3b973dc0
> 2014-12-08 15:37:33.071380 7f4ade796700  1 -- 10.44.44.6:0/2913 -->
> 10.44.44.5:6801/62721 -- osd_op(osd.22.27408:1 
> rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] 14.42df800
> RETRY=2
> ack+ondisk+retry+write+ignore_cache+ignore_overlay+map_snap_clone+know
> n_if_redirected e27413) v4 -- ?+0 0x3b7b3a00 con 0x3b473160
> 2014-12-08 15:37:34.259670 7f4ade796700  1 -- 10.44.44.6:0/2913 -->
> 10.44.44.6:6803/6847 -- osd_op(osd.22.27408:1 
> rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] 14.42df800
> RETRY=3
> ack+ondisk+retry+write+ignore_cache+ignore_overlay+map_snap_clone+know
> n_if_redirected e27414) v4 -- ?+0 0x3a937000 con 0x3ac0d840
> 2014-12-08 15:37:35.443525 7f4ab49eb700  1 -- 10.44.44.6:0/2913 <==
> osd.13 10.44.44.6:6803/6847 1 ==== osd_op_reply(1 
> rb.0.17f51.6b8b4567.0000000008dd [writefull 0~4194304] v27412'10764
> uv58186 ondisk = 0) v7 ==== 207+0+0 (2066479387 0 0) 0x3a796840 con
> 0x3ac0d840

That is very strange (and concerning)!  Can you reproduce this with

 debug objecter = 20

on the OSD?  That should tell us why it is resending.

sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
