From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: Re: Trigger to create PGs ?
Date: Mon, 04 Feb 2013 18:36:08 -0800 (PST)
Message-ID: <20130204.183608.236197715.yasu@soe.ucsc.edu>
References: <20130204.145038.210467743.yasu@soe.ucsc.edu>
	<20130204.152624.157931698.yasu@soe.ucsc.edu>
	<alpine.DEB.2.00.1302041817040.19233@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58470 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3BECgL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 21:36:11 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa10so2096158pad.27
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 18:36:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302041817040.19233@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com
Cc: ceph-devel@vger.kernel.org


Thanks Sage, it instantly fixed the problem.
:)

regards,
Yasu

From: Sage Weil <sage@inktank.com>
Subject: Re: Trigger to create PGs ?
Date: Mon, 4 Feb 2013 18:19:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302041817040.19233@cobra.newdream.net>

> All of the stuck pgs are in pool 2.  My guess is that that pool is 
> referncing a broken crush rule. 
> 
> Your CRUSH map has min and max_size of 3 for all of the rules; it should 
> be min 1 and max 10.  Probably the RBD pool is set to 3 replicas, which 
> means it matches no existing CRUSH rule and you get no OSDs.  You can fix 
> the CRUSH rules (that is a good idea anyway), or also change the pool 2 
> (rbd) to 3x replication:
> 
> ceph osd pool set rbd size 3
> 
> sage
> 
> 
> On Mon, 4 Feb 2013, Yasuhiro Ohara wrote:
>> 
>> Umm, I mean, my system stuck like:
>> 
>>    health HEALTH_WARN 1088 pgs stuck inactive; 1088 pgs stuck unclean
>>    monmap e1: 5 mons at {0=128.114.52.59:6789/0,1=128.114.52.67:6789/0,2=128.114.52.68:6789/0,3=128.114.52.69:6789/0,4=128.114.52.70:6789/0}, election epoch 72, quorum 0,1,2,3,4 0,1,2,3,4
>>    osdmap e295: 16 osds: 16 up, 16 in
>>     pgmap v83184: 3264 pgs: 1088 creating, 2176 active+clean; 672 GB data, 2042 GB used, 5107 GB / 7452 GB avail
>>    mdsmap e20: 1/1/1 up {0=1=up:active}, 4 up:standby
>> 
>> and I am asking how to bring it to HEALTHY state.
>> 
>> regards,
>> Yasu
>> 
>> From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
>> Subject: Trigger to create PGs ?
>> Date: Mon, 04 Feb 2013 14:50:38 -0800 (PST)
>> Message-ID: <20130204.145038.210467743.yasu@soe.ucsc.edu>
>> 
>> > 
>> > Hi,
>> > 
>> > I happened to have an incorrect crush map in the start-up of
>> > my system, but even after fixing it manually, the PGs do not
>> > seem to be created properly. Is there any way to trigger the
>> > system to start creating the PGs again ?
>> > 
>> > Here's my configurations:
>> > ceph.conf: http://pastebin.com/EwwdQrf9
>> > crush map: http://pastebin.com/UYNFvvQx
>> > ceph osd tree: http://pastebin.com/u2Z4Hppn
>> > ceph pg dump: http://pastebin.com/JfE146WJ
>> > 
>> > FYI, in the first, I had mistakenly osd.0 in all host clauses.
>> > 
>> > regards,
>> > Yasu
>> > 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
