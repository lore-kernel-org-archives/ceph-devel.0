From: Karol Jurak <karol.jurak@gmail.com>
Subject: Writing to RBD image while it's snapshot is being created causes I/O errors
Date: Fri, 14 Jun 2013 16:47:19 +0200
Message-ID: <1881883.Fj0UjQGoA9@karol-esprimo-p5925>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:56342 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3FNOqo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 10:46:44 -0400
Received: by mail-ee0-f47.google.com with SMTP id e49so404650eek.6
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jun 2013 07:46:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I noticed that writing to RBD image using kernel driver while it's snapshot 
is being created causes I/O errors and the filesystem (reiserfs) eventually 
aborts and remounts itself in read-only mode:

[192507.327359] end_request: I/O error, dev rbd7, sector 818528
[192507.331510] end_request: I/O error, dev rbd7, sector 819200
[192507.348478] end_request: I/O error, dev rbd7, sector 408
[192507.352647] REISERFS abort (device rbd7): Journal write error in 
flush_commit_list

Is this happening by design or is it a bug? I know that I should freeze the 
filesystem before attempting to create a snapshot but these I/O errors seem 
unnecessary to me. If it's really impossible to write to an image while it's 
snapshot is being created couldn't write requests be blocked until 
snapshotting completes?

I'm using ceph 0.56.6 and kernel 3.4.48.

-- 
Karol Jurak
