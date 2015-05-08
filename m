From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Nightlies and dumpling
Date: Fri, 8 May 2015 13:49:43 -0700
Message-ID: <CAC6JEv-sa-aMqLtMxvqv=au6jDRnDEy4VeNkY6phRRLb-adYAQ@mail.gmail.com>
References: <554D2081.7040503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33332 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbbEHUtr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 16:49:47 -0400
Received: by layy10 with SMTP id y10so60598818lay.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 May 2015 13:49:46 -0700 (PDT)
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com. [209.85.215.43])
        by mx.google.com with ESMTPSA id ky7sm1396595lab.37.2015.05.08.13.49.44
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 13:49:45 -0700 (PDT)
Received: by labbd9 with SMTP id bd9so60628624lab.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 May 2015 13:49:43 -0700 (PDT)
In-Reply-To: <554D2081.7040503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Alistair Israel <aisrael@gmail.com>

On Fri, May 8, 2015 at 1:45 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> I was going through the checklist to retire a release, to verify noth=
ing was left behind for Dumpling
>
>    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_retire_a=
_stable_release
>
> and from the nightlies crontab that you published, I found
>
> http://tracker.ceph.com/projects/ceph-releases/wiki/Typica
>
> 10 18 * * 0,4 teuthology-suite -v -c giant -k distro -m typica -s upg=
rade/dumpling-firefly-x --filter ubuntu_
>
> and
>
> http://tracker.ceph.com/projects/ceph-releases/wiki/Sepia
>
> 10 17 * * 2,4,7 teuthology-suite -v -c next -k distro -m plana,burnup=
i,mira -s upgrade/dumpling-firefly-x --filter ubuntu_
>
> 13 19 * * 7 teuthology-suite -v -c firefly -k distro -m vps -s upgrad=
e/dumpling-x ~/vps.yaml
>
> 15 18 * * 3,6 teuthology-suite -v -c giant -k distro -m vps -s upgrad=
e/dumpling-firefly-x ~/vps.yaml

You'll notice that these are all tests which upgrade from dumpling to
something else. We want to keep testing that to make sure we aren't
missing something in the upgrade paths =E2=80=94 which would be bad, ev=
en
though we're about ready to stop supporting dumpling. ;)
-Greg

>
>
> You can also remove from Sepia the lines commented out:
>
> #removed the line below b/c the suite 'upgrade/dumpling-firefly-x' on=
 vps runs out of memory on hammer, YuriW 3/29/15
> #15 17 * * 1,3 teuthology-suite -v -c hammer -k distro -m vps -s upgr=
ade/dumpling-firefly-x --suite-branch hammer ~/vps.yaml
>
> #removed the line below b/c the suite 'upgrade/dumpling-firefly-x' on=
 vps runs out of memory on next, YuriW 3/29/15
> #15 17 * * 0,2,4,6 teuthology-suite -v -c next -k distro -m vps -s up=
grade/dumpling-firefly-x --suite-branch hammer ~/vps.yaml
>
> Maybe there is a reason for scheduling them, even though Dumpling is =
retired. But in case it was just overlooked, maybe you can save some co=
mputing power in the labs :-0
>
> Cheers
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
