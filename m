From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: blueprint: consistency groups
Date: Wed, 25 May 2016 14:34:46 -0700
Message-ID: <CA+hcxJRTV7yiVNWJdHpz74VhgTOJih3YeOJCuMVErZ54oJf0mQ@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
	<CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
	<20160325071933.GA14634@gmail.com>
	<CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
	<CA+hcxJS+-HsTKpbASkWqr-gR8N6zF1k-pyWh8eQZCCC7sHCiLg@mail.gmail.com>
	<CA+aFP1CnKvVJrWDmKhpziu5otOV73HC5gnUsgZ8+oDW+708Rag@mail.gmail.com>
	<CA+hcxJSnUg1grhdBgOQPRcPK57VyW2Nyg9Rv6whZ3rj1ZoGU_Q@mail.gmail.com>
	<CA+aFP1CPc-aExqfNL671Zr6ectLH9aUEScmKveBn8rPCmJDLtA@mail.gmail.com>
	<CA+hcxJTsPnVyF5Jvic+hDGgR=9CRZNzcwA6sAZzNxnm5x1J=kg@mail.gmail.com>
	<CA+aFP1C7me+-dbXVrMgU0Qs9fX8_4ocC9v5orzy+c8tK30y08A@mail.gmail.com>
	<CA+hcxJT4DWgt8K8hc27KbkJK=DRePM18Zh=GPxtfR5afoxVP1w@mail.gmail.com>
	<CA+hcxJQGcDy96o0f9sEY8HwLXng9YzxsoKAhaaCuCDDhVbN76A@mail.gmail.com>
	<CA+aFP1AQzo7bO=e-Gd_sAtBWSYFgvji8isxuXFKDejaHAA+FuA@mail.gmail.com>
	<CA+hcxJRMcJFxYdscdwyvowjw_dNF6xoNzCHT1=oaznwGqY-4Rw@mail.gmail.com>
	<CA+aFP1Awk0YZnW16JxOgfDeJFsuKPoN4jdrpr8dCdqUjhhD_Mw@mail.gmail.com>
	<CA+hcxJTWZWUAUGr1gAZwEqLrGY9eJpzrF3+0H3wqaSjiY6-Faw@mail.gmail.com>
	<CA+aFP1CfOCy9pL=NWka=j=otb7rwO7W=ds-ggBMz0hVY=zj3-Q@mail.gmail.com>
	<CA+hcxJS9mBZL5wu0A2L_-3bAyvMb90qBaYo+cosqphUn0Dj9kQ@mail.gmail.com>
	<CA+aFP1AchQD6b-gm7Z4zijQfW8OMZJrrE8S2nLde2CE+VUjZew@mail.gmail.com>
	<CA+hcxJQAC7m5mRXhGfL0Fu8erWFb--GstHzOYO-swJNLWXPhHw@mail.gmail.com>
	<CA+aFP1CVs-_KWWUOdnP7=rFbghpNHTrrfuLPkVw9RtX03eAUKw@mail.gmail.com>
	<CA+hcxJQhE13ftC7TQ2PdBQwd=_xurRGsuJHTi736r+n0kx_UeQ@mail.gmail.com>
	<CA+hcxJTTZn8y=kuSFnWbem01XaOUa3D8LDh=25ds6r+qD318vA@mail.gmail.com>
	<CA+aFP1DzwBkZ5Yo2p2nXvn5KbgniizH1saq4eHx9UDA9JC8UEw@mail.gmail.com>
	<CA+hcxJR5BTVoogj3caBm9pYR9S4SVqtP815nFHHQK4t89a0Gsg@mail.gmail.com>
	<CA+aFP1AziFsEJmm3qdCvvfuqnUFPDOW5Ce9VxY0DVMbMy+Y4PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33265 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcEYVes (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2016 17:34:48 -0400
Received: by mail-yw0-f179.google.com with SMTP id h19so60200604ywc.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2016 14:34:47 -0700 (PDT)
In-Reply-To: <CA+aFP1AziFsEJmm3qdCvvfuqnUFPDOW5Ce9VxY0DVMbMy+Y4PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

I this case I case create a separate pull request for consistency
group's operations only(create, remove, list).
Another pull request will be: add image to cg, remove image, list images.

One more question. How do you prefer comments to be addressed, as an
additional commit to the pull request or amend the corresponding
commit?

V.

On Tue, May 24, 2016 at 10:30 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> The current PR is at approximately 2500 lines -- it would be nice to
> have a PR under 1000 changed lines in a perfect world.  The trouble
> with larger PR is that after you address comments, I have to re-read
> it all again.  The smaller the PR, the faster it can be reviewed and
> merged.  If changes depend on another PR, you can always
> non-fast-forward merge the other PR branch into your dependent PR
> branch so that it's clear what needs to be reviewed.
>
> On Tue, May 24, 2016 at 6:42 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> Yes, I'm working on splitting it into small logically separated commits.
>> My current PR is for CRUD operations only(create, remove, add image,
>> remove image, show info).
>> Do you want even a smaller PR or this one is small enough?
>>
>> Thanks,
>> V.
>>
>> On Mon, May 23, 2016 at 7:39 PM, Jason Dillaman <jdillama@redhat.com> wrote:
>>> Definitely want to ensure that it cleanly merges with master.  I would
>>> also request, if at all possible, that you break it into individual
>>> PRs of concrete sub-tasks for implementing consistency groups for ease
>>> of review.  Have individual commits for each step of implementing the
>>> task would also help (i.e. squash related commits, fix style issues or
>>> bugs in the commit that introduced them, etc).
>>>
>>> On Mon, May 23, 2016 at 6:43 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>> Never mind. I just realized that it will be easier to build it on top
>>>> of the latest master in any case.
>>>>
>>>> On Mon, May 23, 2016 at 8:32 AM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>> Jason,
>>>>>
>>>>> Do you prefer pull requests to be rebased on top of the latest master
>>>>> or should I keep it where I started the development?
>>>>>
>>>>> Thanks,
>>>>> V.
>>>>>
>>>>> On Mon, May 16, 2016 at 8:48 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>>>>> On Thu, May 12, 2016 at 10:45 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>>>> Jason,
>>>>>>>
>>>>>>> Do you have any opinion regarding deleting images that are in a
>>>>>>> consistency group?
>>>>>>>
>>>>>>> Should we delete them as well as the references in the consistency
>>>>>>> group they belong to or should we prohibit deleting images that are in
>>>>>>> a consistency group?
>>>>>>>
>>>>>>> V.
>>>>>>>
>>>>>>
>>>>>> Right now, if an image has a snapshot we required you to remove all
>>>>>> snapshots before removing the image.  Along those lines, if an image
>>>>>> is in a consistency group and the consistency group has snapshots, the
>>>>>> user wouldn't be able to remove the image since it has snapshots nor
>>>>>> should the user be able to remove the snapshots associated with the
>>>>>> consistency group. In this case, the user would be forced to
>>>>>> dissociate the image from the group before attempting to delete it.
>>>>>> Therefore, just to keep the actions consistent, you might as well
>>>>>> force the user to dissociate an image from the consistency group even
>>>>>> if the image doesn't have snapshots.
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Jason
>>>
>>>
>>>
>>> --
>>> Jason
>
>
>
> --
> Jason
