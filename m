From: Tim O'Donovan <tim@icukhosting.co.uk>
Subject: Re: Designing a cluster guide
Date: Sun, 20 May 2012 09:56:46 +0100
Message-ID: <4FB8B1CE.1080803@icukhosting.co.uk>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro> <4FB8A3A5.5090809@profihost.ag> <CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp4.interdns.co.uk ([83.170.124.68]:60402 "HELO
	smtp4.interdns.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751609Ab2ETJDa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 May 2012 05:03:30 -0400
In-Reply-To: <CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> - High performance Block Storage (RBD)
> 
>   Many large SATA SSDs for the storage (prbably in a RAID5 config)
>   stec zeusram ssd drive for the journal

How do you think standard SATA disks would perform in comparison to
this, and is a separate journaling device really necessary?

Perhaps three servers, each with 12 x 1TB SATA disks configured in
RAID10, an osd on each server and three separate mon servers.

Would this be suitable for the storage backend for a small OpenStack
cloud, performance wise, for instance?


Regards,
Tim O'Donovan
