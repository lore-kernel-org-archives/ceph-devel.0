From: brady <brady@lamphost.com>
Subject: Vanity Hostnames Not Working
Date: Thu, 25 Apr 2013 15:29:52 -0700
Message-ID: <5179AE60.2090700@lamphost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tux1.lamphost.net ([69.43.195.66]:46765 "EHLO tux1.lamphost.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759031Ab3DYWst (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Apr 2013 18:48:49 -0400
Received: from rrcs-64-183-4-86.west.biz.rr.com ([64.183.4.86]:55887 helo=[192.168.1.17])
	by tux1.lamphost.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.76)
	(envelope-from <brady@lamphost.com>)
	id 1UVUfp-0006I4-5I
	for ceph-devel@vger.kernel.org; Thu, 25 Apr 2013 15:29:53 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello list,
	We are running Bobtail on our cluster and currently attempting to make 
the vanity host names work in the radosGW configuration. Our rgw segment 
of the ceph.conf file looks like:

[client.radosgw.rgw1]
   host = ceph-rgw1
   rgw dns name = objects.lamphost.net
   rgw resolve cname = true
   rgw enable usage log = true
   keyring = /etc/ceph/keyring.radosgw.rgw1
   rgw socket path = /run/radosgw.sock
   log file = /var/log/ceph/radosgw.log

	The DNS does not seem to route with the configuration above. Is there 
something else/different that is required to make this work? We have not 
seen any concrete examples of configurations for this despite the Vanity 
host names being listed as an addition in the Bobtail release notes.

	Thanks in advance!

-Brady
