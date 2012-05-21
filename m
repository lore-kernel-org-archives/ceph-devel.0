From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 22:19:30 +0200
Message-ID: <CAMvP8PC4k7LS6uT1O+HM=3zrpivW87NQt=Eco+Bd2DSRA+UE1w@mail.gmail.com>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro> <4FB8A3A5.5090809@profihost.ag>
 <CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
 <4FB8B1CE.1080803@icukhosting.co.uk> <CAJafhzQp1SeGZUdUL5XszaRw-0bU0f38r3ghLgmTvZrF0oB_=w@mail.gmail.com>
 <4FBA599F.5050000@profihost.ag> <CAMvP8PBSxybik20238UAX6TKfqGBb=wEqmFyEHk4fSAzU_Fjxg@mail.gmail.com>
 <4FBAA163.9040408@profihost.ag> <CAMvP8PDUvY9h=0onvob_ekA5GK9A-0thVqyJ7ETTen8mALj0Sw@mail.gmail.com>
 <4FBAA229.1050204@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51222 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab2EUUTv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:19:51 -0400
Received: by yhmm54 with SMTP id m54so4803787yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 13:19:50 -0700 (PDT)
In-Reply-To: <4FBAA229.1050204@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Linux boxes you may use output from iostat -x /dev/sda and connect
it it to any monitoring system like: zabbix or cacti :-)


On Mon, May 21, 2012 at 10:14 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Am 21.05.2012 22:13, schrieb Tomasz Paszkowski:
>
>> Just to clarify. You'd like to measure I/O on those system which are
>> currently running on physical machines ?
>
> IOPs not just I/O.
>
> Stefan



-- 
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
