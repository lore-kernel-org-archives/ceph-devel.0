From: hemant surale <hemant.surale@gmail.com>
Subject: How to mount all cluster data to one particular Dir in single Host.
Date: Thu, 30 Aug 2012 16:36:13 +0530
Message-ID: <CAGfy=6nT2w7wqH30QscDREydNg2CS7uGURdx0E-2_qOGqaScoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46823 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab2H3LGO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 07:06:14 -0400
Received: by vbbff1 with SMTP id ff1so1680879vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 04:06:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Community,
       Is it possible to mount all cluster data on directory present
at single node? if yes how to do that? . I am using 3 VMs as a ceph
(v0.31 & ubuntu 11.10) cluster (3 osds,1 mon ,1 mds) & I was trying to
observe how file is stored over different OSDs when replication
parameter is set to 1.
 Any help is appriciable.


Regards,
Hemant Surale.
