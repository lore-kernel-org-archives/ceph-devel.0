From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph journal
Date: Sun, 4 Nov 2012 12:48:42 +0100
Message-ID: <CAJH6TXhwNRW+2bN3CZysNwZmKw4z8h5ARsPwzOz_wve2DPq78g@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
	<CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
	<CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
	<5091A06E.20407@kleijkers.nl>
	<CAJH6TXhwOxtT8XLWYMYiDQ=uFUtkv6CziR7vAFqSovZ_n1JORg@mail.gmail.com>
	<5092E93E.7060302@inktank.com>
	<CAJH6TXjp+eR1N7ZqAV6eZhLLDO58sx9cJVkqRYw7V43ZqBdBSA@mail.gmail.com>
	<CAPYLRzgV6jx9mf+EhYRm0RgUTc-v99Q39NTOMjHN=xte+c8G+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:50809 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab2KDLso (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 06:48:44 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so1905311eaa.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 03:48:43 -0800 (PST)
In-Reply-To: <CAPYLRzgV6jx9mf+EhYRm0RgUTc-v99Q39NTOMjHN=xte+c8G+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Stefan Kleijkers <stefan@kleijkers.nl>, Tren Blackburn <tren@eotnetworks.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/11/3 Gregory Farnum <greg@inktank.com>:
> No, of course it will flush data to the disk at the same time as it
> will take writes to the journal. However, if you have a 1GB journal
> that writes at 200MB/s and a backing disk that writes at 100MB/s, and
> you then push 200MB/s through long enough that the journal fills up,
> then you will slow down to writing at 100MB/s because that's as fast
> as Ceph can fill up the backing store, and the journal is no longer
> buffering.

Ok, now it's clear. But in case of a 100GB SSD, the journal size
should be enough to allow a proper write to disks
