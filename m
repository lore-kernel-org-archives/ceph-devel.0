From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: incremental rbd export / sparse files?
Date: Thu, 22 Nov 2012 12:02:06 +0100
Message-ID: <50AE062E.5020301@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42477 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965162Ab2KVUCQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 15:02:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

right now a rbd export exports exactly the size of the disk even if 
there is KNOWN free space. Is this inteded to change?

Might it be possible to export just differences between snapshots and 
merge them later?

Greets,
Stefan
