From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Mon, 23 Sep 2013 09:37:35 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A5273619@PLOXCHG03.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>,<523FED54.8040208@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx32.cern.ch ([137.138.144.178]:20820 "EHLO
	CERNMX32.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab3IWJhk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 05:37:40 -0400
In-Reply-To: <523FED54.8040208@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,
I suggest still one tiny change, since if in.length does not need align=
ment, you still increase the in-length by the value of alignment:
=20
   unsigned alignment =3D get_alignment();
-  unsigned in_length =3D in.length() + alignment - ( in.length() % ali=
gnment );
+ unsigned tail =3D in.length()%alignment;=20
+ unsigned in_length =3D in.length() + tail?(alignment - tail):0;

Cheers Andreas.


______________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 23 September 2013 09:27
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: CEPH Erasure Encoding + OSD Scalability

Hi Andreas,

Very inefficient implementation indeed :-) I've integrated your change =
in

https://github.com/ceph/ceph/pull/619

Cheers

On 23/09/2013 01:00, Andreas Joachim Peters wrote:
>   alignment =3D k*w*packetsize*sizeof(int);
>   in_length +=3D (alignment - (in_length%alignment);

--
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do no=
thing.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
