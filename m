From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: log messages about inconsistent data
Date: Mon, 24 Jan 2011 10:40:20 -0800
Message-ID: <4D3DC794.5090604@hq.newdream.net>
References: <AANLkTin=qOdFjTWz8sMQ3hmUvwyrnmEd3_zo6LPbaK3r@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53155 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1AXSlo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jan 2011 13:41:44 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 33217C064
	for <ceph-devel@vger.kernel.org>; Mon, 24 Jan 2011 10:41:44 -0800 (PST)
Received: from [10.0.1.162] (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2F4BCC062
	for <ceph-devel@vger.kernel.org>; Mon, 24 Jan 2011 10:41:44 -0800 (PST)
In-Reply-To: <AANLkTin=qOdFjTWz8sMQ3hmUvwyrnmEd3_zo6LPbaK3r@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

  ceph pg repair <pgid> should cause the osd to repair the
inconsistency in most cases.  You can get the pgid by grepping
ceph pg dump for the inconsistent pg.
-Sam

On 01/23/2011 11:18 PM, Ravi Pinjala wrote:
> Do I need to be worried about this?
>
> 2011-01-23 23:12:06.328866   log 2011-01-23 23:12:05.316993 osd1
> 192.168.1.11:6801/9447 45 : [ERR] 1.1 scrub osd0 missing
> 10000017737.00000000/head
> 2011-01-23 23:12:06.328866   log 2011-01-23 23:12:05.317429 osd1
> 192.168.1.11:6801/9447 46 : [ERR] 1.1 scrub stat mismatch, got 7/136
> objects, 0/0 clones, 12356/8682277 bytes, 17/8550 kb.
> 2011-01-23 23:12:08.230768    pg v129643: 270 pgs: 262 active+clean, 8
> active+clean+inconsistent; 877 GB data, 1707 GB used, 1320 GB / 3036
> GB avail
>
> I would expect ceph to fix the inconsistent PGs at this point, but it
> just continues background scrubbing. Does inconsistent data get
> cleaned up automatically from other replicas, or is there something
> that I need to fix manually here?
>
> --Ravi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

