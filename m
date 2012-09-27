From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RPMs
Date: Thu, 27 Sep 2012 22:58:57 +0200
Message-ID: <5064BE11.50909@widodh.nl>
References: <alpine.DEB.2.00.1209271344000.13352@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57560 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab2I0U67 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 16:58:59 -0400
In-Reply-To: <alpine.DEB.2.00.1209271344000.13352@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/27/2012 10:47 PM, Sage Weil wrote:
> For v0.52 we built some RPMs for the first time.  The release machine=
ry
> here is brand new (thanks, Gary!), so if you run into problems (or do=
n't!)
> with the repos as they are currently set up, let us know.
>

The link in the docs is dead: ceph.com/docs/master/install/rpm/

su -c =91rpm -Uvh http://ceph.com/rpms/el6/x86_64/ceph-release-1-0.noar=
ch.rpm=91

The correct RPM URL is:=20
http://ceph.com/rpms/el6/x86_64/ceph-release-1-0.el6.noarch.rpm

Same goes for the FC17.

After fixing that I tried to install Ceph on CentOS 6.3 with:

$ yum install ceph

That resulted in:

--> Running transaction check
---> Package ceph.x86_64 0:0.52-6.el6 will be installed
--> Processing Dependency: libcryptopp.so.6()(64bit) for package:=20
ceph-0.52-6.el6.x86_64
---> Package libcephfs1.x86_64 0:0.52-6.el6 will be installed
--> Processing Dependency: libcryptopp.so.6()(64bit) for package:=20
libcephfs1-0.52-6.el6.x86_64
---> Package librados2.x86_64 0:0.52-6.el6 will be installed
--> Processing Dependency: libcryptopp.so.6()(64bit) for package:=20
librados2-0.52-6.el6.x86_64
---> Package librbd1.x86_64 0:0.52-6.el6 will be installed
--> Processing Dependency: libcryptopp.so.6()(64bit) for package:=20
librbd1-0.52-6.el6.x86_64
--> Finished Dependency Resolution
Error: Package: libcephfs1-0.52-6.el6.x86_64 (ceph)
            Requires: libcryptopp.so.6()(64bit)
Error: Package: ceph-0.52-6.el6.x86_64 (ceph)
            Requires: libcryptopp.so.6()(64bit)
Error: Package: librados2-0.52-6.el6.x86_64 (ceph)
            Requires: libcryptopp.so.6()(64bit)
Error: Package: librbd1-0.52-6.el6.x86_64 (ceph)
            Requires: libcryptopp.so.6()(64bit)
  You could try using --skip-broken to work around the problem
  You could try running: rpm -Va --nofiles --nodigest

This should be part of the cryptopp package I think? But this package=20
isn't available on my CentOS machine.

Any suggestions?

Wido

> We started with CentOS6/RHEL6 and Fedora 17 for x86_64.  Please let u=
s
> know what other distributions/architectures you are interested in.
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
