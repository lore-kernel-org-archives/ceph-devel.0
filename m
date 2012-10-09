From: Gregory Farnum <greg@inktank.com>
Subject: Re: Client Location
Date: Tue, 9 Oct 2012 09:48:37 -0700
Message-ID: <CAPYLRzgznZaZ+xVsY1Er2sYKbF7hfpfewGDPygiHQDSmxDPu6Q@mail.gmail.com>
References: <1467968321.440.1349788446710.JavaMail.root@corellia.pncl.co.uk>
	<50745430.6090607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54216 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab2JIQsi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 12:48:38 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3892146lbo.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 09:48:37 -0700 (PDT)
In-Reply-To: <50745430.6090607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: James Horner <james.horner@precedent.co.uk>, ceph-devel@vger.kernel.org

On Tue, Oct 9, 2012 at 9:43 AM, Mark Kampe <mark.kampe@inktank.com> wro=
te:
> I'm not a real engineer, so please forgive me if I misunderstand,
> but can't you create a separate rule for each data center (choosing
> first a local copy, and then remote copies), which should ensure
> that the primary is always local.  Each data center would then
> use a different pool, associated with the appropriate location-
> sensitive rule.
>
> Does this approach get you the desired locality preference?

This sounds right to me =97 I think maybe there's a misunderstanding
about how CRUSH works. What precisely are you after, James?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
