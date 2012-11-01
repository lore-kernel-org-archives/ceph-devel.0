From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph journal
Date: Thu, 1 Nov 2012 22:18:29 +0100
Message-ID: <CAJH6TXhwOxtT8XLWYMYiDQ=uFUtkv6CziR7vAFqSovZ_n1JORg@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
	<CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
	<CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
	<5091A06E.20407@kleijkers.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:49109 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab2KAVSa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 17:18:30 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1144647eaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 14:18:29 -0700 (PDT)
In-Reply-To: <5091A06E.20407@kleijkers.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Kleijkers <stefan@kleijkers.nl>
Cc: Tren Blackburn <tren@eotnetworks.com>, ceph-devel@vger.kernel.org

2012/10/31 Stefan Kleijkers <stefan@kleijkers.nl>:
> As far as I know, this is correct. You get a ACK (on the write) back after
> it landed on ALL three journals (or/and osds in case of BTRFS in parallel
> mode). So If you lose one node, you still have it in two more nodes and they
> will commit it to disk. After recovering the missing node/osd it will get
> the data from one of the other nodes. So you won't lose any data.

In this case I can suppose that ceph writing speed is relative to the
journal's writing speed and never to ODS disks.

Let's assume a journal size of 150GB, capable to write at 200MB/s in a
2gbit/s network (lacp between two gigabit ports), no replica between
OSDs and very very slow SATA disk (5400 RPM, for example, much slower
than jurnal). Just a single osd.
Ceph will write at 200MB/s, and in background it will flush journals
to disk, right?

I can assume that journal is a buffer and RBD will write only to it.
