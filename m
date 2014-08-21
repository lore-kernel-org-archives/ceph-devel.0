From: Gregory Farnum <greg@inktank.com>
Subject: Re: Wireshark Dissector and the Future
Date: Thu, 21 Aug 2014 09:15:54 -0700
Message-ID: <CAPYLRzhACDou35EOpeNp5zXf2uFRCT0EeYpTXrVGD0gYS9GQCA@mail.gmail.com>
References: <53E76408.9050000@kevincox.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:56975 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaHUQP4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 12:15:56 -0400
Received: by mail-qg0-f50.google.com with SMTP id z107so5444361qgd.23
        for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 09:15:55 -0700 (PDT)
In-Reply-To: <53E76408.9050000@kevincox.ca>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Cox <kevincox@kevincox.ca>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Aug 10, 2014 at 5:22 AM, Kevin Cox <kevincox@kevincox.ca> wrote=
:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hello,
>
> This summer as a GSOC project I have implemented a Wireshark dissecto=
r
> for Ceph.  It has been committed to Wireshark master and will be
> available in the next release.
>
> I have been talking with Sage and we have been identifying a couple o=
f
> next steps that need to be discussed about how the dissector will be
> kept up to date and related issues.
>
> Firstly there is the issue of the two existing dissectors sitting in =
the
> Ceph tree.  Neither compile with a modern Wireshark and the new one i=
s
> far more complete.  The current plan is simply to delete them unless
> anyone has objections or a better idea.
>
> Secondly there is the issue of keeping the dissector up to date.  The
> way it is written it should be fairly resilient to new messages and
> encodings but of course to be the most useful it would understand the
> latest version of the protocol.
>
> There is documentation coming to both the Ceph tree and the top of th=
e
> Wireshark dissector (both mostly written but uncommitted) describing =
how
> to update the dissector.  However we were wondering how updating the
> dissector could become part of the regular workflow when updating Cep=
h.
>  I have a couple of ideas myself but wanted to pitch it to the commun=
ity
> to see what we could come up with in addition to my thoughts which ar=
e
> below.
>
> 1. Make if part of the review process. "Hey, I noticed you updated th=
e
> encoding of 'x' could you update the wireshark dissector as well."
>
> 2. Create a "static analysis" tool to check for current encoding
> versions and warn if they are newer then what is supported by the
> dissector.
>
> 3. Run the network traffic of automated tests (such as teuthology)
> through Wireshark and check the warnings/errors.
>
> I think number 3 is particularly interesting because it can catch mor=
e
> then encoding mismatches and possibly other errors in the traffic.
> However it needs much more integration and requires that the new
> encodings are properly tested (although they should be anyway).
>
> I would appreciate ideas and feedback about how this can/should be
> handled and integrated into the pipeline.

A little late now (I've been on vacation) but I just want to register
a vote against option #1 =E2=80=94 nobody is going to consistently reme=
mber
that. :) I suspect option #3 is the most practical and most likely to
keep it up to date; I don't know exactly how would be best to dump the
network traffic but I think that it should be fairly simple to dump
any gathered data into wireshark as part of a short teuthology test
that's in all the suites.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
