From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: FAILED =?UTF-8?Q?assert=28pg=5Fmap=2Ecount=28pgid=29=29?=
Date: Sat, 30 Jul 2011 13:31:57 -0700
Message-ID: <1e44384d33762d7db221ae71672843f1@hq.newdream.net>
References: <CAO47_-8BhGWAs_+=1Eegqt0o3qaNcM7ZHD=ecByYdmBb0Ei=-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:34735 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab1G3UcD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jul 2011 16:32:03 -0400
Received: from pochacco.sd.dreamhost.com (pochacco.sd.dreamhost.com [66.33.195.34])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 11A0017E518
	for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2011 13:32:02 -0700 (PDT)
In-Reply-To: <CAO47_-8BhGWAs_+=1Eegqt0o3qaNcM7ZHD=ecByYdmBb0Ei=-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Sat, 30 Jul 2011 20:44:28 +0200, Christian Brunner <chb@muc.de>
wrote:
> I shifted all my data to new filesystems. I did this, by using the
> ceph replication.
> 
> During that process other cosd processes (those who had to send the
> replication data) died several times. I was able to restart them, but
> I think this should not happen.
> 
> Here is one log message... (they all looked similar)
> 
> Regards,
> Christian
> 
> 
> 7fd23d66e700 osd13 9720 OSD::ms_handle_reset()
> 7fd23d66e700 osd13 9720 OSD::ms_handle_reset() s=0x3bc46e0
> 7fd23d66e700 osd13 9720 obc=0x204bcc0
> 7fd23d66e700 osd13 9720 removing watching session entity_name= from
> i-C7DBB69L.rbd/head(9181'620627 client2482097.0:2565
> wrlock_by=unknown0.0:0)
> osd/OSD.cc: In function 'PG* OSD::_lookup_lock_pg(pg_t)', in thread
> '0x7fd23d66e700'#012osd/OSD.cc: 1035: FAILED
> assert(pg_map.count(pgid))

Thanks for the report - I ran into the same thing last week, and it
should be fixed by 60ffc9dfeee9d7a3037647ee3a7c880dad3c59fa.

Josh
