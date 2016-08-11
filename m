From: Wido den Hollander <wido@42on.com>
Subject: Re: OSD crash after Upgrade to Jewel
Date: Thu, 11 Aug 2016 12:59:41 +0200 (CEST)
Message-ID: <259270165.2380.1470913181280@ox.pcextreme.nl>
References: <1722398688.2333.1470851528137@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:38574 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbcHKK74 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 06:59:56 -0400
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id A8EA840922
	for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2016 12:59:41 +0200 (CEST)
In-Reply-To: <1722398688.2333.1470851528137@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Adding some information here.

While most of the stuff is in the ticket, just as a reference.

The crash here is happening because the OSDs have a too small journal. After looking further these systems were by accident deployed with a 100M journal. Seems that somebody made a typo. Not all OSDs (864) had this 100M journal, 45 in total.

The OSDs were far behind on the OSDMaps, so I increased 'osd_map_message_max' on the MONs (!) to 5k so it would share more maps.

The OSDs were about 15k maps behind and wouldn't catch up, they were just stuck (that seems to be the true bug).

The 5k maps were to much for the 100M journal. So I flushed the journal and created a new journal which was 8G in size.

osd_map_message_max was decreased to 1k and that made the OSDs advance 1k maps at a time. However, I had to keep restarting them to make them catch up.

You can see this with:

$ ceph daemon osd.X status

It is stuck in 'prebooting' and stays there. You have to restart it again, it will advance 1k maps and stay there. Restart, etc. Painfull and time-consuming task.

This bug seems to be present in both Hammer and Jewel and is in the tracker: http://tracker.ceph.com/issues/16982

Wido

> Op 10 augustus 2016 om 19:52 schreef Wido den Hollander <wido@42on.com>:
> 
> 
> Hi,
> 
> I'm seeing this crash on multiple OSDs while upgrading to Jewel:
> 
>      0> 2016-08-10 19:41:40.686944 7f20d37f1700 -1 common/buffer.cc: In function 'void ceph::buffer::ptr::copy_in(unsigned int, unsigned int, const char*, bool)' thread 7f20d37f1700 time 2016-08-10 19:41:40.682052
> common/buffer.cc: 977: FAILED assert(o+l <= _len)
> 
> It started to happen when the OSDs came under load due to a node failing (hardware) which brought a lot of PGs in a unclean state.
> 
> I already filed a tracker issue for it: http://tracker.ceph.com/issues/16982
> 
> All machines are running Ubuntu 14.04 with the 4.4 kernel.
> 
> Wondering if somebody has seen this before. This cluster is very down at the moment..
> 
> 
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
