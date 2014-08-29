From: David Zafman <dzafman@redhat.com>
Subject: Testing intermediate code for improved namespace handling
Date: Thu, 28 Aug 2014 21:28:07 -0700
Message-ID: <3C17FD49-5CA0-4E23-8AF4-5EB6F6AD032B@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:48057 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaH2E2L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Aug 2014 00:28:11 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so5373419pac.11
        for <ceph-devel@vger.kernel.org>; Thu, 28 Aug 2014 21:28:11 -0700 (PDT)
Received: from [10.0.1.27] (cpe-23-242-12-23.socal.res.rr.com. [23.242.12.23])
        by mx.google.com with ESMTPSA id y4sm8160137pdm.1.2014.08.28.21.28.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Aug 2014 21:28:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Check default namespace (non specified)
This keeps the command output compatible with existing scripts
./rados -p test ls
default-obj8
default-obj10
default-obj6
default-obj7
default-obj1
default-obj2
default-obj3
default-obj4
default-obj5
default-obj9

Try for all namespaces
./rados -p test -N * ls
ns2     ns2-obj3
ns2     ns2-obj5
ns2     ns2-obj10
       default-obj8
ns2     ns2-obj4
ns2     ns2-obj2
ns2     ns2-obj8
       default-obj10
ns1     ns1-obj5
       default-obj6
       default-obj7
ns1     ns1-obj4
ns1     ns1-obj10
ns1     ns1-obj2
       default-obj1
       default-obj2
ns1     ns1-obj9
ns1     ns1-obj3
       default-obj3
ns1     ns1-obj6
ns1     ns1-obj1
ns2     ns2-obj7
ns2     ns2-obj9
ns1     ns1-obj8
       default-obj4
ns1     ns1-obj7
       default-obj5
ns2     ns2-obj6
ns2     ns2-obj1
       default-obj9

Try for only one specific namespace
./rados -p test -N ns1 ls
ns1-obj5
ns1-obj4
ns1-obj10
ns1-obj2
ns1-obj9
ns1-obj3
ns1-obj6
ns1-obj1
ns1-obj8
ns1-obj7

David Zafman
Senior Developer
http://www.inktank.com
http://www.redhat.com



