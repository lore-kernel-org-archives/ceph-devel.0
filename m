From: Wido den Hollander <wido@42on.com>
Subject: PowerDNS backend for Rados Gateway to direct bucket traffic
Date: Sun, 03 Nov 2013 15:15:26 +0100
Message-ID: <52765A7E.9040306@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:33095 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022Ab3KCOPa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 3 Nov 2013 09:15:30 -0500
Received: from [79.99.132.145] (unknown [79.99.132.145])
	by websrv.42on.com (Postfix) with ESMTPSA id 3CFF8CBB8F
	for <ceph-devel@vger.kernel.org>; Sun,  3 Nov 2013 15:15:27 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm playing with an idea, but I'm not sure if I'm taking the correct route.

When you create a bucket with Amazon S3 it's always reachable via 
bucketname.s3.amazonaws.com.

Depending on the region you created it in you'll get a different 
response from their DNS servers directing you to the correct HTTP endpoint.

When you use the RGW with multiple regions you get a 301 redirect from a 
region if the bucket is not located there.

This 301 is extra TCP traffic and adds extra latency. You could 
potentially have a developer who is mistaken and directs thousands of 
requests to the wrong region which are all answered with 301 redirects. 
A waste of resources.

I've worked with PowerDNS a lot and it supports various backends and one 
of them is the Pipe or HTTP (new!) backend [0]

It would be rather cool if you could have a global domainname like 
"s3.amazonaws.com", but behind it you have multiple regions, but based 
on the DNS request you do PowerDNS responds with a different CNAME.

global: o.myobject.store
EU:     eu.myobject.store
US:     us.myobject.store

Based on where the bucket is PowerDNS will respond with:

CNAME bucket.eu.myobject.store
or
CNAME bucket.us.myobject.store

Does it sound reasonable what I'm thinking of or am I completely wrong 
about this?

[0]: http://doc.powerdns.com/html/remotebackend.html

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
