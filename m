From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Ceph on just two nodes being clients - reasonable?
Date: Wed, 19 Jan 2011 12:03:49 -0800
Message-ID: <20110119200349.GA753@dreamer>
References: <4D36BDF9.4030404@wpkg.org>
 <1295437286.2255.25.camel@wido-desktop>
 <4D36D5B3.4040601@wpkg.org>
 <AANLkTimHi64ZB5_AY1_eQu5abHB+S+bvcSShL_NE3Me0@mail.gmail.com>
 <AANLkTikFWk_p0=c1_o__2EmPS7t-=Ua68cLWGNS9badB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56929 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab1ASUDt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 15:03:49 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikFWk_p0=c1_o__2EmPS7t-=Ua68cLWGNS9badB@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Gregory Farnum <gregf@hq.newdream.net>, Tomasz Chmielewski <mangoo@wpkg.org>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Wed, Jan 19, 2011 at 09:55:27AM -0800, Colin McCabe wrote:
> If you knew what the maximum memory consumption for the daemons would
> be, you could use mlock to lock all those pages into memory (make them
> unswappable.) Then you could use rlimit to ensure that if the daemon
> ever tried to allocate more than that, it would be killed.

The classic nfs loopback mount deadlock is less about how much memory
the daemons are grabbing via malloc etc, and more about the buffer
cache management in kernel.

With a "loopback ceph", pressure from activity on the kernel ceph
client mountpoint might interact badly with the buffer cache the OSD
needs to work well, whether the OSD userspace tries to limit itself or
not.

It's one of those "it'll work until you have a bad day" things.

http://www.webservertalk.com/archive242-2007-10-2051163.html

https://bugzilla.redhat.com/show_bug.cgi?id=489889

http://lkml.org/lkml/2006/12/14/448

http://docs.google.com/viewer?a=v&q=cache:ONtIKJFSC7QJ:https://tao.truststc.org/Members/hweather/advanced_storage/Public%2520resources/network/nfs_user+nfs+loopback+deadlock+linux&hl=en&gl=us&pid=bl&srcid=ADGEESgpaVYYNoh2pmvPVQ9I_bpLLcoF3GJIMKavomIHNgTb-cbii6RVtWg28poJKdHBqQgKGXzVA2NOsC25FtWMP3yywTfNkX9N26IrKVIcVA9eRz6ZGBx1_Ur0JerUrfBQlPcmcBBz&sig=AHIEtbSjGX_hCVny345iFSq7WKBvxNZmIw
(slide 5)

-- 
:(){ :|:&};:
