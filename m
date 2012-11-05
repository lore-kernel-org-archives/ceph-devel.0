From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: use striping feature
Date: Mon, 05 Nov 2012 13:03:03 +0100
Message-ID: <5097AAF7.8080709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:34224 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab2KEMDH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 07:03:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

is the following syntax to use the new rbd v2 striping feature correct?

rbd create -p kvmstor --format 2 --size 32000 --stripe-count 8 
--stripe-unit 131072 -s 1048576 $imagename

Idea is to have 8 stripes per 1MB object size. Or are there any other 
recommondations regarding striping?

I'm a bit confused cause rbd info shows stripe-count as bytes?

rbd image 'vm-113-disk-4':
         size 1024 GB in 262144 objects
         order 22 (4096 KB objects)
         block_name_prefix: rbd_data.d0f7639a214d
         format: 2
         features: layering
         stripe unit: 128 KB
         stripe count: 8 bytes

Stefan
