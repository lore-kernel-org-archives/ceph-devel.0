From: Simon Tian <aixt2006@gmail.com>
Subject: replication write speed
Date: Mon, 9 May 2011 10:43:29 +0800
Message-ID: <BANLkTimPZ0rNe2-edtahK4RHRMQZH52qBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54794 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab1EICoS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 May 2011 22:44:18 -0400
Received: by wya21 with SMTP id 21so3556711wya.19
        for <ceph-devel@vger.kernel.org>; Sun, 08 May 2011 19:44:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

      I am testing the replication performance of ceph-0.26 with
libceph, write 1G data in with ceph_write() and read it out with
ceph_read(),

rep_size    1                               2
    3                      4
write=EF=BC=9A	78.8 MB/s 		39.38 MB/s 		27.7 MB/s		20.90 MB/s
read=EF=BC=9A	85.3 MB/s 		85.33 MB/s		78.77MB/s		78.77MB/s

I think if the replication strategy is splay or primary copy, not the
chain, as the thesis said,   writing speed for 3, 4 or even more
replication will be a little worse than  2 replication, should be near
with 39.38 MB/s.
But the write performance  I got is affect so much by size of replicati=
on.

What is the replication strategy in ceph-0.26, not splay?  If splay,
why not near with 39.38 MB/s?

There is 5 OSDs in 2 hosts, 2 in one and 3 int the other.

Thx!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
