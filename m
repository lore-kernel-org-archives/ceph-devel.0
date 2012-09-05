From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 05 Sep 2012 06:31:44 +0200 (CEST)
Message-ID: <cf402294-b0f9-4b8c-8b08-6a51aa64cab4@mailpro>
References: <50468E0E.6070807@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:60076 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2IEEcL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 00:32:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 1725618030A3E
	for <ceph-devel@vger.kernel.org>; Wed,  5 Sep 2012 06:31:50 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E29ncO4h-wvD for <ceph-devel@vger.kernel.org>;
	Wed,  5 Sep 2012 06:31:44 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id C7C9D18024770
	for <ceph-devel@vger.kernel.org>; Wed,  5 Sep 2012 06:31:44 +0200 (CEST)
In-Reply-To: <50468E0E.6070807@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

We have added rbd 0.48 support to the proxmox 2.1 kvm distribution
http://www.proxmox.com/products/proxmox-ve


Proxmox setup:

edit the /etc/pve/storage.cfg and add the configuration (gui creation is not available yet) 

rbd: mycephcluster
       monhost 192.168.0.1:6789;192.168.0.2:6789;192.168.0.3:6789
       pool rbd
       username admin
       authsupported cephx;none
       content images 


then you need to copy the keyring file from ceph to proxmox

scp cephserver1:/etc/ceph/client.admin.keyring /etc/pve/priv/ceph/mycephcluster.keyring 



For now, you can add/delete/resize rbd volumes from gui.
Snapshots/cloning will be added soon (when layering will be available)


Regards,

Alexandre Derumier
