From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Designing a cluster guide
Date: Tue, 29 May 2012 09:50:40 -0700
Message-ID: <CADvuQRGkf8AfQN_0-7G9ASsMX8GKsXuzeRMt9Hx2b=1z2cXLdA@mail.gmail.com>
References: <4FB75BAD.3080709@profihost.ag> <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
 <CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
 <CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
 <7111C6286D862F43B94FD6291D8989158644DD@EX01.onqtel.local>
 <CAPYLRzgyyW5N894X1T=-gNyRdPmu-+VDr0=NuuLVEs93nGJZbw@mail.gmail.com>
 <7111C6286D862F43B94FD6291D898915864560@EX01.onqtel.local>
 <7111C6286D862F43B94FD6291D89891586456D@EX01.onqtel.local>
 <6670030640068667781@unknownmsgid> <7111C6286D862F43B94FD6291D898915868504@EX01.onqtel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64869 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab2E2QvC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 12:51:02 -0400
Received: by dady13 with SMTP id y13so5667457dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:51:02 -0700 (PDT)
In-Reply-To: <7111C6286D862F43B94FD6291D898915868504@EX01.onqtel.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Quenten Grasso <QGrasso@onq.com.au>
Cc: Slawomir Skowron <szibis@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 29, 2012 at 12:25 AM, Quenten Grasso <QGrasso@onq.com.au> wrote:
> So if we have 10 nodes vs. 3 nodes with the same mount of disks we should see better write and read performance as you would have less "overlap".

First of all, a typical way to run Ceph is with say 8-12 disks per
node, and an OSD per disk. That means your 3-10 node clusters actually
have 24-120 OSDs on them. The number of physical machines is not
really a factor, number of OSDs is what matters.

Secondly, 10-node or 3-node clusters are fairly uninteresting for
Ceph. The real challenge is at the hundreds, thousands and above
range.

> Now we take BTRFS into the picture as I understand journals are not necessary due to the nature of the way it writes/snapshots and reads data this alone would be a major performance increase on a BTRFS Raid level (like ZFS RAIDZ).

A journal is still needed on btrfs, snapshots just enable us to write
to the journal in parallel to the real write, instead of needing to
journal first.
