From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Criteria behind disk scrubbing policy
Date: Wed, 9 Mar 2016 14:59:12 +0100
Message-ID: <CABZ+qq=E6a6P7=R82nwf5yEFO6o+GAeZ2Mem_XB+8Jp4DKZyJQ@mail.gmail.com>
References: <CAKiXLjenBAB76AJ9qirL5Ff_GDz6E3sGXUie90xrsqydUqFVTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33900 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbcCIOAK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 09:00:10 -0500
Received: by mail-lb0-f179.google.com with SMTP id xr8so64554181lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 06:00:09 -0800 (PST)
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com. [209.85.217.181])
        by smtp.gmail.com with ESMTPSA id rx1sm1292048lbb.22.2016.03.09.05.59.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 05:59:59 -0800 (PST)
Received: by mail-lb0-f181.google.com with SMTP id xr8so64548280lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 05:59:58 -0800 (PST)
In-Reply-To: <CAKiXLjenBAB76AJ9qirL5Ff_GDz6E3sGXUie90xrsqydUqFVTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: veg@ucsc.edu
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Wed, Mar 9, 2016 at 9:21 AM, Veronica Estrada Galinanes <veg@ucsc.ed=
u> wrote:
> From ceph website: "Deep scrubbing (weekly) reads the data and uses
> checksums to ensure data integrity.=E2=80=9D
>
> 1. Why do you use "weekly" deep scrubbing? How many times a year one =
disk
> is scrubbed on average in a Ceph cluster? Schwartz* used three times =
per
> year. =E2=80=9CInterestingly, we did not observe a further decrease i=
n data loss as
> we increased the scrubbing frequency from three to eleven times per y=
ear;
> rather, a slight increase in data loss was noticed. This phenomenon c=
omes
> from the POH (power-on-hour) effect on drive reliability. Aggressive
> scrubbing requires more power cycles, adversely affecting drive relia=
bility.
> "

Is power cycling relevant for modern enterprise drive? APM is disabled
by default on all recent drives I've used.

And their model is not realistic for Ceph: "We varied the access rate
between once per 102 hours (about 4 days) to once per 8103 hours."

With xfs/ext4 OSDs, if a random bit flip corrupts the master copy of
an object, Ceph will happily serve that corrupted data until deep
scrub notices the inconsistency between master and replicas.
=46or this reason alone I prefer to deep scrub as often as possible
(while keeping it transparent to the users).

> 2. Do you have different scrubbing policies according to the redundan=
cy
> method? For example, more scrubs when using replication rather than e=
rasure
> coding?

Scrubbing is configured with the parameters here:
   http://docs.ceph.com/docs/master/rados/configuration/osd-config-ref/=
#scrubbing

--=20
Dan

>
> *Schwarz, Thomas JE, et al. "Disk scrubbing in large archival storage
> systems." *Modeling, Analysis, and Simulation of Computer and
> Telecommunications Systems, 2004.(MASCOTS 2004). Proceedings. The IEE=
E
> Computer Society's 12th Annual International Symposium on*. IEEE, 200=
4.
>
> Thanks,
>
> --
>
> Vero EG
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
