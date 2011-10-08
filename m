From: Sage Weil <sage@newdream.net>
Subject: Re: OSD::disk_tp timeout
Date: Sat, 8 Oct 2011 14:28:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110081427160.26432@cobra.newdream.net>
References: <CAO47_-_x3QqP4qmTUAFB5SrObaBuzaJUa4dh+p+mdTHzKGeojg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1413756941-1318109325=:26432"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51455 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab1JHV2s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Oct 2011 17:28:48 -0400
In-Reply-To: <CAO47_-_x3QqP4qmTUAFB5SrObaBuzaJUa4dh+p+mdTHzKGeojg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1413756941-1318109325=:26432
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Christian,

On Sat, 8 Oct 2011, Christian Brunner wrote:
> Hi,
>=20
> I've upgraded ceph from 0.32 to 0.36 yesterday. Now I have a totaly
> screwed ceph cluster. :(
>=20
> What bugs me most is the fact, that OSDs become unresponsive
> frequently. The process is eating a lot of cpu and I can see the

What version of btrfs are you running?  This sound a bit like the bug=20
fixed by this patch:

http://www.spinics.net/lists/linux-btrfs/msg12627.html

(That was just merged into mainline this week.)

> following messages in the log:
>=20
> Oct =A08 22:30:05 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct =A08 22:30:10 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct =A08 22:30:15 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct =A08 22:30:20 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct =A08 22:30:25 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
> Oct =A08 22:30:30 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
>=20
> Do you have any idea, what to do about that?

Those messages just mean that a thread in the disk threadpool (which is=20
doing all the writes to btrfs) is blocked/stopped.

sage
--557981400-1413756941-1318109325=:26432--
