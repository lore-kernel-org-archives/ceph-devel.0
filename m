From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Wed, 30 Jun 2010 22:57:21 +0200
Message-ID: <AANLkTikisr1MNv4mw1PkwEEX1vxE_2vcRRAdCgcD33p1@mail.gmail.com>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
	<Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
	<AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
	<i0forb$a8e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63590 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab0F3U5Y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jun 2010 16:57:24 -0400
Received: by wyf23 with SMTP id 23so608332wyf.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jun 2010 13:57:22 -0700 (PDT)
In-Reply-To: <i0forb$a8e$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Wed, Jun 30, 2010 at 5:45 PM, Thomas Mueller <thomas@chaschperli.ch>=
 wrote:
>
> give the kclient a try? git://ceph.newdream.net/ceph-client-
> standalone.git branch unstable-backport for use with "older" kernels.

It's working like a charm (albeit abit more difficult to debug...), tha=
nks.

> why not let ceph manage the whole partition without a fs inbetween ? =
like
>
> osd journal =3D /dev/sdX1
>
> (and remove "journal size")
>
>> =A0 =A0 =A0 =A0filestore journal writeahead =3D true
>
> seems to be true by default (http://ceph.newdream.net/wiki/Ceph.conf =
->
> filestore_journal_parallel)
>
> - Thomas

Mainly because performance is (currently) not my very priority but it
actually works this way and bypass the issue (as a side note there's
indeed a huge performance benefit).

Thanks for the tips,
Sebastien
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
