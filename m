From: Sage Weil <sage@newdream.net>
Subject: Re: How to notify an object watched by client via ceph class API
Date: Thu, 5 Feb 2015 00:51:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502050047370.27042@cobra.newdream.net>
References: <CA+U0gVi=kLnWGbb_Ea=xNGLaRdoxhxGW0HPFT9HUACnHZBM_wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50614 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746AbbBEIvA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 03:51:00 -0500
In-Reply-To: <CA+U0gVi=kLnWGbb_Ea=xNGLaRdoxhxGW0HPFT9HUACnHZBM_wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Chen <kernel.org.gnu@gmail.com>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

On Thu, 5 Feb 2015, Dennis Chen wrote:
> Hello,
> 
> Just as the subject indicated, how can I notify an object watcher
> within a class '.so' loaded into osd deamon. I checked the code and
> found the below op code defined already:CEPH_OSD_OP_NOTIFY, but this
> op code is not used by existing ceph class api, I guest there must be
> a simple solution to resolve this if I don't want to make the osd to
> play client role the same time.
> 
> Anyone can help me out this?
> 

The watch/notify does not rely on rados classes, e.g.:

rados -p rbd create foo
rados -p rbd watch foo &
rados -p rbd notify foo hello

The notify is just a normal librados operation, and most of those can be 
called from classes, but it normally blocks for some period until the 
others acknowledge.  If it were wired up in objclass.h you could probably 
initiate the async notify but there would be no way to check whether it 
ever arrived, so I'm not sure it would be useful.

What are you trying to accomplish?

sage
