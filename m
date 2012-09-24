From: Brice Burgess <briceburg@gmail.com>
Subject: Hardware Requirements for RADOS Gateway Cluster
Date: Mon, 24 Sep 2012 17:58:54 -0500
Message-ID: <5060E5AE.10400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:44665 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab2IXW65 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 18:58:57 -0400
Received: by ggnr5 with SMTP id r5so1310169ggn.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 15:58:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am planning the system architecture around a ceph cluster [my first!]. 
While resources for setting up the basic cluster (MON+MDS+OSD) are 
readily available*, I haven't come across anything outlining production 
recommendations for a RADOS Gateway Cluster. Specifically;

1. Is it preferable to run the RADOS Gateway on a MDS machine [for 
latency issues], or should the Gateway run on seperate hosts/VMs than 
the ODS/MON/MDS servers?

2. I've seen reference that multiple RADOS Gateway servers can be setup 
as a cluster "to scale". Is this possible? Is there an 
example/documentation for this? Is it just 2 standalone gateways with a 
load balancer in front?

My assumption is to provision a dedicated machine for the RADOS Gateway. 
I'd treat this machine as a "front end proxy/caching server" meaning it 
would have a lot of RAM for varnish/nginx and a low latency, high 
throughput network connection to the ODS/MDS machines as well as one to 
the public network.

Any thoughts and suggestions are welcome. Eventually I'd like to release 
a whitepaper of this setup if we can hit the budget to actually implement ;)

~ Brice

