From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Hammer incompat bits and ceph-objectstore-tool
Date: Tue, 17 Mar 2015 23:39:04 -0700
Message-ID: <CAC6JEv-LO=_AW8KA5_=RPLarnVYdHpvg-8b8a7Fgf_4bgOww2w@mail.gmail.com>
References: <5508DB26.5000706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36535 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbCRGjG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Mar 2015 02:39:06 -0400
Received: by igbue6 with SMTP id ue6so92115188igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 23:39:05 -0700 (PDT)
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com. [209.85.223.175])
        by mx.google.com with ESMTPSA id w5sm1096864igk.7.2015.03.17.23.39.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2015 23:39:05 -0700 (PDT)
Received: by iegc3 with SMTP id c3so30905946ieg.3
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 23:39:04 -0700 (PDT)
In-Reply-To: <5508DB26.5000706@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Mar 17, 2015 at 6:55 PM, David Zafman <dzafman@redhat.com> wrot=
e:
>
> During upgrade testing an error occurred because ceph-objectstore-too=
l found
> during import on a Firefly node the compat_features from a export fro=
m
> Hammer.
>
> There are 2 new feature bits set as shown in the error message:
>
> Export has incompatible features set
> compat=3D{},rocompat=3D{},incompat=3D{12=3Dtransaction hints,13=3Dpg =
meta object}
>
> In this case as far as I can tell these osd incompatible changes woul=
dn't
> make the export data in any way incompatible.  So we may have to chec=
k
> compatibility bits on a case by case basis, if we want to allow the t=
ool to
> work in the most cases possible.
>
> During upgrade testing it is interesting that one node has the transa=
ction
> hints feature, but other nodes still running firefly don't.  Is this =
a case
> where we don't have to wait for all  OSDs to update before the cluste=
r can
> start handling OP_COLL_HINT operations?

Mmm, I wasn't much involved in any of it but I think the tricky bit
about transaction hints are that they get encoded into the journal.
I'm not sure this handling is quite right though =E2=80=94 if they're n=
ot
recognized can't they just get skipped in the decoding stages?
In any case, hammer OSDs are supposed to make use of hints without
upgrading all OSDs, IIRC by checking with their peers on every
interval to decide if everybody supports the needed encoding or not
(since during backfill they just transfer objects, it's not a problem
to later include an old OSD). But it looks from a distance like there
may still be some design work to do here.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
