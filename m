From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Tue, 08 Jan 2013 09:44:14 +0100
Message-ID: <50EBDC5E.3090207@ledeuns.net>
References: <50E81A3D.5070100@ledeuns.net> <50EB0518.9050304@ledeuns.net> <E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:39723 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784Ab3AHIoM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 03:44:12 -0500
Received: from [IPv6:2a01:728:103:1::21] (unknown [IPv6:2a01:728:103:1::21])
	by mail.ledeuns.net (Postfix) with ESMTPSA id 6E5D993271
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 09:44:09 +0100 (CET)
In-Reply-To: <E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I tried to upgrade to 0.56.1 this morning as it could help with 
recovery. No luck so far...

> What's wrong with your primary OSD?

I don't know what's really wrong. The disk seems fine.

> In general they shouldn't really be crashing that frequently and if you've got a new bug we'd like to diagnose and fix it.

I don't know if it is hardware related (it seems not as I tested each 
parts). Then it might be an issue with btrfs (linux 3.5) or Ceph or 
another software part.
However, I'm willing to resolve this issue. Just tell me what you need, 
what I can do.

> If that can't be done (or it's a hardware failure or something), you can mark the OSD lost, but that might lose data and then you will be sad.

Well, if I must have a loss I'd really like to try everything before :)

Denis
