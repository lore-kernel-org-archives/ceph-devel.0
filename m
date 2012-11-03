From: Gregory Farnum <greg@inktank.com>
Subject: Re: python-ceph
Date: Sat, 3 Nov 2012 17:31:34 +0100
Message-ID: <CAPYLRzjwEy2o=JwCUQuio-WDevzrPiQ0fUCnMJu7XiDTVWhF8Q@mail.gmail.com>
References: <CACkq2momtqxBZ+XCz_j_kiJsbn_8epU=vovn8-RfAob-d5d-wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50636 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756989Ab2KCQbf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 12:31:35 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6320720iea.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 09:31:34 -0700 (PDT)
In-Reply-To: <CACkq2momtqxBZ+XCz_j_kiJsbn_8epU=vovn8-RfAob-d5d-wA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>, Gary Lowell <gary.lowell@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 2, 2012 at 8:53 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> Hi folks,
>
> Are there any plans to release python-ceph to pypi?  It would be nice
> to see it packaged up in distutils/egg format and added to pypi, that
> way other python packages can list it as a dependency.
>
> I know there is currently a python-ceph package in Debian, but that
> doesn't allow me to list it as a dependency in a setup.py file and
> have it installed in a virtualenv, for example.  Right now I have to
> copy rbd.py into my virtualenv.
>
> Curious to know if this is something you would consider.  Perhaps it
> is something I could help with.

I'm not familiar with Python packaging, can you talk about this a bit more?
-Greg

>
> Thanks,
>
>  - Travis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
