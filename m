From: "Zhang, Jian" <jian.zhang@intel.com>
Subject: RE: Weekly performance meeting
Date: Fri, 26 Sep 2014 08:37:00 +0000
Message-ID: <51FC7A40FB29414D88A121A7FFEF9A4710F71A35@SHSMSX104.ccr.corp.intel.com>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
 <542514DE.6070807@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38215 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbaIZIhE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 04:37:04 -0400
In-Reply-To: <542514DE.6070807@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Loic,=20
Sorry for the confusion. We have observed up to ~20% EC performance deg=
radation and have some initial findings and want to have a discussion. =
=20

Thanks
Jian


-----Original Message-----
=46rom: Loic Dachary [mailto:loic@dachary.org]=20
Sent: Friday, September 26, 2014 3:25 PM
To: ceph-devel@vger.kernel.org; Zhang, Jian
Subject: Re: Weekly performance meeting

Hi,

I added a section to http://pad.ceph.com/p/performance_weekly about the=
 current efforts to optimize/benchmark erasure code plugins. @Zhang, Ji=
an : the ISA erasure code plugin Andreas Peters worked on is not mentio=
ned because it does not need any optimization, as far as I can tell ;-)=
=20

Cheers

On 25/09/2014 20:27, Sage Weil wrote:
> Hi everyone,
>=20
> A number of people have approached me about how to get more involved=20
> with the current work on improving performance and how to better=20
> coordinate with other interested parties.  A few meetings have taken=20
> place offline with good results but only a few interested parties wer=
e involved.
>=20
> Ideally, we'd like to move as much of this dicussion into the public
> forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't alway=
s=20
> sufficient, however.  I'd like to also set up a regular weekly meetin=
g=20
> using google hangouts or bluejeans so that all interested parties can=
=20
> share progress.  There are a lot of things we can do during the Hamme=
r=20
> cycle to improve things but it will require some coordination of effo=
rt.
>=20
> Among other things, we can discuss:
>=20
>  - observed performance limitations
>  - high level strategies for addressing them
>  - proposed patch sets and their performance impact
>  - anything else that will move us forward
>=20
> One challenge is timezones: there are developers in the US, China,=20
> Europe, and Israel who may want to join.  As a starting point, how=20
> about next Wednesday, 15:00 UTC?  If I didn't do my tz math wrong,=20
> that's
>=20
>   8:00 (PDT, California)
>  15:00 (UTC)
>  18:00 (IDT, Israel)
>  23:00 (CST, China)
>=20
> That is surely not the ideal time for everyone but it can hopefully b=
e=20
> a starting point.
>=20
> I've also created an etherpad for collecting discussion/agenda items=20
> at
>=20
> 	http://pad.ceph.com/p/performance_weekly
>=20
> Is there interest here?  Please let everyone know if you are actively=
=20
> working in this area and/or would like to join, and update the pad=20
> above with the topics you would like to discuss.
>=20
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
