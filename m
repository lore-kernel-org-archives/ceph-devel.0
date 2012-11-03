From: Stefan Priebe <s.priebe@profihost.ag>
Subject: BUG: problem when removing / creating rbd image (format v2)
Date: Sat, 03 Nov 2012 11:27:42 +0100
Message-ID: <5094F19E.7010401@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35236 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2KCK1k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 06:27:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

[systemI: ~]# rbd -p kvmstor rm vm-113-disk-1
2012-11-03 11:25:43.520833 7fb191d71760 -1 librbd::ImageCtx: error 
finding header: (2) No such file or directory
Removing image: 0% complete...failed.
rbd: delete error: (2) No such file or directory
2012-11-03 11:25:43.531708 7fb191d71760 -1 librbd: error removing img 
from new-style directory: (2) No such file or directory

[systemI: ~]# rbd create -p kvmstor --format 2 --size 32000 
--stripe-count 4 --stripe-unit 1048576 -s 4194304 kvm-113-disk-1
rbd: create error: (17) File exists
2012-11-03 11:25:41.017364 7fae8b832760 -1 librbd: rbd image 
kvm-113-disk-1 already exists

[systemI: ~]# rbd -p kvmstor rm vm-113-disk-1
2012-11-03 11:26:55.552217 7f1349114760 -1 librbd::ImageCtx: error 
finding header: (2) No such file or directory
2012-11-03 11:26:55.564664 7f1349114760 -1 librbd: error removing img 
from new-style directory: (2) No such file or directory
Removing image: 0% complete...failed.
rbd: delete error: (2) No such file or directory

There seems to be a bug ;-)

Stefan
