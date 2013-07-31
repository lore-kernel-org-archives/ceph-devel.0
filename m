From: Luke Jing Yuan <jyluke@mimos.my>
Subject: RE: [ceph-users] Problem with MON after reboot
Date: Wed, 31 Jul 2013 11:04:00 +0000
Message-ID: <E0E280CCE0E1A44898C992A9190D929A4F9D01@MBX02-TPM.mimos.local>
References: <E0E280CCE0E1A44898C992A9190D929A4F9C66@MBX02-TPM.mimos.local>
 <51F8E67A.90508@mermaidconsulting.dk>
 <E0E280CCE0E1A44898C992A9190D929A4F9CB1@MBX02-TPM.mimos.local>
 <51F8E8E2.4040702@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from imperial.mimos.my ([192.228.137.109]:54053 "EHLO
	IMPERIAL.MIMOS.MY" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab3GaLEE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 07:04:04 -0400
In-Reply-To: <51F8E8E2.4040702@mermaidconsulting.dk>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,

Actually I am not sure if the upgrade (I am using Ubuntu 12.04) actuall=
y will restart the daemon as a result of that I tried rebooting one of =
them first.

However, in a previous situation I had (while all of them were still ru=
nning the older 0.61.4). Rebooting the same MON, did not restore the qu=
orum also, so I am not sure what may cause this but I supposed it maybe=
 some other reasons.

Anyway I had tried your advice and reboot all the MONs again and the qu=
orum seemed to be back up again. Thanks.

Regards,
Luke

-----Original Message-----
=46rom: Jens Kristian S=F8gaard [mailto:jens@mermaidconsulting.dk]=20
Sent: Wednesday, 31 July, 2013 6:37 PM
To: Luke Jing Yuan
Cc: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
Subject: Re: [ceph-users] Problem with MON after reboot

Hi,

> This happened to me twice actually. Once before I upgraded, using
> 0.61.4 (I solved it by removing the MON and then recreating it) and=20
> this time after upgrading all nodes to 0.61.7. The surprising thing t=
o=20
> me is that the node is also running OSD as well but after the upgrade=
=20
> and reboot, the cluster is able to pick the OSD portion up but not th=
e=20
> MON.

So you say you've upgraded all nodes to 0.61.7 and then restarted one, =
and this happened?

Have you restarted the other mons after you upgraded to 0.61.7, or are =
they still running an older version?

It could be you simply need to restart the two other mons to fix the pr=
oblem.

--
Jens Kristian S=F8gaard, Mermaid Consulting ApS, jens@mermaidconsulting=
=2Edk, http://www.mermaidconsulting.com/

------------------------------------------------------------------
-
-
DISCLAIMER:=20

This e-mail (including any attachments) is for the addressee(s)=20
only and may contain confidential information. If you are not the=20
intended recipient, please note that any dealing, review,=20
distribution, printing, copying or use of this e-mail is strictly=20
prohibited. If you have received this email in error, please notify=20
the sender  immediately and delete the original message.=20
MIMOS Berhad is a research and development institution under=20
the purview of the Malaysian Ministry of Science, Technology and=20
Innovation. Opinions, conclusions and other information in this e-
mail that do not relate to the official business of MIMOS Berhad=20
and/or its subsidiaries shall be understood as neither given nor=20
endorsed by MIMOS Berhad and/or its subsidiaries and neither=20
MIMOS Berhad nor its subsidiaries accepts responsibility for the=20
same. All liability arising from or in connection with computer=20
viruses and/or corrupted e-mails is excluded to the fullest extent=20
permitted by law.


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
