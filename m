From: Greg Farnum <gfarnum@redhat.com>
Subject: Re: Persistence of completed_requests in sessionmap (do we need it?)
Date: Wed, 4 Mar 2015 09:41:29 -0800
Message-ID: <0FC6B2F5-5868-4656-AD7D-F3678AB96587@redhat.com>
References: <54F62A12.8010104@redhat.com> <606442F7-CDFF-4E5E-BFA0-9D83D616F48A@redhat.com> <54F714B4.6070901@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41843 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933626AbbCDRlb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 12:41:31 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t24HfTmu002972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 4 Mar 2015 12:41:30 -0500
Received: from [10.3.235.28] (vpn-235-28.phx2.redhat.com [10.3.235.28])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t24HfTN2013136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 4 Mar 2015 12:41:29 -0500
In-Reply-To: <54F714B4.6070901@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just forwarding the replies to the list as it looks like it got blocked=
 due to accidental HTML.
-Greg


> On Mar 4, 2015, at 6:20 AM, John Spray <john.spray@redhat.com> wrote:
>=20
> On 04/03/2015 12:14, =E4=B8=A5=E6=AD=A3 wrote:
>>=20
>>> =E5=9C=A8 2015=E5=B9=B43=E6=9C=884=E6=97=A5=EF=BC=8C05:39=EF=BC=8CJ=
ohn Spray <john.spray@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> During replay, we rebuild completed_requests from EMetaBlob::replay=
, and we've made it this far without reliably persisting it in sessionm=
ap, so I wonder if we ever needed to save this at all? Thoughts?
>>=20
>> I think we need to save completed_requests for corner cases. conside=
r following scenario:
>>=20
>> Client A sends setattr request to MDS
>> MDS handles the request and sends reply to client. But network betwe=
en MDS and client A becomes disconnected.
>> MDS handles lots of setattr requests from other clients. Log entry f=
or the first setattr request get trimmed
>> MDS crashed, standby MDS on other host takes over.
>> Client A re-send the setattr request to the new MDS.
> Ah, this makes sense.  I suspect we never saw that scenario in the au=
tomated tests because they almost all just use a single client.
>=20
> John
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
