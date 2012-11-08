From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: less cores more iops / speed
Date: Thu, 8 Nov 2012 07:21:15 +0100
Message-ID: <83FB14C0-B49B-4BD9-8B4F-D1D951723EE6@profihost.ag>
References: <509ADA6A.9000807@profihost.ag> <24E144B8C0207547AD09C467A8259F75577ED836@lisa.maurer-it.com> <38050270-7D4B-4026-9B34-18AC26A49F3F@profihost.ag> <24E144B8C0207547AD09C467A8259F75577ED8DA@lisa.maurer-it.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:43288 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab2KHGVU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 01:21:20 -0500
In-Reply-To: <24E144B8C0207547AD09C467A8259F75577ED8DA@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 08.11.2012 um 06:54 schrieb Dietmar Maurer <dietmar@proxmox.com>:

>> Why is vhost net driver involved here at all? Kvm guest only uses ssh here.
> 
> I though you are testing things (rdb) which depends on KVM network speed?

Kvm process uses librbd and both are running on host not in guest.

Stefan 

> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
