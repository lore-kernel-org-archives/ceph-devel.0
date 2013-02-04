From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: Re: Trigger to create PGs ?
Date: Mon, 04 Feb 2013 15:26:24 -0800 (PST)
Message-ID: <20130204.152624.157931698.yasu@soe.ucsc.edu>
References: <20130204.145038.210467743.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33705 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab3BDX0b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 18:26:31 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so739195pad.21
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 15:26:31 -0800 (PST)
In-Reply-To: <20130204.145038.210467743.yasu@soe.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Umm, I mean, my system stuck like:

   health HEALTH_WARN 1088 pgs stuck inactive; 1088 pgs stuck unclean
   monmap e1: 5 mons at {0=128.114.52.59:6789/0,1=128.114.52.67:6789/0,2=128.114.52.68:6789/0,3=128.114.52.69:6789/0,4=128.114.52.70:6789/0}, election epoch 72, quorum 0,1,2,3,4 0,1,2,3,4
   osdmap e295: 16 osds: 16 up, 16 in
    pgmap v83184: 3264 pgs: 1088 creating, 2176 active+clean; 672 GB data, 2042 GB used, 5107 GB / 7452 GB avail
   mdsmap e20: 1/1/1 up {0=1=up:active}, 4 up:standby

and I am asking how to bring it to HEALTHY state.

regards,
Yasu

From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: Trigger to create PGs ?
Date: Mon, 04 Feb 2013 14:50:38 -0800 (PST)
Message-ID: <20130204.145038.210467743.yasu@soe.ucsc.edu>

> 
> Hi,
> 
> I happened to have an incorrect crush map in the start-up of
> my system, but even after fixing it manually, the PGs do not
> seem to be created properly. Is there any way to trigger the
> system to start creating the PGs again ?
> 
> Here's my configurations:
> ceph.conf: http://pastebin.com/EwwdQrf9
> crush map: http://pastebin.com/UYNFvvQx
> ceph osd tree: http://pastebin.com/u2Z4Hppn
> ceph pg dump: http://pastebin.com/JfE146WJ
> 
> FYI, in the first, I had mistakenly osd.0 in all host clauses.
> 
> regards,
> Yasu
> 
