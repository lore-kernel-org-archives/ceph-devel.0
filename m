From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: gmock linkage / packaging errors
Date: Fri, 06 Mar 2015 00:14:58 +0100
Message-ID: <54F8E372.1060103@bisect.de>
References: <54F89BEB.3080303@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:45882 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751398AbbCEXPE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 18:15:04 -0500
In-Reply-To: <54F89BEB.3080303@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Am 05.03.2015 um 19:09 schrieb Loic Dachary:
> Hi Danny,
> 
> The build of master shows linkage errors:
> 
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-amd64-basic/log.cgi?log=60e2bec73ff3970e0c6b44250ce465e6c5dde56f
> 
>     error: dpkg-shlibdeps: couldn't find library libgmock_main.so.0 needed by debian/ceph-test/usr/bin/ceph_test_cls_lock (ELF format: 'elf64-x86-64'; RPATH: '') 
> 
>     error: dpkg-shlibdeps: couldn't find library libgtest.so.0 needed by debian/ceph-test/usr/bin/ceph_test_cls_lock (ELF format: 'elf64-x86-64'; RPATH: '') 
> 
>     error: dpkg-shlibdeps: couldn't find library libgmock_main.so.0 needed by debian/ceph-test/usr/bin/ceph_test_rados_api_c_write_operations (ELF format: 'elf64-x86-64'; RPATH: '') 
> 
> Do you know where that comes from ? IIRC it successfully compiled in the gitbuilders on a branch of yours. That's weird.

Hm ... I have to take a look at it tomorrow. This build worked on the
branch:
http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-precise-amd64-basic/log.cgi?log=be7b4c38e363457efab52fc5d8d995b63cdc73fd

and also this one:

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-precise-amd64-basic/log.cgi?log=be7b4c38e363457efab52fc5d8d995b63cdc73fd

Not sure why this all is working in the branch and not in master, it's
really strange.

Danny
