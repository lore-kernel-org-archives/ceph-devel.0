From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph journal
Date: Thu, 01 Nov 2012 16:27:26 -0500
Message-ID: <5092E93E.7060302@inktank.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com> <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com> <CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com> <5091A06E.20407@kleijkers.nl> <CAJH6TXhwOxtT8XLWYMYiDQ=uFUtkv6CziR7vAFqSovZ_n1JORg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37649 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945957Ab2KAV1X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 17:27:23 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4194456iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 14:27:23 -0700 (PDT)
In-Reply-To: <CAJH6TXhwOxtT8XLWYMYiDQ=uFUtkv6CziR7vAFqSovZ_n1JORg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Stefan Kleijkers <stefan@kleijkers.nl>, Tren Blackburn <tren@eotnetworks.com>, ceph-devel@vger.kernel.org

On 11/01/2012 04:18 PM, Gandalf Corvotempesta wrote:
> 2012/10/31 Stefan Kleijkers <stefan@kleijkers.nl>:
>> As far as I know, this is correct. You get a ACK (on the write) back after
>> it landed on ALL three journals (or/and osds in case of BTRFS in parallel
>> mode). So If you lose one node, you still have it in two more nodes and they
>> will commit it to disk. After recovering the missing node/osd it will get
>> the data from one of the other nodes. So you won't lose any data.
>
> In this case I can suppose that ceph writing speed is relative to the
> journal's writing speed and never to ODS disks.
>

Eventually you will need to write all of that data out to disk and 
writes to the journal will have to stop to allow the underlying disk to 
catch up.  In cases like that you will often see performance going along 
seemingly speedily and then all of a sudden see long pauses and possibly 
chaotic performance characteristics.

> Let's assume a journal size of 150GB, capable to write at 200MB/s in a
> 2gbit/s network (lacp between two gigabit ports), no replica between
> OSDs and very very slow SATA disk (5400 RPM, for example, much slower
> than jurnal). Just a single osd.
> Ceph will write at 200MB/s, and in background it will flush journals
> to disk, right?

It will do that for a while, based on how you've tweaked the flush 
intervals and various journal settings to determine how much data ceph 
will allow to hang out in the journal while still accepting new requests.

>
> I can assume that journal is a buffer and RBD will write only to it.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

