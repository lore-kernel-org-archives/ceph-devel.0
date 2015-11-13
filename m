From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: recommendations for good newbie bug to look at?
Date: Fri, 13 Nov 2015 10:56:49 -0800
Message-ID: <CAJ4mKGYrW-5kRFHfM-gQbYopV25fr68nVDJsAZb8sRSwVMCzqg@mail.gmail.com>
References: <4B186C0B-C7CD-401F-8FAA-DCC5A89D345C@ebay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35036 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbbKMS4u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Nov 2015 13:56:50 -0500
Received: by wmdw130 with SMTP id w130so41090300wmd.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 Nov 2015 10:56:49 -0800 (PST)
In-Reply-To: <4B186C0B-C7CD-401F-8FAA-DCC5A89D345C@ebay.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Snyder, Emile" <emsnyder@ebay.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks like we only have two tagged right now :( but periodically
things in the tracker get tagged with "new-dev".

http://tracker.ceph.com/projects/ceph/search?utf8=3D=E2=9C=93&issues=3D=
1&q=3Dnew-dev

=2E..and looking at that, the osdmap_subscribe ones I think are mostly
dealt with in https://github.com/ceph/ceph/pull/6314. So, I guess I
once thought http://tracker.ceph.com/issues/6634 was a good starter
task to get people through the PR process. :)

Other than that, if there are specific things you're interested in you
can check the tracker for feature tickets in that area.
-Greg

On Fri, Nov 13, 2015 at 10:24 AM, Snyder, Emile <emsnyder@ebay.com> wro=
te:
> Hello,
>
> I=E2=80=99m looking to get my feet wet with the ceph project, and was=
 wondering if anyone had some advice for a good bug to look at?
>
>
> Thanks,
> -Emile
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
