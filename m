From: Joshua Schmid <jschmid@suse.de>
Subject: Re: osd dm-crypt key management, seconde partie
Date: Fri, 26 Feb 2016 11:54:47 +0100
Message-ID: <56D02EF7.60703@suse.de>
References: <56CD9E7A.2050901@dachary.org>
 <alpine.DEB.2.11.1602241733260.7555@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45160 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135AbcBZKtO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Feb 2016 05:49:14 -0500
In-Reply-To: <alpine.DEB.2.11.1602241733260.7555@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 02/24/2016 11:35 PM, Sage Weil wrote:
> On Wed, 24 Feb 2016, Loic Dachary wrote:
>> Hi,
>>
>> A first implementation[1] of the key management scheme[2] was comple=
ted=20
>> today (it passes tests, integration and make check). While work is d=
one=20
>> to add tests to verify legacy key storage support, it would be great=
 to=20
>> get reviews and feedback. There is little time before the jewel merg=
e=20
>> window closes: now would be a perfect time to catch blockers :-)
>=20
> Great!  I skimmed the patchset (on my phone) and it looked clean and =
sane=20
> to me.  Joshua, maybe you can take a look at make sure this approach =
meets=20
> your needs as well?

Looks good to me! I'm pretty sure this will fit.
Thanks for the effort.

>=20
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
=46reundliche Gr=FC=DFe - Kind regards,
Joshua Schmid
SUSE Enterprise Storage
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 N=FCrnberg
-----------------------------------------------------------------------=
---------------------------------------------
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard,
Jennifer Guild, Dilip Upmanyu, Graham Norton, HRB 21284 (AG N=FCrnberg)
-----------------------------------------------------------------------=
---------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
