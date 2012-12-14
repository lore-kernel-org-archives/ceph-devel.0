From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Debian packaging question
Date: Thu, 13 Dec 2012 20:38:34 -0800
Message-ID: <3EBEC3BA-3E32-413E-8DBF-5ED7A5FB6F36@inktank.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl> <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com> <50C705A9.1030603@ubuntu.com> <7A33695B-249B-4638-94BF-BC3BD283216B@inktank.com> <50C864A8.1010707@ubuntu.com> <alpine.DEB.2.00.1212120742140.8754@cobra.newdream.net> <50C90293.4060407@ubuntu.com> <95BEC6FE-ECFA-4106-BF1F-C4BD43819602@inktank.com> <50C99B5E.9010006@ubuntu.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:38419 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab2LNEij convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 23:38:39 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1241352dak.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 20:38:38 -0800 (PST)
In-Reply-To: <50C99B5E.9010006@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>


On Dec 13, 2012, at 1:09 AM, James Page wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> On 12/12/12 23:38, Gary Lowell wrote:
>> I took your new rules file out for a spin.  It built ok, but we
>> still got the libcephfs-java_0.55.1-1precise_all.deb built despite
>> the --binary-arch flag.  The command used for the build is:
>> 
>> sudo pbuilder build --binary-arch --debug --distribution precise
>> --basetgz /srv/debian-base/precise.tgz --buildresult
>> /tmp/release/0.55.1/ --debbuildopts '-j8 -b'
>> /tmp/release/0.55.1/ceph_0.55.1-1precise.dsc
>> 
>> And the log shows the -B option on dpkg-buildpackage:
>> 
>> I: Building the package I: Running cd tmp/buildd/*/ && env
>> PATH="/usr/lib/ccache:/usr/sbin:/usr/bin:/sbin:/bin"
>> dpkg-buildpackage -us -uc   -B -j8 -b -rfakeroot
> 
> 
> I think that the "--debbuildopts '-j8 -b'" might be trouncing the
> - --binary-arch flag - I'll get pbuilder setup and give it a test - I
> normally use sbuild (for which the packaging changes did have the
> desired effect).


I does appear to have been the --debbuildopts causing the problem.  The combination of your rules file update and removing  --debbuildopts  built just the arch dependent packages.  

Thanks for the help.

Cheers,
Gary