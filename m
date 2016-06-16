From: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Subject: ceph-create-keys: mds "allow *" vs "mds allow"
Date: Thu, 16 Jun 2016 16:39:09 +0200 (CEST)
Message-ID: <1866707938.418.1466087949783@webmail.proxmox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from proxmox.maurer-it.com ([94.136.31.133]:65043 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbcFPOtV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2016 10:49:21 -0400
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id 3DCADAD09EE
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2016 16:39:14 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Dietmar Maurer <dietmar@proxmox.com>

Hello,

we already filed an issue over at Redmine (http://tracker.ceph.com/issues/16255), but since this is more of a question than bug report, I will repeat it here (and hope to get more insight ;))

The ceph documentation for monitor bootstrapping (http://tracker.ceph.com/issues/16255) says to create the client.admin key with (among other things) "--cap mds 'allow'" (while the cap for mon and osd is set to 'allow *', note the added ' *'). All our existing (users') ceph installations are setup with keyrings following this documentation, which worked find under Hammer.

Recently (in Jewel?), ceph-create-keys was changed to call "ceph auth get-or-create" with "mon 'allow *'" (again, note the added ' *'): https://github.com/ceph/ceph/commit/c7e905e7e232a973abf7c6fa71a2ffbad7aa0ffd

This is not only inconsistent with the current documentation, but also breaks all the existing installations/keyrings, because get-or-create will neither get nor create if the keyring exists, but the caps don't match.

Any pointers on how to remedy this situation? I could not find any information in the release notes (e.g., for a potential upgrade path) and either the change or the documentation seems to be wrong.

Regards,
Fabian

