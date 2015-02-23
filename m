From: Mark Nelson <mnelson@redhat.com>
Subject: Re: -fno-omit-frame-pointer
Date: Mon, 23 Feb 2015 15:35:19 -0600
Message-ID: <54EB9D17.7090509@redhat.com>
References: <alpine.DEB.2.00.1502211252520.27009@cobra.newdream.net> <54E91449.4090000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56557 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbbBWVfX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Feb 2015 16:35:23 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1NLZM1Y009298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Mon, 23 Feb 2015 16:35:22 -0500
In-Reply-To: <54E91449.4090000@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 02/21/2015 05:27 PM, Mark Nelson wrote:
> I've still had the best luck using DWARF though.  I was able to get much
> better stack traces with it.  A semi-modern kernel with libunwind
> support in perf is needed though.  I just checked one of our RHEL7 and
> it sadly doesn't look like they have it linked.  We really should hassle
> them to get this in.  Perf on our Ubuntu 14.04 does use libunwind,
> primarily due to the kernel bug we submitted:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1248289

FWIW, I followed up with the RHEL7 kernel guys who pointed out that 
while RHEL 7.0 doesn't have dwarf support in perf, 7.1 does, and it's 
using what appears to be a better libdw unwind implementation:

http://lwn.net/Articles/579508/

>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
