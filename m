From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: pull request labels : related to
Date: Tue, 8 Sep 2015 14:46:45 +0100
Message-ID: <CAJ4mKGa8ELkQ85mzdQjqhriuGhxjR5uEUvT0ggQAS+k0ZaDcgA@mail.gmail.com>
References: <55EC640C.7020700@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34740 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbbIHNqq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 09:46:46 -0400
Received: by wicfx3 with SMTP id fx3so120942887wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Sep 2015 06:46:45 -0700 (PDT)
In-Reply-To: <55EC640C.7020700@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Sep 6, 2015 at 5:04 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> I wen thru all pull request looking for those not related to anything=
 (like having "bug fix" without "core" or "rgw"). Now that there are ma=
ny labels, it's not trivial for someone not used to Ceph to sort out wh=
at's what. We really have three kinds of labels:
>
>  * those that relate the pull request to an area / component of Ceph =
(rgw, core, etc.)
>  * those used to remember at what stage of QA the pull request is (wi=
p-* and needs*qa)
>  * those that describe the kind of pull request (cleanup, bug fix, pe=
rformance etc.)
>
> To help reading the label I prefixed the names of rgw, core, etc. wit=
h "related to". If someone think that's not helpful or too long to read=
, feel free to revert, it's just a proposal.

You broke all my bookmarked searches. :( I've updated them now but I'm
really not sure this change is helpful =E2=80=94 in particular, we don'=
t need
these labels to make sense to people who aren't used to Ceph and it's
impossible to have them quickly auto-complete now with a long shared
prefix across them all...
-Greg

>
> Cheers
>
> P.S. For backport snippets that set the component to "core" we'll nee=
d to change that to "related to core" instead. Not too much of an incon=
venience IMHO but ...
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
