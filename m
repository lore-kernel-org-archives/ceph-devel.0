From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next infernalis release v9.2.1
Date: Sat, 13 Feb 2016 08:33:51 +0700
Message-ID: <56BE87FF.3080307@dachary.org>
References: <CAP3mxSwYvhDwi8Bzd3DSUAph+7Cchmtjw-QqtsDgkoN-CBkAjw@mail.gmail.com>
 <CAJ4mKGaWYit3X2j8bhsZyiG2ODUinAmTjbS6W3uVzHwALHG4Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36442 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbcBMBeD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Feb 2016 20:34:03 -0500
In-Reply-To: <CAJ4mKGaWYit3X2j8bhsZyiG2ODUinAmTjbS6W3uVzHwALHG4Mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 13/02/2016 01:13, Gregory Farnum wrote:
> On Thu, Feb 11, 2016 at 11:36 PM, Abhishek Varshney
> <abhishek.varshney@flipkart.com> wrote:
>> Hi Greg,
>>
>> The next infernalis release as found at
>> https://github.com/ceph/ceph/tree/infernalis passed most of the Ceph=
=46S
>> suite ( http://tracker.ceph.com/issues/13750#note-19 ) except for 1
>> failure, which was not seen at a later run (
>> http://tracker.ceph.com/issues/13750#note-26 ). Do you think the
>> infernalis branch is ready for QE to start their own round of testin=
g
>> ?
>=20
> Uh, assuming I'm reading this correctly, you've hit a known
> intermittent bug which happened to show up on one run, but not the
> next.
>=20
> You can release without the fix (it's not a regression), but please
> realize that we have a lot of intermittent bugs so just because an
> issue doesn't appear in one run doesn't mean the issue is gone. :)

Hi Greg,

We realize there are intermittent bugs. This is why we're asking you to=
 decide wether this specific bug should be a blocker for the release or=
 not. What do you think ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
