From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph.spec does not list libuuid as build time dependency
Date: Wed, 30 May 2012 08:34:25 -0700
Message-ID: <442126AE54DF4A6383382F62C044870D@inktank.com>
References: <3826033.JGMXqDMo11@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52133 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab2E3PeJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 11:34:09 -0400
Received: by pbbrp8 with SMTP id rp8so105441pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 08:34:08 -0700 (PDT)
In-Reply-To: <3826033.JGMXqDMo11@pc10>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

Thanks for the bug report. I created a tracker entry for it: 
http://tracker.newdream.net/issues/2484
I don't imagine it will take long for somebody who knows how to handle a .spec to fix. ;)
-Greg


On Friday, May 25, 2012 at 6:33 AM, Guido Winkelmann wrote:

> Hi,
> 
> Building ceph 0.47.2 from the included ceph.spec file fails:
> 
> checking for uuid_parse in -luuid... no
> configure: error: in `/home/guido/rpmbuild/BUILD/ceph-0.47.2':
> configure: error: libuuid not found
> See `config.log' for more details
> error: Bad exit status from /var/tmp/rpm-tmp.SdK9Ms (%build)
> 
> 
> RPM build errors:
> Bad exit status from /var/tmp/rpm-tmp.SdK9Ms (%build)
> 
> It works after installing libuuid-devel. Maybe that package ought to be listed 
> as a dependency in ceph.spec.
> 
> Regards,
> Guido
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



