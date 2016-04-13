From: Samuel Just <sjust@redhat.com>
Subject: Re: [Ceph-qa] ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 14:11:29 -0700
Message-ID: <CAN=+7FWgYK=oBh4Cm4nGg7pxKWHs6o=oKC3G_LuTOYTdC5HGSA@mail.gmail.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
	<570E4843.8000102@dachary.org>
	<CAJ4mKGZ72SOiFt_t+ErWBWuGLQSDMYGyKJDyFnRKpUGJ+oORUw@mail.gmail.com>
	<CALe9h7fmWL0TQxzjct2q26gUuX8z1D56w3QPFkbCK-AN2TTsjQ@mail.gmail.com>
	<CAN=+7FVtCyDDOx-fHhgEfX=rdne32kG0bJ2UZnnRYt8xgC2iLA@mail.gmail.com>
	<alpine.DEB.2.11.1604131436160.29593@cpach.fuggernut.com>
	<570EA842.4060105@redhat.com>
	<570EB571.10907@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34604 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbcDMVLb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 17:11:31 -0400
Received: by mail-yw0-f171.google.com with SMTP id d68so84256611ywe.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 14:11:30 -0700 (PDT)
In-Reply-To: <570EB571.10907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Josh Durgin <jdurgin@redhat.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

Ah, I didn't know about that, I'll have to try it.
-Sam

On Wed, Apr 13, 2016 at 2:09 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 13/04/2016 22:12, Josh Durgin wrote:
>> On 04/13/2016 11:38 AM, Sage Weil wrote:
>>> On Wed, 13 Apr 2016, Samuel Just wrote:
>>>> It also doesn't seem like it would actually present a problem in a=
ny case.
>>>
>>> The reason we didn't do this before was because we wanted to revise=
 tests
>>> independently of the thing being tested.  But as John points out,
>>> specifying a test branch should accomplish that, at least for testi=
ng.
>>>
>>> It might be nice to preserve the ability specify an alternate repo =
with
>>> totally out-of-tree tests.  Maybe that can be done with a simple re=
org of
>>> the repo, like putting everything under qa/, so that tasks/ and sui=
tes/
>>> don't appear at the top level (of ceph.git or ceph-qa-suite.git).
>>
>> It'll also be quite helpful to specify an alternate repo (not just
>> branch) for testing suite changes without pushing to the main ceph.g=
it
>> and triggering gitbuilder builds.
>
> We can keep the current --ceph-qa-suite-git-url argument for that. Or=
 do you have something else in mind ?
>
>> Josh
>>
>>> sage
>>>
>>>
>>>
>>>> -Sam
>>>>
>>>> On Wed, Apr 13, 2016 at 11:31 AM, John Spray <jspray@redhat.com> w=
rote:
>>>>> On Wed, Apr 13, 2016 at 2:58 PM, Gregory Farnum <gfarnum@redhat.c=
om> wrote:
>>>>>> On Wed, Apr 13, 2016 at 6:23 AM, Loic Dachary <loic@dachary.org>=
 wrote:
>>>>>>> +1 : I agree it would be a good thing.
>>>>>>>
>>>>>>> The reason why it would help to merge ceph-qa-suite in ceph is =
because we have no proper methods or tools to work with interdependent =
repositories. The problem is not unique to Ceph: every Free Software de=
veloper end up bug fixing and adding features to dependencies (ceph-qa-=
suite in the case of Ceph but also jerasure, rocksdb, s3test etc.). It =
will take a long time to resolve that more general problem and I don't =
know about an effort in that direction. Do you ?
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> On 13/04/2016 12:52, John Spray wrote:
>>>>>>>> Lately, we've instances where ceph.git and ceph-qa-suite.git g=
ot
>>>>>>>> slightly out of sync, as we were adding new stuff and interfac=
e
>>>>>>>> changes to ceph (especially in cephfs).
>>>>>>>>
>>>>>>>> We used to have two repos (ceph and teuthology), now we have t=
hree
>>>>>>>> (ceph, ceph-qa-suite and teuthology).  Splitting tests out of
>>>>>>>> teuthology was a good thing, but maybe they should have gone i=
nto the
>>>>>>>> ceph tree instead of a new repo?  The ceph-qa-suite branching =
seems to
>>>>>>>> pretty much mirror what we do with ceph, with master vs jewel =
etc.
>>>>>>>>
>>>>>>>> Historically we had a comparatively static set of workloads in=
 the qa
>>>>>>>> suite (e.g. kernel-untar-build, fsstresss, pjd), which didn't =
change
>>>>>>>> much with ceph changes.  But these days we're adding much more
>>>>>>>> detailed tests, so there's more effort to keep the two in sync=
=2E
>>>>>>>>
>>>>>>>> I would personally love to be able to have a single PR that co=
ntained
>>>>>>>> my code and the tests for it.  What if after Jewel we pulled a=
ll of
>>>>>>>> ceph-qa-suite into the ceph repo?
>>>>>>>>
>>>>>>>> We could still enable folks running test changes without havin=
g to
>>>>>>>> rebuild ceph packages: the suite sha1 selected when running a
>>>>>>>> teuthology suite could still be different from that used for
>>>>>>>> installing ceph, it's just that it would fetch that sha1 from =
the ceph
>>>>>>>> repo instead of from a separate repo.
>>>>>>
>>>>>> We do have qa-suite tests that don't necessarily make a lot of s=
ense
>>>>>> to have in ceph.git. Samba, kernel NFS, ganesha some day. That d=
oesn't
>>>>>> mean we shouldn't merge them, but it popped into my head.
>>>>>
>>>>> Fair point.  I think that because those other tasks depend in tur=
n on
>>>>> the ceph tasks, we still ultimately benefit from having them in o=
ne
>>>>> place.
>>>>>
>>>>> It's also possible that in the long run things like the samba tes=
ts
>>>>> become a bit more "smart" in a way that's more tightly coupled to
>>>>> ceph, e.g. checking the resulting state inside ceph after doing t=
hings
>>>>> in the samba/ganesha layer, at which point we'd enjoy having them=
 in
>>>>> the same place as the main body of test code.
>>>>>
>>>>> John
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>> _______________________________________________
>>>> Ceph-qa mailing list
>>>> Ceph-qa@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-qa-ceph.com
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
