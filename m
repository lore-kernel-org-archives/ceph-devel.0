From: Kjetil Babington <babingto@gmail.com>
Subject: Ceph erasure coding
Date: Thu, 22 Oct 2015 18:44:44 +0200
Message-ID: <CA+nGFBodcEq0vOvuFP1Od0zVCyk_9PufsRSYBJYi1W4p_vh+7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37118 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbbJVQop (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 12:44:45 -0400
Received: by wicfv8 with SMTP id fv8so128919325wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 09:44:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have a question about the capabilities of the erasure coding API in
Ceph. Let's say that I have 10 data disks and 4 parity disks, is it
possible to create an erasure coding plugin which creates 20 data
chunks and 8 parity chunks, and then places two chunks on each osd?

Or said maybe a bit simpler is it possible for two or more chunks from
the same encode operation to be placed on the same osd?

- Kjetil Babington
