From: Martin Mailand <martin@tuxadero.com>
Subject: rbd map error with new rbd format
Date: Wed, 12 Sep 2012 14:56:50 +0200
Message-ID: <50508692.3050209@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:37050 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab2ILM46 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 08:56:58 -0400
Received: from [172.30.1.184] ([192.166.201.59])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q8CCuoIf001136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 14:56:56 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

whilst testing the new rbd layering feature I found a problem with rbd 
map. It seems rbd map doesn't support the new format.

-martin


ceph -v
ceph version 0.51-265-gc7d11cd 
(commit:c7d11cd7b813a47167108c160358f70ec1aab7d6)


rbd create --size 100000 --new-format new
rbd map new
add failed: (2) No such file or directory


rbd create --size 100000 old
rbd map old
rbd showmapped
id      pool    image   snap    device
1       rbd     old     -       /dev/rbd1


rbd info new
rbd image 'new':
         size 100000 MB in 25000 objects
         order 22 (4096 KB objects)
         block_name_prefix: rbd_data.101e1a89b511
         old format: False
         features: layering
rbd info old
rbd image 'old':
         size 100000 MB in 25000 objects
         order 22 (4096 KB objects)
         block_name_prefix: rb.0.1021.23697452
         old format: True
         features:
