From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: less cores more iops / speed
Date: Thu, 8 Nov 2012 06:49:57 +0100
Message-ID: <38050270-7D4B-4026-9B34-18AC26A49F3F@profihost.ag>
References: <509ADA6A.9000807@profihost.ag> <24E144B8C0207547AD09C467A8259F75577ED836@lisa.maurer-it.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42519 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2KHFuA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 00:50:00 -0500
In-Reply-To: <24E144B8C0207547AD09C467A8259F75577ED836@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 08.11.2012 um 06:42 schrieb Dietmar Maurer <dietmar@proxmox.com>:

>> I've noticed something really interesting.
>> 
>> I get 5000 iops / VM for rand. 4k writes while assigning 4 cores on a
>> 2.5 Ghz Xeon.
>> 
>> When i move this VM to another kvm host with 3.6Ghz i get 8000 iops (still 8
>> cores) when i then LOWER the assigned cores from 8 to 4 i get
>> 14.500 iops. If i assign only 2 cores i get 16.000 iops...
>> 
>> Why does less kvm cores mean more speed?
> 
> There is a serious bug in the kvm vhost code. Do you use virtio-net with vhost?
> 
> see: http://lists.nongnu.org/archive/html/qemu-devel/2012-11/msg00579.html
> 
> Please test using the e1000 driver instead.

Why is vhost net driver involved here at all? Kvm guest only uses ssh here.

Stefan
