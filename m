From: Martin Mailand <martin@tuxadero.com>
Subject: crushmap errors
Date: Fri, 11 Nov 2011 23:19:14 +0100
Message-ID: <4EBD9F62.20709@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:45682 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab1KKWTS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2011 17:19:18 -0500
Received: from [192.168.1.106] (e178228137.adsl.alicedsl.de [85.178.228.137])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pABMJBY2030810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2011 23:19:17 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I used in ceph v0.38 the host and rack feature in the conf during an 
mkcephfs. Now I have to problems with the crushmap

1. I cannot compile a ceph genearated crushmap.
crushtool -c file.txt -o file
file.txt:4 error: parse error at '.0'

# begin crush map

# devices
device 0 osd.0


2. Why are 2 racks are not enough for 2 failure domains?
 From the commit:
If there are >2 racks, separate across racks.

and in the src/osd/OSDMap.cc

    if (racks.size() > 3) {
       // spread replicas across hosts
       crush_rule_set_step(rule, 1, CRUSH_RULE_CHOOSE_LEAF_FIRSTN, 
CRUSH_CHOOSE_N, 2);

shouldn't that be

    if (racks.size() > 1) {
       // spread replicas across racks
       crush_rule_set_step(rule, 1, CRUSH_RULE_CHOOSE_LEAF_FIRSTN, 
CRUSH_CHOOSE_N, 2);

Best Regards,
  martin
