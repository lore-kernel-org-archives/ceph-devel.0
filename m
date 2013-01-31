From: =?iso-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>
Subject: Geo-replication with RBD
Date: Thu, 31 Jan 2013 07:42:11 +0100
Message-ID: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from onsmg01.portal.onet.pl ([213.180.147.237]:60771 "EHLO
	onsmg01.portal.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab3AaGrT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 01:47:19 -0500
Content-Language: pl-PL
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I make new thread, because i think it's a diffrent case.

We have managed async geo-replication of s3 service, beetwen two ceph clusters in two DC's, and to amazon s3 as third. All this via s3 API. I love to see native RGW geo-replication with described features in another thread.

There is another case. What about RBD replication ?? It's much more complicated, and for disaster recovery much more important, just like in enterprise storage arrays.
One cluster in two DC's, not solving problem, because we need security in data consistency, and isolation. 
Do you thinking about this case ?? 

Regards
Slawomir Skowron