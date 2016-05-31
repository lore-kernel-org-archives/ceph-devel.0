From: Ken Dreyer <kdreyer@redhat.com>
Subject: dependency on parted: just ceph-osd, or more?
Date: Tue, 31 May 2016 15:06:16 -0600
Message-ID: <CALqRxCwBRjx8OXceg1j+5dCNNDfKdLksJjnuNcmJFD+t6ZEfPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33626 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756464AbcEaVGS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 17:06:18 -0400
Received: by mail-vk0-f44.google.com with SMTP id r140so279624529vkf.0
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 14:06:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Loic, is there anything in ceph outside of the ceph-osd package
that requires parted?

I'm wondering if we can move the parted dependency to the ceph-osd
sub-package, http://tracker.ceph.com/issues/16095

Among other things, this would make Mon and MDS containers lighter.

- Ken
