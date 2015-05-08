From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Nightlies and dumpling
Date: Fri, 8 May 2015 16:50:28 -0400 (EDT)
Message-ID: <535125048.16542951.1431118228126.JavaMail.zimbra@redhat.com>
References: <554D2081.7040503@dachary.org> <CAC6JEv-sa-aMqLtMxvqv=au6jDRnDEy4VeNkY6phRRLb-adYAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:49812 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbEHUvc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 16:51:32 -0400
In-Reply-To: <CAC6JEv-sa-aMqLtMxvqv=au6jDRnDEy4VeNkY6phRRLb-adYAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Alistair Israel <aisrael@gmail.com>

+1


Thx
YuriW

----- Original Message -----
=46rom: "Gregory Farnum" <greg@gregs42.com>
To: "Loic Dachary" <loic@dachary.org>
Cc: "Yuri Weinstein" <yweinste@redhat.com>, "Ceph Development" <ceph-de=
vel@vger.kernel.org>, "Alistair Israel" <aisrael@gmail.com>
Sent: Friday, May 8, 2015 1:49:43 PM
Subject: Re: Nightlies and dumpling

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
