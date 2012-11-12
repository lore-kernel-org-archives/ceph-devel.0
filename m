From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: optmize librbd for iops
Date: Mon, 12 Nov 2012 14:50:14 +0100
Message-ID: <50A0FE96.9030708@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37838 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab2KLNuR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 08:50:17 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

are there any plans to optimize librbd for iops? Right now i'm able to 
get 50.000 iop/s via iscsi and 100.000 iop/s using multipathing with iscsi.

With librbd i'm stuck to around 18.000iops. As this scales with more 
hosts but not with more disks in a vm. It must be limited by rbd 
implementation in kvm / librbd.

Greets,
Stefan
