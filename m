From: flisky <yinjifeng@lianjia.com>
Subject: [EMG]incomplete pgs make RGW unusable
Date: Tue, 19 May 2015 08:06:01 +0800
Message-ID: <mjdupr$jtu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34202 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbbESAKI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 May 2015 20:10:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YuV6j-0002mX-3y
	for ceph-devel@vger.kernel.org; Tue, 19 May 2015 02:10:07 +0200
Received: from 118.186.147.8 ([118.186.147.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 02:10:05 +0200
Received: from yinjifeng by 118.186.147.8 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 02:10:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi core developers,

Sorry, I have to raise this from user list because there is no response.

I reformat the disks to increase osd journal size. During the process, I 
lost 9 pgs.

The incomplete pgs belong to the pool .rgw.buckets, which causes slow 
requests and make RGW unusable.
I have to restart the OSDs and RGWs time to time, to make RGW responsible.

The most scary things happen. I cannot recovery the incomplete pgs.

[force_create_pg](http://tracker.ceph.com/issues/10098) marks it a 
feature to handle this.

The [blog](https://ceph.com/community/incomplete-pgs-oh-my/) is not 
working, either.

And finally I give up the recovery, and use 'rados cppool' to copy our 
huge pool, it's STUCK...

I'm very frustrated, and very surprised that Ceph doesn't offer a way to 
just let the lost data lost.

Could anyone give any advise on this? Thanks!

Sincerely,

