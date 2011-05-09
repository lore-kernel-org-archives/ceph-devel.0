From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: replication write speed
Date: Sun, 8 May 2011 20:31:40 -0700
Message-ID: <BANLkTinaWG5W+HzvF9G=0U7Q48jk9fCkCw@mail.gmail.com>
References: <BANLkTimPZ0rNe2-edtahK4RHRMQZH52qBw@mail.gmail.com>
	<BANLkTi=gkJcs9yxXVAMo9nrvz2J1yGhQ4w@mail.gmail.com>
	<BANLkTinznnde+t8sLSMT3rMmN6tyQ5Z-Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58362 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab1EIDbn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 May 2011 23:31:43 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 162D1C067
	for <ceph-devel@vger.kernel.org>; Sun,  8 May 2011 20:31:43 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id B94AFC065
	for <ceph-devel@vger.kernel.org>; Sun,  8 May 2011 20:31:42 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1425950ewy.19
        for <ceph-devel@vger.kernel.org>; Sun, 08 May 2011 20:31:41 -0700 (PDT)
In-Reply-To: <BANLkTinznnde+t8sLSMT3rMmN6tyQ5Z-Bw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, May 8, 2011 at 8:04 PM, Simon Tian <aixt2006@gmail.com> wrote:
> For primary copy, I think when the replication size is 3, 4, or even
> more, the writing speed should also near with 2 replication. Because
> the 2nd, 3rd, 4th, ... replication are written parallelly. =A0The spe=
ed
> I got for 3, 4 replication is not near with the speed of 2, in fact,
> like linear reduce.
You're hitting your network limits there. With primary copy then the
primary needs to send out the data to each of the replicas, which caps
the write speed at (network bandwidth) / (num replicas). Presumably
you're using a gigabit network (or at least your nodes have gigabit
connections):
1 replica: ~125MB/s (really a bit less due to protocol overhead)
2 replicas:~62MB/s
3 replicas: ~40MB/s
4 replicas: ~31MB/s
etc.
Of course, you can also be limited by the speed of your disks (don't
forget to take journaling into account); and your situation is further
complicated by having multiple daemons per physical node. But I
suspect you get the idea. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
