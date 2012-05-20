From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Designing a cluster guide
Date: Sun, 20 May 2012 11:24:49 +0200
Message-ID: <31FA88A8-7442-4F24-87D0-713972D58481@profihost.ag>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro> <4FB8A3A5.5090809@profihost.ag> <CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com> <4FB8B1CE.1080803@icukhosting.co.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45938 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab2ETJY4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 May 2012 05:24:56 -0400
In-Reply-To: <4FB8B1CE.1080803@icukhosting.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim O'Donovan <tim@icukhosting.co.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 20.05.2012 um 10:56 schrieb Tim O'Donovan <tim@icukhosting.co.uk>:

>> - High performance Block Storage (RBD)
>> 
>>  Many large SATA SSDs for the storage (prbably in a RAID5 config)
>>  stec zeusram ssd drive for the journal
> 
> How do you think standard SATA disks would perform in comparison to
> this, and is a separate journaling device really necessary?
> 
> Perhaps three servers, each with 12 x 1TB SATA disks configured in
> RAID10, an osd on each server and three separate mon servers.
> 
He's talking about ssd's not normal sata disks.

Stefan
