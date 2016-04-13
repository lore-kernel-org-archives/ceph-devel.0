From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [Ceph-qa] ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 14:17:59 -0700
Message-ID: <570EB787.9090208@redhat.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
 <570E4843.8000102@dachary.org>
 <CAJ4mKGZ72SOiFt_t+ErWBWuGLQSDMYGyKJDyFnRKpUGJ+oORUw@mail.gmail.com>
 <CALe9h7fmWL0TQxzjct2q26gUuX8z1D56w3QPFkbCK-AN2TTsjQ@mail.gmail.com>
 <CAN=+7FVtCyDDOx-fHhgEfX=rdne32kG0bJ2UZnnRYt8xgC2iLA@mail.gmail.com>
 <alpine.DEB.2.11.1604131436160.29593@cpach.fuggernut.com>
 <570EA842.4060105@redhat.com> <570EB571.10907@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbcDMVSD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Apr 2016 17:18:03 -0400
In-Reply-To: <570EB571.10907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

On 04/13/2016 02:09 PM, Loic Dachary wrote:
>
>
> On 13/04/2016 22:12, Josh Durgin wrote:
>> On 04/13/2016 11:38 AM, Sage Weil wrote:
>>> On Wed, 13 Apr 2016, Samuel Just wrote:
>>>> It also doesn't seem like it would actually present a problem in any case.
>>>
>>> The reason we didn't do this before was because we wanted to revise tests
>>> independently of the thing being tested.  But as John points out,
>>> specifying a test branch should accomplish that, at least for testing.
>>>
>>> It might be nice to preserve the ability specify an alternate repo with
>>> totally out-of-tree tests.  Maybe that can be done with a simple reorg of
>>> the repo, like putting everything under qa/, so that tasks/ and suites/
>>> don't appear at the top level (of ceph.git or ceph-qa-suite.git).
>>
>> It'll also be quite helpful to specify an alternate repo (not just
>> branch) for testing suite changes without pushing to the main ceph.git
>> and triggering gitbuilder builds.
>
> We can keep the current --ceph-qa-suite-git-url argument for that. Or do you have something else in mind ?

I wasn't aware of that - looks like it's just a teuthology-openstack
option. I was thinking we should have the same option for teuthology-suite.
