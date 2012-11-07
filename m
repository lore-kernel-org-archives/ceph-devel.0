From: Stefan Priebe <s.priebe@profihost.ag>
Subject: less cores more iops / speed
Date: Wed, 07 Nov 2012 23:02:18 +0100
Message-ID: <509ADA6A.9000807@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44903 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab2KGWCV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 17:02:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello again,

I've noticed something really interesting.

I get 5000 iops / VM for rand. 4k writes while assigning 4 cores on a 
2.5 Ghz Xeon.

When i move this VM to another kvm host with 3.6Ghz i get 8000 iops 
(still 8 cores) when i then LOWER the assigned cores from 8 to 4 i get 
14.500 iops. If i assign only 2 cores i get 16.000 iops...

Why does less kvm cores mean more speed?

Greets,
Stefan
