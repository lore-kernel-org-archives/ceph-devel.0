From: Sage Weil <sage@newdream.net>
Subject: Re: make check bot on pause
Date: Sun, 18 Jan 2015 16:51:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501181651050.8527@cobra.newdream.net>
References: <54BC3D7F.8030901@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42859 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbbASAvT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jan 2015 19:51:19 -0500
In-Reply-To: <54BC3D7F.8030901@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 19 Jan 2015, Loic Dachary wrote:
> Hi Ceph,
> 
> Master fails make check at the moment and the make check bot that 
> reports to github was paused to avoid sending false negative.

https://github.com/ceph/ceph/pull/3397

fixes it.  Can someone +1?

sage
