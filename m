From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Hitchhiker erasure code
Date: Fri, 20 Mar 2015 13:11:15 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE8CFBAE@CERNXCHG43.cern.ch>
References: <550BF72E.6030406@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4AE8CF7E2@CERNXCHG43.cern.ch>,<550C15BB.9090305@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx12.cern.ch ([188.184.36.48]:14437 "EHLO CERNMX12.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbCTNLS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Mar 2015 09:11:18 -0400
In-Reply-To: <550C15BB.9090305@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,=20

the XOR+ is more generic with Jerasure because the ISA library does not=
 create an invertible matrix for M>4 in all cases. I measured a tiny ad=
vantage for the Intel library encoding/decoding speed for given K/M val=
ues and given hardware, but Dan did some measurements in a real cluster=
 and you cannot see any difference on a global scale between a jerasure=
 or isa configuration (8,4) with our hardware. The EC computation does =
not define the base line performance in that case.

So, this is more a general question ... but I am sure it is simpler to =
implement that within a plug-in rather than on top of N plug-ins ...

Cheers Andreas.


________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 20 March 2015 13:42
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: Hitchhiker erasure code

On 20/03/2015 13:37, Andreas Joachim Peters wrote:
> Hi Loic,
> I looked at that some time ago.
>
> Table 1 in the paper says it all:
>
> If you care about decoding and reconstruction of data it gives a good=
 improvement.
> If you care mainly about encoding speed, it is not the optimal choice=
 (+72.1%).
>
> The algorithm optimizes the reconstruction of data units. This is rel=
evant if your read-size is typically smaller than the block-size e.g. y=
ou encode 4 MB objects and you read 4kb pages. With normal EC you get a=
 read amplification of K*4k if a data stripe is down, while with hitchh=
iker you get only 2/3 of that traffic in case of (10,4).
>
> The most interesting to implement is probably Hitchhiker-XOR+, which =
you have to combine with a Vandermonde matrix, it requires that the fir=
st parity is just the xor of all data chunks.
>
> So, yes, there is certainly a benefit in implementing that compared t=
o other approaches (Xorbas,LRC) since it does not involve a space overh=
ead and opens the door to use larger K values and save space!
>

That sounds appealing :-) Do you think it would be more relevant to imp=
lement this as an additional Ceph plugin ? Or as a new jerasure techniq=
ue ?

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
