From: Martin Mailand <martin@tuxadero.com>
Subject: rbd snap ls does not list more than 200 snapshots
Date: Tue, 24 Jan 2012 23:28:44 +0100
Message-ID: <4F1F309C.9060507@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:57882 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab2AXW2r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jan 2012 17:28:47 -0500
Received: from [192.168.1.175] (e178241150.adsl.alicedsl.de [85.178.241.150])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0OMSiiZ023890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 24 Jan 2012 23:28:45 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I created quite a few snapshots of a rbd image. After around 200 
snapshots the command rbd snap ls vm10 does not return, instead it uses 
all of the memory of a 32G machine an then the oom killer gets kicked in.
Are 200 snapshots a known limit?

How to reproduce:

for i in $(seq 500); do rbd snap create --snap=a$i vm10; echo $i ; done

rbd snap ls vm10
doesn't return

top:
25381 root      20   0 5425m 5.2g 5436 S   29 16.4   1:10.21 rbd

rbd -v
ceph version 0.40-206-g6c275c8 
(commit:6c275c8195a8ae04e8a492d043fa6dfd60cecd82)


-martin
