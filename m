From: mark seger <mjseger@gmail.com>
Subject: Re: Slow ceph fs performance
Date: Fri, 28 Sep 2012 12:22:10 +0000 (UTC)
Message-ID: <loom.20120928T141701-295@post.gmane.org>
References: <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu> <5064E3D7.6080002@catalyst.net.nz> <5064E61E.2070800@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53033 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757860Ab2I1MZD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Sep 2012 08:25:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1THZcu-00042k-6d
	for ceph-devel@vger.kernel.org; Fri, 28 Sep 2012 14:25:04 +0200
Received: from 68-112-253-178.dhcp.oxfr.ma.charter.com ([68.112.253.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 28 Sep 2012 14:25:04 +0200
Received: from mjseger by 68-112-253-178.dhcp.oxfr.ma.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 28 Sep 2012 14:25:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I realize I'm a little late to this party but since collectl was mentioned 
thought I'd jump in.  ;)

Whenever I do any file system testing I also have a copy of collectl running in 
another window.
Just looking at total transfer times can end up taking you down 
the wrong path.
What is there are long stalls and very burst I/O?  could be a
starved resource or network issue that has nothing to do with he disks at all.

As for iostat, while you're certainly welcome to use it and I based the collectl
output display format on it, I'd highly recommend using iostat -x to see
wait/service times as those can be key to seeing what's happening.

Also, if you use collectl in stead with "-sD --home" you'll basically see the
output in a top-like format, making it real easy to see what's happening.
Further if you apply the right filter you can simply watch a single disk, line by
line w/o any pesky headers in your way.

-mark

