From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: ErasureCode base class
Date: Tue, 5 Aug 2014 08:30:27 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7585BB@CERNXCHG43.cern.ch>
References: <53E08D8D.1010303@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:35053 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738AbaHEIaa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 04:30:30 -0400
In-Reply-To: <53E08D8D.1010303@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20
looks very good and removes all the duplication!=20

I will then do the cache modification against this code base including =
this pull request.

Cheers Andreas.
________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 05 August 2014 09:53
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: ErasureCode base class

Hi,

Would you have time to review the ErasureCode base class at https://git=
hub.com/ceph/ceph/pull/2201 ? It factorizes code that is common to Eras=
ureCodeJerasure and ErasureCodeIsa. While doing so it really helped tha=
t you wrote the ErasureCodeIsa decode functions with only minimal chang=
es compared to those in ErasureCodeJerasure. Thanks for that :-)

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
