From: Sandon Van Ness <sandon@inktank.com>
Subject: Master needs newer version of boost on centos?
Date: Fri, 14 Feb 2014 15:39:53 -0800
Message-ID: <52FEA949.4090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43704 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbaBNXjf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 18:39:35 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so12435744pdj.5
        for <ceph-devel@vger.kernel.org>; Fri, 14 Feb 2014 15:39:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ben@inktank.com


The last couple builds of master have been failing on the centos 
gitbuilder. here is the build log:

http://gitbuilder.sepia.ceph.com/gitbuilder-centos6-amd64/log.cgi?log=f47062d8a66b94743888aaea13e0766579379395

Its running into:

CXX mds/Capability.lo
CXX mds/Dumper.lo
In file included from client/Client.h:38,
from libcephfs.cc:21:

      error: client/barrier.h:25:38: boost/icl/interval_set.hpp: No such
      file or directory 


It looks like its not effecting fedora gitbuilders that have a newer 
version of boost but on centos/rhel the version is only 1.41.0-18. Is 
there something we can do to get around this without back-porting or 
will backporting a newer boost for rhel/centos be necessary?
