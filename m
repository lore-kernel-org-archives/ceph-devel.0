From: Wido den Hollander <wido@pcextreme.nl>
Subject: Performance scaling with multiple OSD's
Date: Sun, 27 Jun 2010 11:39:04 +0200
Message-ID: <1277631544.2291.10.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:33574 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab0F0JjK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Jun 2010 05:39:10 -0400
Received: from zarafa.pcextreme.nl (zarafa.pcextreme.nl [79.99.135.237])
	by support.pcextreme.nl (Postfix) with ESMTP id 9D78A841FC
	for <ceph-devel@vger.kernel.org>; Sun, 27 Jun 2010 11:39:05 +0200 (CEST)
Received: from [79.99.132.153] (unknown [79.99.132.153])
	by zarafa.pcextreme.nl (Postfix) with ESMTPSA id 5D18460000B1
	for <ceph-devel@vger.kernel.org>; Sun, 27 Jun 2010 11:39:07 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Although much of this has been discussed at IRC, i thought it might me
helpfull to post it at the ml so i can be found easily.

In my Ceph cluster i was experiencing a performance problem, which afte=
r
some tests was due to a number of OSD's which had some disk I/O
problems.

At the moment i have 4 OSD's which all get performance of roughly
55MB/sec (ceph osd bench), where the journal and data is on the same
disk (seperate partition though).

Now i'm seeing about 50MB/sec with the rados benchmarks, which seem
fine, but as i have 4 OSD's i expected to get a performance of about
100MB/sec (since my replication level is at two).

The question is, how does Ceph scale? Will a single writer thread be
limited to the performance of one OSD and will i get a higher
performance when multiple threads are started?

Can a dev shed some light on this topic?

=46or the reference, you can benchmark your OSD with: ceph osd tell 0
bench

Make sure you have "ceph -w" running somewhere so you can see the
result.

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
