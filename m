From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 0/2] Kernel file system client support for punch hole
Date: Fri, 14 Jun 2013 23:36:26 +0800
Message-ID: <1371224186-4809-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

This patch implements punch hole (fallocate) support for Ceph kernel
file system client.
We prepared two patches based on different kernel versions, one against
kernel 3.8-rc3, the other against the latest 3.10-rc5. It is because
unfortunately, we failed to set up a workable Ceph system with the client
based on the lastest code from Linux kernel git tree, for the server
side, we tried both the latest code from Ceph git tree and
the latest v0.61.3 release. The client will easily hang there without
any response, unless rebooting the machine.
We managed to set up a Ceph system with the client based on Linux 
kernel 3.8-rc3 and the server based on Ceph v0.61.3, so the patch 
against v3.8-rc3 has been under preliminary tests. However, the one 
against v3.10-rc5 not.
Comments are appreciated.  
