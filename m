From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Ceph backports
Date: Tue, 6 Jan 2015 10:21:21 -0800
Message-ID: <CAC6JEv_UJoLmvkr0kyBaxV=hfU9u4t8tCjXsUydg86Z+xNz08w@mail.gmail.com>
References: <54AA7B46.6090706@dachary.org>
	<CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>
	<54AA80AD.2010901@dachary.org>
	<CAC6JEv94h5edyT68UcseSbYLSnT+eFMsUOxo84sVLw1T1f446g@mail.gmail.com>
	<54AB2887.8000503@dachary.org>
	<CAC6JEv-uzfzEtLb5X29ne2ME7gTDeysByG0DDJRNZxBQ2WCUEg@mail.gmail.com>
	<54AB9F2B.1020700@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:62677 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228AbbAFSVW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 13:21:22 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so4193168ieb.7
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 10:21:22 -0800 (PST)
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com. [209.85.223.182])
        by mx.google.com with ESMTPSA id j82sm28315836iod.12.2015.01.06.10.21.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 10:21:21 -0800 (PST)
Received: by mail-ie0-f182.google.com with SMTP id x19so4186954ier.13
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 10:21:21 -0800 (PST)
In-Reply-To: <54AB9F2B.1020700@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 6, 2015 at 12:39 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 06/01/2015 01:22, Gregory Farnum wrote:
>> On Mon, Jan 5, 2015 at 4:12 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>> :-) This process is helpful if it allows me to help a little more t=
han I currently do with the backport process. It would be a loss if the=
 end result is that everyone cares less about backports. My primary inc=
entive for sending this mail is to start the conversation and avoid tha=
t kind of unintended drawback.
>>
>> Why do you want to get involved with other people's backports at all=
?
>
> Just in case there is a need for more workforce.
>
>> I don't mean that to sound possessive, but having the patch's primar=
y
>> author responsible for getting backports done at least has the
>> singular merit of sharding the work up into manageable pieces. ;)
>
> Absolutely.
>>
>>>
>>>> I am 100% on board with making QE responsible for gating backports=
, so
>>>> thank you for starting down that path. :) But I'm not at all sure =
how
>>>> this scales for you. Right now backports are nominally run through=
 two
>>>> important checks:
>>>> 1) Is it suitable for backport (decided by author or tech lead, ma=
rked
>>>> via the Pending Backport tag)
>>>> 2) Has it been through sufficient validation in master to be safe =
to
>>>> backport (not marked in the system anywhere, just by somebody actu=
ally
>>>> doing the backport).
>>>>
>>>> Knowing if something has been through sufficient validation to
>>>> backport requires a fair bit of attention to the details of the ti=
cket
>>>> and the patches involved. How do you plan to keep up on that?
>>>
>>> I can't do that all by myself.
>>>
>>>> Similarly, while point releases are largely ad-hoc, we are trying =
to
>>>> involve all the leads in the time-to-go decision. A lot of those
>>>> decisions rest on whether specific backports have been performed y=
et,
>>>> whether there are very new backports we want to run through testin=
g
>>>> for a little longer, etc. That sounds like a lot of communications
>>>> overhead between the backport gates and the leads when making thes=
e
>>>> kinds of decisions and I'm not sure how that should happen; is the=
re a
>>>> plan? (We can look at ticket status for things which are pending
>>>> backport, but that doesn't facilitate prioritizing their backports=
;
>>>> and in the opposite direction there's not a good way to say "this
>>>> relatively large backport needs to go through at least three test =
runs
>>>> before a release".)
>>>
>>> Could you point me to a mail thread / IRC conversation that is repr=
esentative of this process ?
>>
>> No; that's pretty much all done in video chats. :/
>>
>>>
>>> Here is a revised process which is hopefully more realistic:
>>>
>>> 0. Developer follows normal process to land PR to master. Once comp=
lete and ticket is marked Pending Backport this process initiates.
>>> 1. I periodically polls Redmine to look for tickets in Pending Back=
port state and focus on the ones that are left unattended for too long
>>> 1a. Under the supervision of the author of the original patch, I fi=
nd the commits associated with the Redmine ticket and Cherry Pick to th=
e backport integration branch off of the desired maintenance branch (Du=
mping, Firefly, etc).
>>> 1b. I resolve any merge conflicts with the cherry-picked commit
>>> 2. I merge all backports for a given branch in an integration branc=
h
>>> 3. I ask the leads of each project to review the integration
>>> 4. Once satisfied with group of backported commits to integration b=
ranch, I notify QE.
>>> 5. QE tests backport integration branch against appropriate suites
>>> 6a. If QE is satisfied with test results, they merge backport integ=
ration branch.
>>> 6b. If QE is NOT satisfied with the test results, they indicate bac=
kport integration branch is NOT ready to merge and return to me to work=
 with original Developer to resolve issue and return to steps 2/3
>>> 7. Ticket is moved to Resolved once backport integration branch con=
taining cherry-picked backport is merged to the desired mainteance bran=
ch(es)
>>>
>>> What do you think ?
>>
>> I think if we're going to add a process to anything it should be
>> followed by everybody involved. I really would love for everything t=
o
>> be gated by QE before it goes into a backport branch, but if you're
>> going off and building integration branches and QE is testing them, =
I
>> think other people are going to keep backporting as we have been and
>> trip all over each other. We've periodically used "firefly-next"
>> branches and related things, but it's always been ad-hoc.
>>
>> Something more realistic might involve locking down the stable
>> branches so they can only be merged into by QE or some approved grou=
p,
>> and then letting people do their own backports onto a
>> <stable-branch>-next that is periodically taken up and
>> integration-tested prior to merge into the LTS proper. That ensures
>> that only patches which have all been tested together get into a
>> stable branch without forcing each individual backport into a lot of
>> process.
>
> Let me rephrase to make sure I understand what you're suggesting.
>
> At the moment, as far as I can tell, developers do the backport of th=
eir patches if / when necessary and make sure they are green / yellow i=
n gitbuilder. The integration itself happens on the stable branch, when=
 such backports are merged: there is no integration branch (with the ex=
ception of an occasional XXX-next) nor someone focusing on integration.=
 At some point in time the leads of each component get together and che=
ck if the current set of patches in the not-yet-released stable branch =
would make a sensible point release. The teuthology test suites are run=
, the results are analysed, the errors fixed and the release published.
>
> My past experience is that once the backport is merged in the stable =
branch my task is done as a developer. I'm not required when the releas=
e time comes and integration is something I'm mostly unaware of.
>
> You propose that developers do some of the integration work. Instead =
of merging into the stable branch one backport at a time, they would fi=
rst merge their backports into their own integration branch. These indi=
vidual integration branches would then be taken (by me for instance or =
someone else willing to do that), put together, and sent to QE for test=
ing. If it turns out that a developer did not create an integration bra=
nch, the pending backports would be merged as they currently are.

I'm just trying to understand how things scale past one developer. I
gather that Sam and Sage do a lot more backports than I do and are
already not getting them done, so simply having somebody poke at
backports is an improvement? If that's all you're after then this is
sensible =E2=80=94 I just don't want to have backports of my own and do=
 the
wrong thing with them. If you want to pick a process and tell me where
I stick my nose in I'm happy to try it out. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
