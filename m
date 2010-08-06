From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: compiler warnings on centos5
Date: Fri, 6 Aug 2010 12:00:57 +0000 (UTC)
Message-ID: <i3gthp$56v$2@dough.gmane.org>
References: <i3e1fs$mv$1@dough.gmane.org>
	<AANLkTi=uegGEfjXw_DpfshdArsjQjk=sOv8DJ0-TF5be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37433 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab0HFMBK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Aug 2010 08:01:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OhLbo-0008ND-Q3
	for ceph-devel@vger.kernel.org; Fri, 06 Aug 2010 14:01:08 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 06 Aug 2010 14:01:08 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 06 Aug 2010 14:01:08 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 05 Aug 2010 10:02:15 -0700 schrieb Gregory Farnum:

> Thomas:
> We're certainly interested in keeping the Ceph compile warning-free.
> However, these errors are pretty annoying to work around and are bogus
> enough to not be present in newer versions of gcc (it's the compiler,
> not the system). Can you upgrade your compiler? -Greg
> 

I found out that Centos5 actually provides a gcc44 and gcc44-c++ package. 
Compiling with those doesn't show the wanrings.

symlinking g++44 and gcc44 to /usr/local/(gcc|g++) works.


calling configure with the custom paths for gcc and g++ doesn't:

CC=/usr/bin/gcc44 CXX=/usr/bin/g++44 ./configure --prefix=/usr
...
checking for atomic_ops.h... yes
checking for dirent.h that defines DIR... yes
checking for library containing opendir... none required
checking for ANSI C header files... (cached) yes
checking for sys/wait.h that is POSIX.1 compatible... yes
checking boost/spirit.hpp usability... no
checking boost/spirit.hpp presence... no
checking for boost/spirit.hpp... no
configure: error: Sorry you need to install the Boost spirit parser 
library (libboost-dev on debian)

- Thomas

