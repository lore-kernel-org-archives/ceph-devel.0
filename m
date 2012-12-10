From: Michael Morgan <mmorgan@dca.net>
Subject: Re: Errors attaching RBD image to a running VM
Date: Mon, 10 Dec 2012 15:48:50 -0500
Message-ID: <20121210204850.GC22300@staff.dca.net>
References: <20121207212247.GA12635@staff.dca.net> <50C272A0.9020506@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from staff.dca.net ([207.245.84.197]:35783 "EHLO staff.dca.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab2LJUsv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Dec 2012 15:48:51 -0500
Content-Disposition: inline
In-Reply-To: <50C272A0.9020506@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Dec 07, 2012 at 02:50:08PM -0800, Josh Durgin wrote:
> Yes, this is fixed in libvirt 0.9.12. There were a couple issues with
> properly escaping JSON and using a space instead of a semicolon with
> qemu's command parsing.
> 
> There are a couple more rbd-related bug fixes in later versions of
> libvirt, but you wouldn't hit those problems using OpenStack.

Thanks Josh! After building and installing libvirt 1.0.0 RPMs I unfortunately
seem to have taken a step backwards. Any use of network disks with
protocol="rbd" causes libvirt to bail with a dreaded 'No such file or
directory':

2012-12-10 20:08:37.203+0000: 16691: error : virFileOpenAs:1077 : failed to open file 'volumes/volume-485390a9-5a39-46c1-8434-872acbc645d8': No such file or directory
2012-12-10 20:08:37.203+0000: 16691: error : virStorageFileGetMetadataRecurse:962 : cannot open file 'volumes/volume-485390a9-5a39-46c1-8434-872acbc645d8': No such file or directory

I see there is a specific flag in the spec file for RBD support in this version
but I'm assuming that's more for pool support, correct? I get the same failures
either way. Is my disk XML now wrong with newer versions? Or perhaps is there a
recommended version of libvirt besides the latest 1.0.0?

I think I'm so close. Attaching volumes is pretty much the last piece of
functionality before I start just hammering this platform for stability. Thanks
again!

-Mike

--
Michael Morgan
Network Technician, DCANet
http://www.dca.net
mmorgan@dca.net
(888) 432-2638 x4723
