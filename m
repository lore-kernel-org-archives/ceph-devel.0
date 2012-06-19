From: Terrance Hutchinson <terrance.hutchinson@gmail.com>
Subject: Building a small Ceph development environment
Date: Tue, 19 Jun 2012 11:47:14 -0600
Message-ID: <CAJLzzs+9X3dWUMLavOnp1ijvOJLDprM3YsGDLo=DUEEkb9yp4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43826 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab2FSRrP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 13:47:15 -0400
Received: by qcro28 with SMTP id o28so3676616qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 10:47:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I have an HP ProLiant ML350 G5 server that is currently sitting idle
at the moment. Would it be possible to virtualize a Ceph cluster so I
can mess around and begin contributing back to the community?

Specs:

ML350 G5
2 x Quad Core Xeon E5430
16GB RAM
7x 146GB SAS disks
1x 120 GB Intel 520 SSD
HP P800 Smart Array Controller (can purchase an LSI 208E SAS HBA which
will make the disks a JBOD)

My goal is to create a small Ceph setup to do testing and bug fixes
for the project which is why I posted this to the development list.

Thanks in advance,
Terrance
