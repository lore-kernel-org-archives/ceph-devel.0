From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph 0.42: Cannot make RPM from spec-file (unpackaged file
 ceph-dencoder)
Date: Tue, 21 Feb 2012 11:07:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202211107120.30694@cobra.newdream.net>
References: <4008345.82nISvLeLu@pc10>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41625 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab2BUTH1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 14:07:27 -0500
In-Reply-To: <4008345.82nISvLeLu@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 21 Feb 2012, Guido Winkelmann wrote:
> Hi,
> 
> With Ceph 0.42, I am unable to create an RPM from supplied spec-file.
> 
> When running rpmbuild -ba ceph-0.42/ceph.spec, the command fails at the end 
> with this:
> 
> Checking for unpackaged file(s): /usr/lib/rpm/check-files 
> /root/rpmbuild/BUILDROOT/ceph-0.42-6.fc14.x86_64
> error: Installed (but unpackaged) file(s) found:
>    /usr/bin/ceph-dencoder
> 
> 
> RPM build errors:
>     Installed (but unpackaged) file(s) found:
>    /usr/bin/ceph-dencoder
> 
> I could get it to build anyway by including the line
> 
> %{_bindir}/ceph-dencoder
> 
> in the files section of the spec file.

Adding ceph-dencoder (and man page) to the .deb and .rpm now.  Thanks!

sage


> 
> Regards,
> 
> 	Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
