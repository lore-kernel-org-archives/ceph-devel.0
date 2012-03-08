From: Chu Duc Minh <chu.ducminh@gmail.com>
Subject: Make Openstack work with Ceph
Date: Thu, 08 Mar 2012 15:35:21 +0700
Message-ID: <4F586F49.4070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61907 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274Ab2CHIf0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 03:35:26 -0500
Received: by dajr28 with SMTP id r28so231698daj.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Mar 2012 00:35:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, i have built a Ceph cluster and a Openstack cluster for dev
Ceph work quite smooth, i can mount it to client, or create disk image 
by using rbd, qemu-img,... command.
But i dont' know how to make openstack use new Ceph cluster as the 
default Block Device Storage.
(Openstack use KVM as default hypervisor and QCOW2 as default disk image 
format)

Can you give me some hint to configure Openstack(libvirt/..) to make it 
work with Ceph, pls?

Thanks very much, folks!
