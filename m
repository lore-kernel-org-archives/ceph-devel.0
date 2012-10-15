From: Alex Jiang <alex.jiang.zju@gmail.com>
Subject: Two questions about client writes update to Ceph
Date: Mon, 15 Oct 2012 16:46:19 +0800
Message-ID: <CAGVY77cBnFzM9bA5hHkpO6hZycz=v9Jo4_ZDc0f6_w0yvazyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58075 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab2JOIqU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 04:46:20 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2290848bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 01:46:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,all
    I'm very interested in Ceph. Recently I deployed a Ceph cluster in
lab environment, and it works very well. Now I am studying the
principle of Ceph RBD. But I am confused about two questions.
    1) When client writes update to Ceph RBD, it contacts with primary
OSD directly. Then The primary OSD forwards the update to replicas. If
the replicas are down and update is not committed to replicas disks,
but the update has been committed to primary OSD disk, will Ceph
rollbacks the transaction?
    2) To ensure availability, do journals exist in client side to log
I/O history? If true, are the journals durable in disks?

  Regards,

  Alex
