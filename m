From: Neil Levine <neil.levine@inktank.com>
Subject: Re: Geo-replication with RBD
Date: Thu, 31 Jan 2013 15:27:36 -0800
Message-ID: <CANygib8Z=+ik3WbPNcyXTkSV3o2wC9+06fp58EnhUax3cgJBng@mail.gmail.com>
References: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57144 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab3AaX1h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 18:27:37 -0500
Received: by mail-vc0-f174.google.com with SMTP id n11so2134617vch.33
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 15:27:36 -0800 (PST)
In-Reply-To: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Skowron,

Can you go into a bit more detail on your specific use-case? What type
of data are you storing in rbd (type, volume)?

Neil

On Wed, Jan 30, 2013 at 10:42 PM, Skowron S=C5=82awomir
<slawomir.skowron@grupaonet.pl> wrote:
> I make new thread, because i think it's a diffrent case.
>
> We have managed async geo-replication of s3 service, beetwen two ceph=
 clusters in two DC's, and to amazon s3 as third. All this via s3 API. =
I love to see native RGW geo-replication with described features in ano=
ther thread.
>
> There is another case. What about RBD replication ?? It's much more c=
omplicated, and for disaster recovery much more important, just like in=
 enterprise storage arrays.
> One cluster in two DC's, not solving problem, because we need securit=
y in data consistency, and isolation.
> Do you thinking about this case ??
>
> Regards
> Slawomir Skowron--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
