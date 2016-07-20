From: Dan Mick <dmick@redhat.com>
Subject: Re: dpkg-buildpackage failed on Ubuntu 16.4 -
 'override_dh_auto_build' failed
Date: Tue, 19 Jul 2016 20:23:28 -0700
Message-ID: <578EEEB0.6060706@redhat.com>
References: <DB5PR05MB1607AA6E7B4D217AA82E6DCDA9370@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbcGTDX3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jul 2016 23:23:29 -0400
In-Reply-To: <DB5PR05MB1607AA6E7B4D217AA82E6DCDA9370@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>, Ceph Development <ceph-devel@vger.kernel.org>

There's no detail of what went wrong in your excerpt.  All that says is
"something failed in the build".  You need to analyze the failure more
closely to figure out what actually went wrong.

On 07/19/2016 02:09 AM, Avner Ben Hanoch wrote:
> Hi all,
> 
> What is the recommended way to install my builds of ceph?
> 
> Following ceph instruction here http://docs.ceph.com/docs/master/install/build-ceph/ on a Ubuntu 16.4 machine, I got the following errors from dpkg-buildpackage -j32 (after 1-2 hours of waiting :-( ):
> 
>    dh_auto_build: make -j32 returned exit code 2
>    debian/rules:28: recipe for target 'override_dh_auto_build' failed
>    make[1]: *** [override_dh_auto_build] Error 2
>    make[1]: Leaving directory '/mnt/sdb/avnerb/ceph'
>    debian/rules:22: recipe for target 'build' failed
>    make: *** [build] Error 2
>    dpkg-buildpackage: error: debian/rules build gave error exit status 2
> 
> According to debian here https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=777814 this error might be related to gcc-5.
> 
> Anyhow, I only want to use the recommended way for installing my builds of ceph (Preferred one that can be installed over a cluster that was deployed using ceph-deploy)
> 
> I tried "make install" and encountered errors.
> dpkg-buildpackage also failed for me
> 
> Can someone advise please
> 
> TIA,
>   Avner
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
