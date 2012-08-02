From: Tommi Virtanen <tv@inktank.com>
Subject: TIER: combine SSDs and HDDs into a single block device
Date: Thu, 2 Aug 2012 09:13:54 -0700
Message-ID: <CADvuQRExAsO2yKo6pT+MMfj8Gwt7a7SGkkOgm-0kjQ+nRzU75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51519 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2HBQOQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 12:14:16 -0400
Received: by vbbff1 with SMTP id ff1so8281381vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 09:14:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sounds like bcache in writeback mode. Assumes all underlying block
devices are RAIDed, or losing one will mean losing data; that is, for
example RAID1(SSD+SSD) & RAID5(8*HDD).

http://www.lessfs.com/wordpress/?p=776
