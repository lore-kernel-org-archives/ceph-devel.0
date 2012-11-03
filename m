From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Handle bad file descriptors with EBADF
Date: Sat, 3 Nov 2012 14:56:57 -0700
Message-ID: <CAPrxi5-9xAaUnJp5dhyvGpZ4rZ0cM=F6TcvtdBNi53EhSzU_NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38480 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab2KCV46 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 17:56:58 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4828430vbb.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 14:56:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The libcephfs interface asserts valid file descriptors, so clients are
forced to manage this or risk crashes. Pushed to wip-bad-fd is changes
that handle this case by returning -EBADF. Review welcome :)

- Noah
