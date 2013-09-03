From: Sage Weil <sage@inktank.com>
Subject: Re: Developing osd plugins
Date: Tue, 3 Sep 2013 09:31:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309030930490.25704@cobra.newdream.net>
References: <CA+CdmLZ1HKHWAw4+AG15Ud1yAEBF+DvUaP+6KwCexpXx8yBWJQ@mail.gmail.com> <alpine.DEB.2.00.1309030734100.32126@cobra.newdream.net> <CA+CdmLa-7GNtW1CL1-TCZwBzmsYpiTy2sy6aFWkO=uaoa_LsJw@mail.gmail.com>
 <alpine.DEB.2.00.1309030929380.1073@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33243 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760164Ab3ICQbF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 12:31:05 -0400
In-Reply-To: <alpine.DEB.2.00.1309030929380.1073@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Krasnianskiy <oleg.krasnianskiy@gmail.com>
Cc: ceph-devel@vger.kernel.org

[oops, added back ceph-devel to cc list]

On Tue, 3 Sep 2013, Sage Weil wrote:

> On Tue, 3 Sep 2013, Oleg Krasnianskiy wrote:
> > Thanks, the problem was I exported the wrong symbol - class_init
> > instead of the __cls_init.
> > But I have one more question - what's the proper way to deploy the plugin?
> > Should I copy the .so to every host and then restart all osds one by one?
> 
> You need to handle the distribution of the .so, yes.  However, you do not 
> need to restart the OSD--it will be loaded on demand the first time it is 
> used.  Note, however, that it won't be reloaded of the .so file changes; 
> in that case you'll need to restart the daemon.
> 
> sage
> 
