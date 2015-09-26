From: Shinobu Kinjo <skinjo@redhat.com>
Subject: [ceph-users] occasional failure to unmap rbd
Date: Fri, 25 Sep 2015 22:54:41 -0400 (EDT)
Message-ID: <10495960.22183031.1443236081004.JavaMail.zimbra@redhat.com>
References: <56057393.5040203@commerceguys.com> <CAOi1vP_mHfYjtT+-eKxbvxgpPtgYoc+388oKbzC1=L-mU-euAA@mail.gmail.com> <5605793C.8030403@commerceguys.com> <1C5AFAFE-8302-4D33-B9B7-5A097F86BA27@schermer.cz> <560587E0.2070905@commerceguys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:42032 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbbIZCyl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Sep 2015 22:54:41 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t8Q2sfbs000635
	for <ceph-devel@vger.kernel.org>; Fri, 25 Sep 2015 22:54:41 -0400
In-Reply-To: <560587E0.2070905@commerceguys.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I think it's more helpful to put returned value in:

# ./src/krbd.cc
530       cerr << "rbd: sysfs write failed" << std::endl;

like:

530       cerr << "rbd: sysfs write failed (" << r << ")" << std::endl;

So that we exactly know what **write** complains about.
Because **write** has some return values in case of error.

What do you think?

Shinobu

----- Original Message -----
From: "Jeff Epstein" <jeff.epstein@commerceguys.com>
To: "Jan Schermer" <jan@schermer.cz>
Cc: ceph-users@lists.ceph.com
Sent: Saturday, September 26, 2015 2:44:00 AM
Subject: Re: [ceph-users] occasional failure to unmap rbd

On 09/25/2015 12:53 PM, Jan Schermer wrote:
> What are you looking for in lsof? Did you try looking for the major/minor number of the rbd device?
> Things that could hold the device are devicemapper, lvm, swraid and possibly many more, not sure if all that shows in lsof output...
>
I searched for the rbd's mounted block device name, of course, which 
didn't turn up anything. Just now I tried searching for the minor device 
number, but I didn't see anything obviously useful. lsof usually just 
shows processes, so if the the device is being held by a kernel module 
or inaccurate refcount, lsof wouldn't help.

Jeff
_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
