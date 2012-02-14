From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: ceph_setattr mask
Date: Tue, 14 Feb 2012 17:59:50 +0100
Message-ID: <-3853694968451810452@unknownmsgid>
References: <C5CEE4B7-2D43-48F4-B741-8AB23C62D039@cs.ucsc.edu>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:37841 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715Ab2BNQ7w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 11:59:52 -0500
Received: by wgbgn7 with SMTP id gn7so3453461wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 08:59:51 -0800 (PST)
In-Reply-To: <C5CEE4B7-2D43-48F4-B741-8AB23C62D039@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Pozdrawiam

iSS

On 14 lut 2012, at 01:05, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:

> Howdy,
>
> It looks like ceph_fs.h contains the mask flags (e.g. CEPH_SETATTR_MODE) used in ceph_setattr, but I do not see these flags in any header installed from .deb files (grep /usr/include/*).
>
> Am I missing a location? Should these flags be part of the installed headers?
>
> Thanks,
> -Noah--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
