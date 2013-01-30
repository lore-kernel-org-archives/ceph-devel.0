From: Wido den Hollander <wido@widodh.nl>
Subject: cephx execute permissions for RBD operations
Date: Wed, 30 Jan 2013 17:21:01 +0100
Message-ID: <5109486D.7040505@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:39223 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab3A3QVF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 11:21:05 -0500
Received: from [IPv6:2a00:f10:113:0:808d:9060:49f6:b290] (unknown [IPv6:2a00:f10:113:0:808d:9060:49f6:b290])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id AF6D6435B5
	for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 17:21:02 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Yesterday I ran into a weird situation where my libvirt RBD pool
just wouldn't work.

Turned out the credentials I was using only had rw permissions for OSDs 
instead of rwx or *.

This caused rbd_open to fail, looking at librbd itself I understand why 
execute permissions are required to do so (locks, watches).

What is however the best way to detect if you don't have the required 
permissions?

This piece of code: 
http://libvirt.org/git/?p=libvirt.git;a=blob;f=src/storage/storage_backend_rbd.c;h=8a0e517502c482f23f01bc63e95f1dc210d711cd;hb=master#l215

I simply check if the open fails, but just "failed to open the RBD 
image" wasn't really that clear.

I'd like to give a more useful error instead of that, but what error 
codes can I expect?

Wido

