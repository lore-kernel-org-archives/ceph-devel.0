From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: How are you dealing with hammer -> jewel upgrades?
Date: Wed, 11 May 2016 01:49:59 +0200
Message-ID: <573273A7.3040902@suse.cz>
References: <5731FE60.1090704@suse.cz>
 <CALqRxCxvKHSy=iGctuQq5fT=uTcEbR1jOLK5ZaRXiPovH_POjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44735 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbcEJXuD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 May 2016 19:50:03 -0400
In-Reply-To: <CALqRxCxvKHSy=iGctuQq5fT=uTcEbR1jOLK5ZaRXiPovH_POjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 05/10/2016 07:13 PM, Ken Dreyer wrote:
 > I was thinking about handling it in the OSD directly, particularly
 > since it already has the UID from --setuid.
 > http://tracker.ceph.com/issues/15733

Thanks, Ken, for reminding me of that tracker issue! I would rather 
implement the recursive ownership change for filestore-backed OSDs 
(assuming it's not a totally insane thing to be doing) in ceph-disk than 
in the OSD itself, for the following reasons.

ceph-disk already contains heuristics for determining the user/group to 
pass to ceph-osd [1] and "--setuser ceph --setgroup ceph" is hardcoded 
when starting ceph-osd via the systemd service [2].

If someone is passing a user/group other than "ceph" to the OSD via 
--setuser/--setgroup, they will be doing the same with ceph-disk (which 
also takes --setuser/--setgroup). Alternatively they will not be using 
ceph-disk at all.

Right?

Nathan

[1] 
https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/main.py#L951
[2] https://github.com/ceph/ceph/blob/master/systemd/ceph-osd%40.service#L12
