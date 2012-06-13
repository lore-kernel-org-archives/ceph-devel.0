From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Fwd: Does Ceph support direct I/O?
Date: Wed, 13 Jun 2012 12:15:58 +0200
Message-ID: <CAOLwVUmzVowNDPhN9fiejQd2aUtTLDy4XekzKkHnq44kYoBA=g@mail.gmail.com>
References: <CAOLwVUntx2uB9ckvimNHEYi31C7_L=jNPiNvrbFAFYwtVWKk=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40532 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2FMKQT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 06:16:19 -0400
Received: by lbbgm6 with SMTP id gm6so1089051lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 03:16:18 -0700 (PDT)
In-Reply-To: <CAOLwVUntx2uB9ckvimNHEYi31C7_L=jNPiNvrbFAFYwtVWKk=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi everyone,

I did some simple tests in order to figure out if Ceph has a direct
I/O full support.

I don't know why but when I try create a file > to 9M I get an error
from dd, same with sg_dd:

$ sudo dd if=/dev/zero of=/mnt/directio bs=9M count=1 oflag=direct
1+0 records in
1+0 records out
9437184 bytes (9.4 MB) copied, 0.0889428 s, 106 MB/s

And > 9:

$ mount | grep ceph
172.17.1.4:6789,172.17.1.5:6789,172.17.1.7:6789:/ on /mnt type ceph
(name=admin,key=client.admin)
$ dd if=/dev/zero of=/mnt/directio bs=10M count=1 oflag=direct
dd: writing `/mnt/directio': Bad address
1+0 records in
0+0 records out
0 bytes (0 B) copied, 1.20184 s, 0.0 kB/s

Thank you in advance :)

Cheers!
