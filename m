From: James Harper <james.harper@bendigoit.com.au>
Subject: ceph and scsi reservation-like locking
Date: Sun, 29 Dec 2013 02:34:23 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B68567948@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:38939 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab3L2Ce1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Dec 2013 21:34:27 -0500
Received: from bitcom1.int.sbss.com.au ([2002:cb10:e0fe:201:a5ca:4fd3:14f:ad5d])
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1Vx6Cu-0007iK-Lz
	for ceph-devel@vger.kernel.org; Sun, 29 Dec 2013 13:34:24 +1100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Is the rbd locking feature-compatible with scsi3 persistent reservations?

To use ceph as a storage backend for a Hyper-V cluster directly (rather than through an iscsi gateway), it looks like I'll need a virtual scsi3 device that supports persistent reservations.

Thanks

James
