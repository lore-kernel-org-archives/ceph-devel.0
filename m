From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph journal
Date: Sat, 3 Nov 2012 18:29:02 +0100
Message-ID: <CAPYLRzgV6jx9mf+EhYRm0RgUTc-v99Q39NTOMjHN=xte+c8G+A@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
	<CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
	<CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
	<5091A06E.20407@kleijkers.nl>
	<CAJH6TXhwOxtT8XLWYMYiDQ=uFUtkv6CziR7vAFqSovZ_n1JORg@mail.gmail.com>
	<5092E93E.7060302@inktank.com>
	<CAJH6TXjp+eR1N7ZqAV6eZhLLDO58sx9cJVkqRYw7V43ZqBdBSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48787 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab2KCR3C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 13:29:02 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6358606iea.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 10:29:02 -0700 (PDT)
In-Reply-To: <CAJH6TXjp+eR1N7ZqAV6eZhLLDO58sx9cJVkqRYw7V43ZqBdBSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Stefan Kleijkers <stefan@kleijkers.nl>, Tren Blackburn <tren@eotnetworks.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 1, 2012 at 10:33 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2012/11/1 Mark Nelson <mark.nelson@inktank.com>:
>> It will do that for a while, based on how you've tweaked the flush intervals
>> and various journal settings to determine how much data ceph will allow to
>> hang out in the journal while still accepting new requests.
>
> Ceph is not able to write to both journal and disks simultaneously?
> For example, by using SSD for operating system and journal, we will be
> able to have not least than 100GB of journal that is a large amount of
> data wrote at SSD speed.
>
> When ceph has to flush this data to disks, will stop to write more
> data to journal?

No, of course it will flush data to the disk at the same time as it
will take writes to the journal. However, if you have a 1GB journal
that writes at 200MB/s and a backing disk that writes at 100MB/s, and
you then push 200MB/s through long enough that the journal fills up,
then you will slow down to writing at 100MB/s because that's as fast
as Ceph can fill up the backing store, and the journal is no longer
buffering.
-Greg
