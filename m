From: "Lakis, Jacek" <jacek.lakis@intel.com>
Subject: Kernel client OSD message version
Date: Thu, 19 Nov 2015 09:04:10 +0000
Message-ID: <90EABA838E32E141BC06296A2C40520A1A653D55@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10072 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757047AbbKSJEM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 04:04:12 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers!

Recently, the version of OSDOp in Ceph increased to version 7 (in maste=
r, 6 in infernalis). Kernel client still encoding version 4.
Should we consider upstreaming patches to the client?=20

Thanks,
J. J. =A3akis

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII =
Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-=
07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adre=
sata i moze zawierac informacje poufne. W razie przypadkowego otrzymani=
a tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuni=
ecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for t=
he sole use of the intended recipient(s). If you are not the intended r=
ecipient, please contact the sender and delete all copies; any review o=
r distribution by
others is strictly prohibited.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
