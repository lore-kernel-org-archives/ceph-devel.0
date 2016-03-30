From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: Re: getting ready for jewel 10.2.1
Date: Wed, 30 Mar 2016 16:15:50 +0530
Message-ID: <CAP3mxSywVh28G3nAgadt+3wZTcdaPJu7=FxNAGYJvnk0dj_5JA@mail.gmail.com>
References: <56FBAADF.3020407@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36749 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcC3Kpv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 06:45:51 -0400
Received: by mail-yw0-f178.google.com with SMTP id g3so52765148ywa.3
        for <ceph-devel@vger.kernel.org>; Wed, 30 Mar 2016 03:45:50 -0700 (PDT)
In-Reply-To: <56FBAADF.3020407@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

On Wed, Mar 30, 2016 at 4:00 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Now is a good time to get ready for jewel 10.2.1 and I created http:/=
/tracker.ceph.com/issues/15317 for that purpose.

Thanks for creating the tracker issue.

The goal is to be able to run as many suites as possible on OpenStack,
so that we do not have to wait days (sometime a week) for runs to
complete on Sepia. Best case scenario, all OpenStack specific problems
are fixed by the time 10.2.1 is being prepared. Worst case scenario
there is no time to fix issues and we keep using the sepia lab. I
guess we'll end up somewhere in the middle : some suites will run fine
on Openstack and we'll use sepia for others.

Lets aim for the stars :)

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
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre

Thanks
Abhishek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
