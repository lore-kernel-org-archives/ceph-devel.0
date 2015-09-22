From: "Lakis, Jacek" <jacek.lakis@intel.com>
Subject: OSD::op_is_discardable condition doubled
Date: Tue, 22 Sep 2015 11:47:02 +0000
Message-ID: <90EABA838E32E141BC06296A2C40520A1A62D80F@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58320 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbbIVLrH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 07:47:07 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ceph-devel!
We're checking OSD::op_is_discardable condition two times: in dispatche=
r (handle_op) and in worker threads (do_request->can_discard_request->c=
an_discard_op)

=A0 if (!op->get_connection()->is_connected() &&
=A0=A0=A0=A0=A0 op->get_version().version =3D=3D 0) {
=A0=A0=A0 return true;
=A0 }

Is there any purpose to do this? If not, which of those should be remov=
ed in your opinion? If condition in handle_op will remain, OP won't pas=
s to the worker threads through the prioritized queue. On the other han=
d, leaving it in do_request will parallelize this check (I started para=
llelizing in PR 5211).=20

Regards,
JJ

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
