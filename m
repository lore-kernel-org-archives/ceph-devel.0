From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: Designing a cluster guide
Date: Sun, 20 May 2012 10:19:33 +0200
Message-ID: <CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
	<4FB8A3A5.5090809@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36337 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab2ETITe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 May 2012 04:19:34 -0400
Received: by obbtb18 with SMTP id tb18so6405321obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 01:19:33 -0700 (PDT)
In-Reply-To: <4FB8A3A5.5090809@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

2012/5/20 Stefan Priebe <s.priebe@profihost.ag>:
> Am 19.05.2012 18:15, schrieb Alexandre DERUMIER:
>
>> Hi,
>>
>> For your journal , if you have money, you can use
>>
>> stec zeusram ssd drive. (around 2000=80 /8GB / 100000 iops read/writ=
e with
>> 4k block).
>> I'm using them with zfs san, they rocks for journal.
>> http://www.stec-inc.com/product/zeusram.php
>>
>> another interessesting product is ddrdrive
>> http://www.ddrdrive.com/
>
>
> Great products but really expensive. The question is do we really nee=
d this
> in case of rbd block device.

I think it depends, what you are planning to do. I was calculating
different storage type for our cloud solution lately. I think that
there are three different types that make sense (at least for us):

- Cheap Object Storage (S3):

  Many 3,5'' SATA Drives for the storage (probably in a RAID config)
  A small and cheap SSD for the journal

- Basic Block Storage (RBD):

  Many 2,5'' SATA Drives for the storage (RAID10 and/or mutliple OSDs)
  Small MaxIOPS SSDs for each OSD journal

- High performance Block Storage (RBD)

  Many large SATA SSDs for the storage (prbably in a RAID5 config)
  stec zeusram ssd drive for the journal

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
