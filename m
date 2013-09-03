From: Sage Weil <sage@inktank.com>
Subject: Re: Developing osd plugins
Date: Tue, 3 Sep 2013 07:35:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309030734100.32126@cobra.newdream.net>
References: <CA+CdmLZ1HKHWAw4+AG15Ud1yAEBF+DvUaP+6KwCexpXx8yBWJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60500 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3ICOfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 10:35:30 -0400
In-Reply-To: <CA+CdmLZ1HKHWAw4+AG15Ud1yAEBF+DvUaP+6KwCexpXx8yBWJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Krasnianskiy <oleg.krasnianskiy@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 2 Sep 2013, Oleg Krasnianskiy wrote:
> Hi all
> 
> I've been playing with osd plugins and I can't figure out how to load one.
> There is a loadclass.sh script but it seems quite outdated.
> I tried to copy .so to /usr/lib/rados-classes on all nodes and restart
> ceph cluster, but it didn't help, rados_exec returns -95, I haven't
> yet found the constant for the value.
> 
> Thanks for any help!

With 0.67.x and later the classes are now loaded on startup.  You should 
see an error message in /var/log/ceph/ceph-osd.*.log indicating why it was 
unable to load (usually a missing symbol or something).

sage
