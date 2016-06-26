From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RDS - for stateless messenger
Date: Sun, 26 Jun 2016 17:08:07 +0000
Message-ID: <DB5PR05MB1607E175D8ACBE9CE2B8DC0EA9200@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db3on0080.outbound.protection.outlook.com ([157.55.234.80]:63216
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751485AbcFZRIL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Jun 2016 13:08:11 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

*Background:*
As I wrote once I am considering messenger based on RDS protocol.
RDS protocol is datagram oriented like UDP; however, it is reliable and=
 in-order like TCP and it is much more efficient than both (in case the=
 underlying is RDMA).
See about RDS here - https://oss.oracle.com/pipermail/rds-devel/2007-No=
vember/000228.html

I am trying to convert AsyncMessenger to RDS. =A0The challenge is to co=
nvert from statefull connection to stateless connection (programmatical=
ly RDS is very much similar to UDP)

*Question:*
Async messenger starts each accepted socket with state=3DSTATE_ACCEPTIN=
G and then it expects handshake.
Unfortunately, stateless connections don't have the concept of "accept"=
; hence, I see two ways to recognize "accept" situations:
1. In case I am getting message from an address that doesn't exist in c=
onns/accepting_conns collections.
2. By adding special message that will indicate that this is an "accept=
 request" from a new client

I prefer option #2 if it is possible - the question is which message I =
can use for indicating "Accept request"? - I thought of sending an empt=
y datagram (without payload) for that purpose.=A0 Do you think this ide=
a will work?

TIA,
=A0 Avner

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
