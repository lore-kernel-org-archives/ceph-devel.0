From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: problems with ceph.init / etc/hosts and ceph.conf
Date: Wed, 20 Jun 2012 10:59:54 +0200
Message-ID: <4FE1910A.3020708@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:43458 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817Ab2FTJAA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 05:00:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i've some problems to find the correct combination of ceph.conf, 
/etc/hosts for the init script to work correctly.

My systems are named:
ssdstor000i
ssdstor001i
ssdstor002i

These names point to the public external IP.

These systems also have an alias (ssdstor000,ssdstor001) pointing to the 
internal IP which should be used by ceph.

My ceph.conf looks like this:

...
[osd.10]
         host= ssdstor000
[osd.11]
         host= ssdstor000
...

The ceph.init Script looks now for an entry called ssdstor000i but can't 
find one and so it does not start or stop any services.

My /etc/hosts file:
192.168.0.100    ssdstor000.XYZ.de       ssdstor000i

10.0.255.100    ssdstor000

What is the correct way to archieve that the default hostname is still 
the public one but ceph uses the internal one?

Greets
Stefan
