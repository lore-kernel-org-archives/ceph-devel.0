From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph journal
Date: Thu, 1 Nov 2012 22:33:23 +0100
Message-ID: <CAJH6TXjp+eR1N7ZqAV6eZhLLDO58sx9cJVkqRYw7V43ZqBdBSA@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
	<CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
	<CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
	<5091A06E.20407@kleijkers.nl>
	<CAJH6TXhwOxtT8XLWYMYiDQ=uFUtkv6CziR7vAFqSovZ_n1JORg@mail.gmail.com>
	<5092E93E.7060302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:33469 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759887Ab2KAVdY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 17:33:24 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1148959eaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 14:33:23 -0700 (PDT)
In-Reply-To: <5092E93E.7060302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Kleijkers <stefan@kleijkers.nl>, Tren Blackburn <tren@eotnetworks.com>, ceph-devel@vger.kernel.org

2012/11/1 Mark Nelson <mark.nelson@inktank.com>:
> It will do that for a while, based on how you've tweaked the flush intervals
> and various journal settings to determine how much data ceph will allow to
> hang out in the journal while still accepting new requests.

Ceph is not able to write to both journal and disks simultaneously?
For example, by using SSD for operating system and journal, we will be
able to have not least than 100GB of journal that is a large amount of
data wrote at SSD speed.

When ceph has to flush this data to disks, will stop to write more
data to journal?
