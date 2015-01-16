From: Samuel Just <sam.just@inktank.com>
Subject: Re: FAILED assert(peer_missing.count(fromshard))
Date: Fri, 16 Jan 2015 10:10:26 -0800
Message-ID: <CA+4uBUbcQ8OTg=SMnVN7tA5fGqmcqair=kSKKawGtf_+MDSYSA@mail.gmail.com>
References: <54B93EAD.2040200@dachary.org>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:52918 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbbAPSK2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 13:10:28 -0500
Received: by mail-lb0-f176.google.com with SMTP id p9so19824636lbv.7
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 10:10:26 -0800 (PST)
In-Reply-To: <54B93EAD.2040200@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

1) The part where you add the operator<< and change the debug output lo=
oks good.
2) The other part looks like it should be an assert?  Or it should
complain to the central log so that it causes the test to fail at
least?

1 and 2 should be separate commits.
-Sam

On Fri, Jan 16, 2015 at 8:39 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> In the context of http://tracker.ceph.com/issues/10524 FAILED assert(=
peer_missing.count(fromshard)) I propose to add some information for wh=
en it happens:
>
> https://github.com/ceph/ceph/pull/3389
>
> If what happens really is that a bad peer ends up being added with in=
 missing_loc.add_location, that will be a useful information. I tried a=
 number of scenarios and could not find the right conditions to reprodu=
ce the problem locally. Hopefully this additional information will show=
 me where to go :-)
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
