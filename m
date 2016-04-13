From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-qa] ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 23:59:44 +0200
Message-ID: <570EC150.1020305@dachary.org>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
	<570E4843.8000102@dachary.org>
	<CAJ4mKGZ72SOiFt_t+ErWBWuGLQSDMYGyKJDyFnRKpUGJ+oORUw@mail.gmail.com>
	<CALe9h7fmWL0TQxzjct2q26gUuX8z1D56w3QPFkbCK-AN2TTsjQ@mail.gmail.com>
	<CAN=+7FVtCyDDOx-fHhgEfX=rdne32kG0bJ2UZnnRYt8xgC2iLA@mail.gmail.com>
	<alpine.DEB.2.11.1604131436160.29593@cpach.fuggernut.com>
	<570EA842.4060105@redhat.com> <570EB571.10907@dachary.org>
	<570EB787.9090208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp26.services.sfr.fr ([93.17.128.163]:40034 "EHLO
	smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbcDMV7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 17:59:48 -0400
In-Reply-To: <570EB787.9090208@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 13/04/2016 23:17, Josh Durgin wrote:
> On 04/13/2016 02:09 PM, Loic Dachary wrote:
>>
>>
>> On 13/04/2016 22:12, Josh Durgin wrote:
>>> On 04/13/2016 11:38 AM, Sage Weil wrote:
>>>> On Wed, 13 Apr 2016, Samuel Just wrote:
>>>>> It also doesn't seem like it would actually present a problem in =
any case.
>>>>
>>>> The reason we didn't do this before was because we wanted to revis=
e tests
>>>> independently of the thing being tested.  But as John points out,
>>>> specifying a test branch should accomplish that, at least for test=
ing.
>>>>
>>>> It might be nice to preserve the ability specify an alternate repo=
 with
>>>> totally out-of-tree tests.  Maybe that can be done with a simple r=
eorg of
>>>> the repo, like putting everything under qa/, so that tasks/ and su=
ites/
>>>> don't appear at the top level (of ceph.git or ceph-qa-suite.git).
>>>
>>> It'll also be quite helpful to specify an alternate repo (not just
>>> branch) for testing suite changes without pushing to the main ceph.=
git
>>> and triggering gitbuilder builds.
>>
>> We can keep the current --ceph-qa-suite-git-url argument for that. O=
r do you have something else in mind ?
>=20
> I wasn't aware of that - looks like it's just a teuthology-openstack
> option. I was thinking we should have the same option for teuthology-=
suite.

Right. The teuthology-openstack option sets the ceph_qa_suite_git_url c=
onfiguration option from ~/.teuthology.yaml which is not OpenStack spec=
ific. A naive implementation in teuthology-suite would be to replace th=
e value in ~/.teuthology.yaml in the same way teuthology-openstack does=
 it. It would however be problematic for a long lived cluster with mult=
iple users racing with each other. A better implementation would be to =
have that as part of the config.yaml.

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
