From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Nightlies and dumpling
Date: Fri, 8 May 2015 16:55:51 -0700
Message-ID: <CAC6JEv9ELHGdhY76_iobKk1fYCs5rz=dphTCsjOTmsbR7bbMMg@mail.gmail.com>
References: <554D2081.7040503@dachary.org>
	<CAC6JEv-sa-aMqLtMxvqv=au6jDRnDEy4VeNkY6phRRLb-adYAQ@mail.gmail.com>
	<554D32D0.1090608@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34938 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbbEHXzx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 19:55:53 -0400
Received: by ieczm2 with SMTP id zm2so75118816iec.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 May 2015 16:55:52 -0700 (PDT)
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com. [209.85.223.180])
        by mx.google.com with ESMTPSA id d15sm608456igo.8.2015.05.08.16.55.51
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 16:55:52 -0700 (PDT)
Received: by iepj10 with SMTP id j10so71869210iep.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 May 2015 16:55:51 -0700 (PDT)
In-Reply-To: <554D32D0.1090608@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alistair Israel <aisrael@gmail.com>

On Fri, May 8, 2015 at 3:04 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 08/05/2015 22:49, Gregory Farnum wrote:
>> On Fri, May 8, 2015 at 1:45 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>> Hi,
>>>
>>> I was going through the checklist to retire a release, to verify no=
thing was left behind for Dumpling
>>>
>>>    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_retire=
_a_stable_release
>>>
>>> and from the nightlies crontab that you published, I found
>>>
>>> http://tracker.ceph.com/projects/ceph-releases/wiki/Typica
>>>
>>> 10 18 * * 0,4 teuthology-suite -v -c giant -k distro -m typica -s u=
pgrade/dumpling-firefly-x --filter ubuntu_
>>>
>>> and
>>>
>>> http://tracker.ceph.com/projects/ceph-releases/wiki/Sepia
>>>
>>> 10 17 * * 2,4,7 teuthology-suite -v -c next -k distro -m plana,burn=
upi,mira -s upgrade/dumpling-firefly-x --filter ubuntu_
>>>
>>> 13 19 * * 7 teuthology-suite -v -c firefly -k distro -m vps -s upgr=
ade/dumpling-x ~/vps.yaml
>>>
>>> 15 18 * * 3,6 teuthology-suite -v -c giant -k distro -m vps -s upgr=
ade/dumpling-firefly-x ~/vps.yaml
>>
>> You'll notice that these are all tests which upgrade from dumpling t=
o
>> something else. We want to keep testing that to make sure we aren't
>> missing something in the upgrade paths =E2=80=94 which would be bad,=
 even
>> though we're about ready to stop supporting dumpling. ;)
>
> Indeed :-) Say a problem is found, how is it going to be resolved ?

Depends on the problem. If it's in the upgrade path, we'll add stuff
to handle backwards compatibility. If dumpling simply stops running in
the lab...presumably by then we'll have stopped caring about it for
everything else too. ;)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
