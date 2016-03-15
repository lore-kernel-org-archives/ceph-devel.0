From: Martin Palma <martin@palma.bz>
Subject: Re: Publishing development releases
Date: Tue, 15 Mar 2016 21:08:43 +0100
Message-ID: <CANMxC7An4tTP1udJcNvcCHoMOi_HoDG+jEBRodPjxnNpOSw6RQ@mail.gmail.com>
References: <56E7D22E.2060701@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35300 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934930AbcCOUJE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2016 16:09:04 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so164603732wml.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Mar 2016 13:09:04 -0700 (PDT)
In-Reply-To: <56E7D22E.2060701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>, "Chen, Xiaoxi" <xiaoxchen@ebay.com>, Vicente Cheng <freeze.bilsted@gmail.com>, Gaurav Bafna <bafnag@gmail.com>, Rajat Garg <rajatgarg.iitr@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

I'm OK with that and I personally think it is good to provide also
development releases to the community, which in the end will lead to a
broader testing before the actual release.

Best,
Martin

On Tue, Mar 15, 2016 at 10:13 AM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi Abhishek V, Abhishek L, Swami, Nathan, Gaurav, Rajat, Martin, Xiao=
xi, Vicente,
>
> A few weeks ago, 10.0.3 was tagged for release, but packages were not=
 published and these packages were missed by the Ceph user base. We, th=
e members of the Stable Releases team, got to thinking how we could hel=
p.
>
> This led to an idea that was discussed on the mailing list[1] and dur=
ing CDM[2]. Since we were already building packages as a side effect of=
 running teuthology suites on OpenStack, this could be extended into a =
full-fledged release process that would:
>
> 1. ensure that the community's demand for development releases is met
> 2. complement, not replace, the existing package publication workflow
> 3. be automated.
>
> So I added a "release" subcommand to the ceph-workbench[3] tool we ar=
e already using to automate various backporting tasks. The new subcomma=
nd is included in the latest ceph-workbench release, and works like thi=
s:
>
>              ceph-workbench release --suite buildpackages/any \
>                          --ceph jewel \
>                          --version 10.0.5 \
>                          --filter ubuntu_14.04,centos_7.2
>
> When it completes the packages can be uploaded to a permanent mirror =
similar to downloads.ceph.com.
>
> I believe we can commit to publish Ceph development releases with thi=
s process. The "release" subcommand is relatively small (around 300 lin=
es of code) and there are integration tests to help with its maintenanc=
e. There are enough of us to rotate the release duties so that it does =
not become too much of a burden for anyone.
>
> Since it's a decision that changes our focus and our workload, are yo=
u OK with adding this activity to the scope of our team?
>
> Cheers
>
> [1] (Un)Stable release team http://www.spinics.net/lists/ceph-devel/m=
sg28887.html
> [2] publishing development and unsupported releases http://tracker.ce=
ph.com/projects/ceph/wiki/CDM_02-MAR-2016
> [3] ceph-workbench release merge request http://ceph-workbench.dachar=
y.org/root/ceph-workbench/merge_requests/43/diffs#9f3ebf1fc38506b665933=
97f3baac514d515c496_231_232
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
