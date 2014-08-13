From: Huamin Chen <hchen@redhat.com>
Subject: assert failure
Date: Wed, 13 Aug 2014 16:29:19 -0400 (EDT)
Message-ID: <1229494305.20638287.1407961759048.JavaMail.zimbra@redhat.com>
References: <973721792.20638089.1407961733872.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:56510 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbaHMU3T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Aug 2014 16:29:19 -0400
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s7DKTJED016146
	for <ceph-devel@vger.kernel.org>; Wed, 13 Aug 2014 16:29:19 -0400
In-Reply-To: <973721792.20638089.1407961733872.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Is the following assert failure an known issue?

msg/Pipe.cc: In function 'int Pipe::connect()' thread 7fed3d2dd700 time 2014-08-13 16:26:06.039799
msg/Pipe.cc: 1070: FAILED assert(m)
 ceph version 0.80.1 (a38fe1169b6d2ac98b427334c12d7cf81f809b74)
 1: (Pipe::connect()+0x390e) [0x7feee89cf99e]
 2: (Pipe::writer()+0x511) [0x7feee89d0fd1]
 3: (Pipe::Writer::entry()+0xd) [0x7feee89d5d0d]
 4: (()+0x7df3) [0x7fef336cadf3]
 5: (clone()+0x6d) [0x7fef32fe63dd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
