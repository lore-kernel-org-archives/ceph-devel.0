From: Dietmar Maurer <dietmar@proxmox.com>
Subject: RE: less cores more iops / speed
Date: Thu, 8 Nov 2012 05:54:18 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F75577ED8DA@lisa.maurer-it.com>
References: <509ADA6A.9000807@profihost.ag>
 <24E144B8C0207547AD09C467A8259F75577ED836@lisa.maurer-it.com>
 <38050270-7D4B-4026-9B34-18AC26A49F3F@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.maurer-it.com ([213.129.239.114]:55741 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab2KHFyW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 00:54:22 -0500
In-Reply-To: <38050270-7D4B-4026-9B34-18AC26A49F3F@profihost.ag>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Why is vhost net driver involved here at all? Kvm guest only uses ssh here.

I though you are testing things (rdb) which depends on KVM network speed?

