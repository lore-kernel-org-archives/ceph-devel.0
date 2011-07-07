From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ceph didn't migrate data when I kill one osd daemon
Date: Thu, 07 Jul 2011 13:15:42 +0200
Message-ID: <1310037342.2504.2.camel@wido-laptop.pcextreme.nl>
References: <CADF7qQWnfLKkAFbWeq2FwGD1sRRZiqzwikV+urhKOVbRM4B7kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:60902 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713Ab1GGLPo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2011 07:15:44 -0400
In-Reply-To: <CADF7qQWnfLKkAFbWeq2FwGD1sRRZiqzwikV+urhKOVbRM4B7kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: AnnyRen <annyren6@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Anny,

On Thu, 2011-07-07 at 17:35 +0800, AnnyRen wrote:
> Hi all,
> 
> I have one questions about osd degraded.
> 
> My environment was set up with 3 mon, 2 mds and 25 osd, all daemon are
> running on physical machines.
> Ceph Version:  0.30
> File system format: EXT4
> 
> Q1.   When I'm testing osd stability, I kill an osd daemon (osd2) to
> observe the behavior of data migration.
>     For all I know, I could see the pg degraded ratio down to zero,
> and all pgs become active+clean.
>     but Ceph file system didn't migrate the data on the osd (which I
> already killed its daemon) to other osds.
>     The degraded ratio still remain at 4.xxx%.
>     After then, I run "cosd -i 2 -c /etc/ceph/ceph.conf"and then run "ceph -w",
>     I saw all pgs suddenly become active+clean.
> 
>   Could anyone tell me why Ceph didn't migrate data when I kill one osd daemon?

How long did you wait? The default configuration is that a OSD has to be
down for at least 300 sec before it gets marked "out".

When you kill the OSD it will be marked "down" within a few seconds, but
that won't trigger any data migration, a OSD has to be marked "out" do
to that.

Wido

> 
> 
> Thanks a lot~  ^__^
> 
> Best Regards,
> Anny


