From: Robert LeBlanc <robert@leblancnet.us>
Subject: Please test Weighted Priority Queue in Master
Date: Wed, 3 Feb 2016 10:20:54 -0700
Message-ID: <CAANLjFoFEfQTYVU31f22t6Ra-ceP+6fB-Q-VX99HwB+0OAoWPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33126 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbcBCRUz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 12:20:55 -0500
Received: by mail-vk0-f53.google.com with SMTP id e64so19290713vkg.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 09:20:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Now that WPQ has been merged in master, please test it out in your
environments. There have been performance improvements across the
board in my testing with SSDs having the largest gains and it would be
great to get some others' review as well. There was discussion to
potentially make this the default queue for Jewel, so the more testing
the better.

To enable the WPQ and adjust the priority cutoff, use the following in
ceph.conf (by default it uses the PrioritizedQueue):

osd_op_queue = wpq
osd_op_queue_cut_off = low

It does require an OSD restart (not a run time tuneable option) to
change the queue/cutoff.

Thanks,
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.4
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWsjbxCRDmVDuy+mK58QAAhQEP/3CXxHXY6G1TXb4toG2W
rD3QngEKNZDeAh/J86Dm/wpmELryqdj510HKbZHUchmnvdtgsshGxDUkaK8z
rKnspw/M/04DdgPDoImc2n69hw1JcaHiGJ3hh5Obhp0ur6zLX8VnpSBvP4a1
lveCNSkx0mpTv2VhawClUJ1VTet489iJcTRP8OCwx2JApkjzokAw33AOqbua
zyhpmPiDCrYvzRb0K/xgiyJxQuXY4TQA8OU1Yklyl9tvAvCRQvjFQkF3+QpH
r/KifpcXfPkfPsiasFLkDJaCrccoqjCrl9aHrYcXJ7Ap88kZeUaR2RbMqUUH
1mTIh5oA5GjSjE6wrpGqe2nn+NymkIV0b+KXDvbM9sZnPUQVRf5yGUOY7jiK
5Ta3rDs0Mj469RJlT3UEZhSyz0qLTfihq0QR0AkiutWE5QNvcsy+ozhaOYEO
XAXEfI1CZJPnpLTPeghOqIQTwKZOJ2m15y+lrTyC5qmnYJBKzkNi9iPzx7hl
gFwBUih4TcBd2uUAg4p/ntnSRei6RLrx1VGy53nxVnZ4Oiu+FHMEndtMc0zX
XQUkS+AUM8eJLQutHA8rEhYguE6vb7kvf130TLZ77YrckCkBlqWRbVX/cQQI
ffZ8ioMjC+I8nH3lRD7fyhchdyeKK7AmroqnYTNX8/jxDpAGJTxn3vhOAu0p
tDED
=JKs2
-----END PGP SIGNATURE-----
