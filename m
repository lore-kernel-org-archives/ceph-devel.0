From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: considering AsyncMessenger variant over RDS (RDMA and/or TCP)
Date: Thu, 16 Jun 2016 11:31:49 +0000
Message-ID: <DB5PR05MB160730A88C01615EC3ED3B98A9560@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-am1on0059.outbound.protection.outlook.com ([157.56.112.59]:44486
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753256AbcFPLqU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2016 07:46:20 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I am at a preliminary phase of considering writing of an additional optional Messenger based on RDS - Reliable Datagram Sockets technology .

You may learn about RDS here:
    http://linux.die.net/man/7/rds
    https://www.kernel.org/doc/Documentation/networking/rds.txt
    https://oss.oracle.com/pipermail/rds-devel/2007-November/000228.html

Since, RDS supports socket API, it should be relatively simple to create AsyncMessenger variant that is based on RDS sockets instead of TCP sockets (though, RDS is datagram oriented and not stream oriented).

Questions:
    1. Do you know if somebody is already working on this subject?
    2. Do you have any comments for me?

TIA,
  Avner

