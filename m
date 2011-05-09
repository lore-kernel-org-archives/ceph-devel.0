From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: replication write speed
Date: Sun, 8 May 2011 19:50:09 -0700
Message-ID: <BANLkTi=gkJcs9yxXVAMo9nrvz2J1yGhQ4w@mail.gmail.com>
References: <BANLkTimPZ0rNe2-edtahK4RHRMQZH52qBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47845 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1EICuL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 May 2011 22:50:11 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 5450FC066
	for <ceph-devel@vger.kernel.org>; Sun,  8 May 2011 19:50:11 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 02DAAC064
	for <ceph-devel@vger.kernel.org>; Sun,  8 May 2011 19:50:10 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1420601eyx.19
        for <ceph-devel@vger.kernel.org>; Sun, 08 May 2011 19:50:09 -0700 (PDT)
In-Reply-To: <BANLkTimPZ0rNe2-edtahK4RHRMQZH52qBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, May 8, 2011 at 7:43 PM, Simon Tian <aixt2006@gmail.com> wrote:
> Hi folks,
>
> =C2=A0 =C2=A0 =C2=A0I am testing the replication performance of ceph-=
0.26 with
> libceph, write 1G data in with ceph_write() and read it out with
> ceph_read(),
>
> rep_size =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2
> =C2=A0 =C2=A03 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A04
> write=EF=BC=9A =C2=A078.8 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 39.38 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02=
7.7 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 20.90 MB/s
> read=EF=BC=9A =C2=A0 85.3 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 85.33 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07=
8.77MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 78.77MB/s
>
> I think if the replication strategy is splay or primary copy, not the
> chain, as the thesis said, =C2=A0 writing speed for 3, 4 or even more
> replication will be a little worse than =C2=A02 replication, should b=
e near
> with 39.38 MB/s.
> But the write performance =C2=A0I got is affect so much by size of re=
plication.
>
> What is the replication strategy in ceph-0.26, not splay? =C2=A0If sp=
lay,
> why not near with 39.38 MB/s?
>
> There is 5 OSDs in 2 hosts, 2 in one and 3 int the other.

The replication strategy has been fixed at primary copy for several
years now. At expected replication levels (2-3) there just isn't a big
difference between the strategies, and limiting it to primary-copy
replication makes a lot of the bookkeeping for data safety much easier
to handle.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
