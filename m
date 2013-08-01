From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Rados Protocoll
Date: Thu, 1 Aug 2013 14:53:52 -0700
Message-ID: <CA+Hcz58MpW6w3-rv52orcUj+AEW-ccYhgcQAJ2GtHrn6=rDHQg@mail.gmail.com>
References: <51FABE7F.90200@niklasgoerke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:36491 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab3HAVxx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 17:53:53 -0400
Received: by mail-vb0-f44.google.com with SMTP id e13so2747868vbg.3
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 14:53:53 -0700 (PDT)
In-Reply-To: <51FABE7F.90200@niklasgoerke.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Niklas Goerke <niklas@niklasgoerke.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Niklas,

The RADOS reference implementation in C++ is quite large. Reproducing
it all in another language would be interesting, but I'm curious if
wrapping the C interface is not an option for you? There are Java
bindings that are being worked on here:
https://github.com/wido/rados-java.

There are links on ceph.com/docs to some information about Ceph, as
well as videos on Youtube, and academic papers linked to.

-Noah

On Thu, Aug 1, 2013 at 1:01 PM, Niklas Goerke <niklas@niklasgoerke.de> wrote:
> Hi,
>
> I was wondering why there is no native Java implementation of librados. I'm
> thinking about creating one and I'm thus looking for a documentation of the
> RADOS protocol.
> Also the way I see it librados implements the crush algorithm. Is there a
> documentation for it?
> Also an educated guess about whether the RADOS Protocol is due to changes
> would be very much appreciated.
>
> Thank you in advance
>
> Niklas
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
