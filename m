From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Limited IOP/s on Dual Xeon KVM Host
Date: Sat, 10 Nov 2012 09:03:49 +0100
Message-ID: <509E0A65.1040903@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60348 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab2KJIDw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Nov 2012 03:03:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "pve-devel@pve.proxmox.com" <pve-devel@pve.proxmox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello lists,

on a dual Xeon KVM Host i get max 6000 IOP/s random 4k writes AND reads. 
On a Single Xeon KVM Host i get 17.000-18.000 IOP/s write and read. I 
already tried to pin the kvm process using numactl and also the fio 
process but it doesn't help on the dual xeon.

10GBE Network is fine. I get 9.8Gbit/s on both hosts. Kernel is also he 
same on both.

Anybody an idea?

Greets
Stefan
