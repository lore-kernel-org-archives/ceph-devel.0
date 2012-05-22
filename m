From: Matt Weil <mweil@genome.wustl.edu>
Subject: build errors centos 6.2
Date: Tue, 22 May 2012 09:32:43 -0500
Message-ID: <4FBBA38B.2070203@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:37052 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754139Ab2EVOm2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 10:42:28 -0400
Received: from dhcp-10-0-7-38.gsc.wustl.edu (dhcp-10-0-7-38.gsc.wustl.edu [10.0.7.38])
	by gscsmtp.wustl.edu (Postfix) with ESMTPSA id C9B7F40152
	for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 09:32:43 -0500 (CDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> make[3]: *** [build/obj/simplexml.do] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[3]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src/libs3'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src'
> make: *** [all-recursive] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.9tq56B (%build)
>
>
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.9tq56B (%build)
