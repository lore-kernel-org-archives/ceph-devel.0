From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: AsyncMessenger maturity
Date: Wed, 15 Jun 2016 17:55:11 +0000
Message-ID: <DB5PR05MB160725A2A9228123780F67CFA9550@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-am1on0085.outbound.protection.outlook.com ([157.56.112.85]:17300
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751035AbcFOSKV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2016 14:10:21 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

I tried to evaluate AsyncMessenger (together with its sub classes) and =
I found its code great in my eyes. Still, when using it at runtime, Cep=
h will warn you that this module is dangerous.

*I have two questions:*
1. Considering pros and cons, are there any cons when using AsyncMessen=
ger instead of SimpleMessenger (like stability, or cpu/memory consumpti=
on, .)

2. I am considering a variant of AsyncMessenger that might require that=
 both sides will be same messenger, I wonder, is it possible to use Asy=
ncMessenger for private network between OSDs only and to remain with Si=
mpleMessenger for all other messengers (for example, by just changing t=
he lines that creates the 6 Messengers in ceph_osd.cc::main)=20

TIA,
=A0 Avner

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
