From: John Spray <jspray@redhat.com>
Subject: Re: getting ready for jewel 10.2.1
Date: Thu, 31 Mar 2016 16:49:24 +0100
Message-ID: <CALe9h7d65pM08w8KWqo03zT09ny5MAkZgDacOdty97Y7ojCV+Q@mail.gmail.com>
References: <56FBAADF.3020407@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35524 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861AbcCaPto convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 11:49:44 -0400
Received: by mail-ob0-f170.google.com with SMTP id fp4so26029117obb.2
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 08:49:44 -0700 (PDT)
In-Reply-To: <56FBAADF.3020407@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek Varshney <abhishek.varshney@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Mar 30, 2016 at 11:30 AM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi,
>
> Now is a good time to get ready for jewel 10.2.1 and I created http:/=
/tracker.ceph.com/issues/15317 for that purpose. The goal is to be able=
 to run as many suites as possible on OpenStack, so that we do not have=
 to wait days (sometime a week) for runs to complete on Sepia. Best cas=
e scenario, all OpenStack specific problems are fixed by the time 10.2.=
1 is being prepared. Worst case scenario there is no time to fix issues=
 and we keep using the sepia lab. I guess we'll end up somewhere in the=
 middle : some suites will run fine on Openstack and we'll use sepia fo=
r others.
>
> In a previous mail I voiced my concerns regarding the lack of interes=
t of developers regarding teuthology job failures that are cause by var=
iations in the infrastructure. I still have no clue how to convey my be=
lief that it is important for teuthology jobs to succeed despite infras=
tructure variations. But instead of just giving up and do nothing, I wi=
ll work on that for the rados suite and hope things will evolve in a go=
od way. To be honest, figuring out http://tracker.ceph.com/issues/15236=
 and seeing a good run of the rados suite on jewel as a result renewed =
my motivation in that area :-)

If I was dedicating time to working on lab infrastructure, I think I
would prioritise stabilising the existing sepia lab.  I still see
infrastructure issues (these day usually package install failures)
sprinkled all over the place, so I have to question the value of
spreading ourselves even more thinly by trying to handle multiple
environments with their different quirks.

I have nothing against the openstack work, it is a good tool, but I
don't think it was wise to just deploy it and expect other developers
to handle the issues.  I would have liked to see at least one passing
filesystem run on openstack before regular nightlies were scheduled on
it.  Maybe now that we have fixes for #13980 and #13876 we will see a
passing run, and can get more of a sense of how stable/unstable these
tests are in the openstack environment: I think it's likely that we
will continue to see timeouts/instability from the comparatively
underpowered nodes.

John

> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
