From: Wido den Hollander <wido@widodh.nl>
Subject: Re: bobtail release candidates
Date: Mon, 26 Nov 2012 21:25:26 +0800
Message-ID: <50B36DC6.6000308@widodh.nl>
References: <alpine.DEB.2.00.1211250953400.23552@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49285 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab2KZNZc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 08:25:32 -0500
In-Reply-To: <alpine.DEB.2.00.1211250953400.23552@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 11/26/2012 01:57 AM, Sage Weil wrote:
> Hi all,
>
> There are automatic builds of the prerelease bobtail code available under
> the 'next' branch.
>
> For debs,
> 	http://ceph.com/docs/master/install/debian/#add-development-testing-packages
>
> For example, for Ubuntu 12.04 precise,
> 	http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/next/
>
> And RPMs for el6,
> 	http://gitbuilder.ceph.com/ceph-rpm-centos6-x86_64-basic/ref/next/RPMS/x86_64/
>
> Any testing and early feedback is greatly appreciated.
>

I just gave it a try on a small setup I'm toying with and noticed this 
after the package upgrade:

[599557.873110] init: /etc/init/ceph-mds.conf:9: Expected token
[599557.880938] init: /etc/init/ceph-osd.conf:9: Expected token
[599557.900269] init: /etc/init/ceph-mon.conf:9: Expected token

I'm not so familiar with upstart, but line 9 contains:

limit nofile 8192

I also got this message when starting my OSDs:

"No osd devs defined!"

I indeed haven't defined any devs, I've mounted the drives in the fstab.

Should I change this, or?

Wido


> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
