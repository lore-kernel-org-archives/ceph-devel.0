From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Implied parity and erasure code
Date: Sat, 10 May 2014 18:40:34 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE704806@CERNXCHG42.cern.ch>
References: <536CF5BA.8040300@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:7005 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbaEJSpu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 May 2014 14:45:50 -0400
In-Reply-To: <536CF5BA.8040300@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20
I think it is good to have the flexibility to include the global parity=
 stripes in local subgroups or as in the picture to make a subgroup out=
 of the global parities and compute a local paritiy for them. Although =
with the chosen parameters these local subgroups are not symmetric (5,5=
 and 4 chunks per group)  but e.g. for 8+4 one would have 3 symmetric l=
ocal groups as drawn and if you project is on a three data center setup=
 you would like to have for each center a local parity.=20

But wasn't this already possible with your prototype implementation?

Cheers Andreas.



________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 09 May 2014 17:35
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Implied parity and erasure code

Hi Andreas,

The "implied parity bloc" mentionned page 4 of http://anrg.usc.edu/~mah=
eswaran/Xorbas.pdf is something we've not discussed in the context of t=
he implementation of the pyramid erasure code plugin. I'm not sure if i=
t would be useful to have. Do you have an opinion ?

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
