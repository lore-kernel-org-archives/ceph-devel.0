From: Bill Hastings <bllhastings@gmail.com>
Subject: Understanding Ceph
Date: Sat, 17 Dec 2011 22:41:03 -0800
Message-ID: <CAJMJAuPK8c4YBx3HUXOwOVfJAQuN2m2BHPNfyhr4hmpa0f1+Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33922 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1LRGlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Dec 2011 01:41:03 -0500
Received: by vbbfc26 with SMTP id fc26so3379514vbb.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Dec 2011 22:41:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All

I am trying to get my feet wet with Ceph and RADOS. My aim is to use
it as a block device for KVM instances. My understanding is that
virtual disks get striped at 1 MB boundaries by default. Does that
mean that there are going to be 1MB files on disks? Let's say I want
to update a particular vdisk with 16 bytes of data at offset 4096.
This would mean I want to update the first 1MB chunk. Let us assume I
have 3 way replication and the replicas are A, B and C. The write may
succeed at A and B and fail at C. Is there any state kept in the
metadata indicating at which replicas the write succeeded?
