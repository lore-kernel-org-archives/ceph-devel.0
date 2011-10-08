From: Martin Mailand <martin@tuxadero.com>
Subject: Re: OSD::disk_tp timeout
Date: Sat, 08 Oct 2011 23:04:27 +0200
Message-ID: <4E90BADB.2000908@tuxadero.com>
References: <CAO47_-_x3QqP4qmTUAFB5SrObaBuzaJUa4dh+p+mdTHzKGeojg@mail.gmail.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:48911 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab1JHVEm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Oct 2011 17:04:42 -0400
In-Reply-To: <CAO47_-_x3QqP4qmTUAFB5SrObaBuzaJUa4dh+p+mdTHzKGeojg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

Hi Christian,
if I remember correctly you are using ceph with a qemu-kvm setup?

After the last update of ceph, the load average on the osd was doubled,
the performance of the kvm machines became bad.

The really weird thing is, the cluster "needs" around 30 mins to get 
into this state. After I restart the osd's everything is fine, than 
after a while the load of the osd nodes is building up. Most of the load 
is produced by btrfs kernel processes in the deferred state.

Not sure if I have the same problem as you, as I do not get any timeouts.

Best Regards,
  martin

Christian Brunner schrieb:
> Hi,
> 
> I've upgraded ceph from 0.32 to 0.36 yesterday. Now I have a totaly
> screwed ceph cluster. :(
> 
> What bugs me most is the fact, that OSDs become unresponsive
> frequently. The process is eating a lot of cpu and I can see the
> following messages in the log:
> 
> Oct  8 22:30:05 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct  8 22:30:10 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct  8 22:30:15 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct  8 22:30:20 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct  8 22:30:25 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct  8 22:30:30 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> 
> Do you have any idea, what to do about that?
> 
> Regards,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
