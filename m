From: Loic Dachary <loic@dachary.org>
Subject: Re: Building packages from a SHA instead of the tip of a branch
Date: Fri, 26 Feb 2016 01:33:17 +0700
Message-ID: <56CF48ED.2020104@dachary.org>
References: <56CEF369.7020403@dachary.org>
 <CAJ4mKGbR-PnAztnEYzPjjyOS9gbh5EHBrx8Y=iZQTTugf=TS_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44216 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933337AbcBYSd2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 13:33:28 -0500
In-Reply-To: <CAJ4mKGbR-PnAztnEYzPjjyOS9gbh5EHBrx8Y=iZQTTugf=TS_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Gregory Meno <gmeno@redhat.com>, Alfredo Deza <adeza@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Greg,

On 26/02/2016 00:37, Gregory Farnum wrote:
> On Thu, Feb 25, 2016 at 4:28 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi Gregory and Alfredo,
>>
>> The system in place to build packages uses the tip of the stable bra=
nch, which has been a recurring problem over the past years. It would m=
ake a lot of sense to use a specific SHA1 instead of "whatever is at th=
e tip of the stable branch at the moment".
>>
>> Is there already an issue in tracker.ceph.com for this ? If not, in =
which tracker do you suggest I file this feature request ?
>=20
> It might be easier to build from a tag or to push a specifically-name=
d
> branch (infernalis-release-2016-02-25) as well. Just to think around
> the problem. ;)

IIRC taging was not an option because people have scripts watching the =
tags (it's a distant memory though, maybe it does not matter anymore ?)=
=2E I like the idea of having an infernalis-release-2016-02-25 branch. =
Unless the scripts are somehow sensitive to the branch name ?

Cheers

> -Greg
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
