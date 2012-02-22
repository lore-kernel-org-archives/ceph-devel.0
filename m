From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Performance test on Ceph cluster
Date: Wed, 22 Feb 2012 10:42:12 -0800
Message-ID: <CAORUGqC4Nof1d0V1K-ntNuRMh6c27AC+cB67HCxsKR-fWa+qPg@mail.gmail.com>
References: <loom.20120222T102830-526@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49079 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab2BVSmd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2012 13:42:33 -0500
Received: by werb13 with SMTP id b13so239976wer.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 10:42:32 -0800 (PST)
In-Reply-To: <loom.20120222T102830-526@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 22, 2012 at 01:39, madhusudhana
<madhusudhana.u.acharya@gmail.com> wrote:
> Hi
> I have finally configured a ceph cluster with 8 nodes. I have 2 MDS
> servers and 3 monitors and rest of 3 nodes are OSD. Each system has
> 2T SATA drives. I have 3 partitions created, one for root file
> system, another for CEPH journal and the rest of the space is for
> OSD. I was able to get 5.6T space from three nodes.
>
> All the machines are of same type (HP DL160 G7) with 48 of RAM and
> quad core dual cpu's.
>
> I am using iozone for testing the performance against NetApp filer
> Below is the command what I am using for iozone test
>
> /opt/iozone/bin/iozone -R -e -l i -u 1 -r 4096k -s 1024m -F /mnt/ceph-
> test/ceph.iozone

1. Make sure you have only 1 active MDS, multi-MDS is an extra
complication you're better skipping right now.
2. What underlying filesystem are you using for the OSDs?
3. What Linux kernel version is running on the OSDs?
4. What machine is the client, running iozone? How is it connected to
the others? Kernel client or FUSE?
5. What Linux kernel version is running on the client?

Going forward, in a setup like that you could put OSDs on the machines
that run ceph-mon; ceph-mon is very lightweight and doesn't need
dedicated machines in a small setup.
