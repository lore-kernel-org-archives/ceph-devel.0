From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Designing a cluster guide
Date: Sun, 20 May 2012 10:27:10 +0200
Message-ID: <4FB8AADE.1000406@profihost.ag>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro> <4FB8A3A5.5090809@profihost.ag> <CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:38728 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab2ETI1J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 May 2012 04:27:09 -0400
In-Reply-To: <CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <christian@brunner-muc.de>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

Am 20.05.2012 10:19, schrieb Christian Brunner:
> - Cheap Object Storage (S3):
>
>    Many 3,5'' SATA Drives for the storage (probably in a RAID config)
>    A small and cheap SSD for the journal
>
> - Basic Block Storage (RBD):
>
>    Many 2,5'' SATA Drives for the storage (RAID10 and/or mutliple OSDs)
>    Small MaxIOPS SSDs for each OSD journal
>
> - High performance Block Storage (RBD)
>
>    Many large SATA SSDs for the storage (prbably in a RAID5 config)
>    stec zeusram ssd drive for the journal
That's exactly what i thought too but then you need a seperate ceph / 
rbd cluster for each type.

Which will result in a minimum of:
3x mon servers per type
4x osd servers per type
---

so you'll need a minimum of 12x osd systems and 9x mon systems.

Regards,
Stefan
