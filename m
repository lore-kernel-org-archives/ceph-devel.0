From: Owen Synge <osynge@suse.com>
Subject: Re: python facade pattern implementation in ceph and ceph-deploy
 is bad practice?
Date: Tue, 14 Jul 2015 10:47:08 +0200
Message-ID: <55A4CC8C.7010206@suse.com>
References: <559E4814.8030007@suse.com> <559E50F2.7030801@redhat.com> <559E6228.8090604@suse.com> <3C4B78C7-D8FA-4EA0-84CE-129CE0852AB1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:49629 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbGNIsu (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 14 Jul 2015 04:48:50 -0400
In-Reply-To: <3C4B78C7-D8FA-4EA0-84CE-129CE0852AB1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 07/09/2015 09:58 PM, Travis Rhoden wrote:
>=20
>> On Jul 9, 2015, at 4:59 AM, Owen Synge <osynge@suse.com> wrote:
>>
>> On 07/09/2015 12:46 PM, John Spray wrote:
>>> Owen,
>>
>> Hi John,
>>
>> thanks for your reasonable mail.
>>
>>> Please can you say what your overall goal is with recent ceph-deplo=
y
>>> patches?=20
>>
>> To give ceph-deploy code features we have in downstream ceph-deploy =
to
>> upstream.
>>
>> All I am trying to do is reduce copious code duplication during the
>> process of up streaming. It seems such duplication is wanted for rea=
sons
>> I am yet to understand.
>>
>> I only understand that due to architectural bad practices such as th=
is
>> one in how to do a basic facade class.
>>
>> I made my downstream code OS preferred directory neutral, and init
>> system neutral using abstractions.
>=20
> I=E2=80=99ve added a new set of comments in https://github.com/ceph/c=
eph-deploy/pull/317 that hopefully clarifies my position.

A lot thank you.

> I am *not* in favor of copious code duplication.

Good. I am glad you clarified this in both the pull request and in this
thread.

> I *am* in favor of not introducing new paradigms or architectures in =
the stable 1.5.x series.  The 1.5.x series is packaged and supported do=
wnstream, and introducing major changes will complicate that.  ceph-dep=
loy has been in a state where the main changes we have been taking are:=
 (1) bug/security fixes (2) new features to keep up with Ceph features =
(like civetweb-based RGW) (3) fixes to make user help and execution out=
put more clear.

Good. This was my major issue, that led to this thread.

> A major refactoring (I would consider anything that moves away from t=
he current facade paradigm to be major in 1.5.x) doesn=E2=80=99t fit in=
to that.  However, ceph-deploy is not dead or maintenance only, so long=
 as there is community interest.  The upstream installer developers (of=
 which I am one) and Red Hat (also me again) are looking at alternative=
s for more robust installation solutions that do not involve ceph-deplo=
y.  That is also a motivation for not making major changes, like those =
proposed in https://github.com/ceph/ceph-deploy/pull/320.  I am concern=
ed that it will make long-term maintenance more complicated.

I quiet understand redhat and upstreams perspective that ceph-deploy is
NOT a good plan going forward as a "robust installation solutions" for
large clusters. I also favour using more conventional cluster managemen=
t
solutions on large and production clusters.

To me, when working on new functionality, such as rgw with fastcgi or
civetweb is not re factoring.

My only remaining fear is that you consider a major re-factoring is for
me minor changes for new development.

This probably only reflects our different attitudes to the compromise
between incremental improvement Vs consistency.

>>> Whether a given structure is right or wrong is really a
>>> function of the overall direction.  If you are aiming to make
>>> ceph-deploy into an extensible framework that can do things in para=
llel,
>>> then you need to say so, and that's a bigger conversation about whe=
ther
>>> that's a reasonable goal for a tool which has so far made a virtue =
of
>>> maintaining modest ambitions.
>>
>> Understood and irrelevant.
>>
>> As I stated in the email you replied to the issue of only one instan=
ce
>> existing which prevents processing more than one node at a time, or
>> even, connecting to two servers at the same time (so you can query
>> update a second node) can be worked around, by importing the modules=
 as
>> objects, but issue (2) the structural "orange" issues are far more
>> serious, leading to structural artifacts of a badly implemented faca=
de
>> pattern interfere with the complete code base.
>>
>>> Along these lines, I noticed that you recently submitted a pull req=
uest
>>> to ceph-deploy that added a dependency on SQLAlchemy, and several
>>> hundred lines of extra boilerplate code -- this kind of thing is
>>> unlikely to get a warm reception without a stronger justification f=
or
>>> the extra weight.  While I don't know how related that is to the po=
ints
>>> you're making in this post, but it certainly inspires some curiosit=
y
>>> about where you're going with this.
>>
>> It was presented as a possible way to make a MVC model.
>>
>> It was only a POC, that this way of doing things could do all that i=
s
>> required.
>>
>> I pulled this POC as it was told to me that no matter what I said MV=
C or
>> structural changes to ceph-deploy in any way where to be opposed by
>> former developers of ceph-deploy.
>=20
> We=E2=80=99ve been trying to only accept code into ceph-deploy that h=
as a corresponding bugzilla or Ceph tracker bug referenced.  I mention =
this because it helps us answer the question =E2=80=9Cwhat problem does=
 this solve=E2=80=9D?  We haven=E2=80=99t enforced to all contributors =
in the community, but we=E2=80=99re trying to be more stringent about i=
t.  The code you=E2=80=99ve proposed in https://github.com/ceph/ceph-de=
ploy/pull/320 seems to mainly address creating required RGW pools.  I=E2=
=80=99d like to see a bug opened against that so that we can see if it =
is indeed something that needs to be fixed.  It may very well be that t=
his is something that RGW is supposed to be doing itself (just talking =
out loud again).

I think here we see the reason why I pulled my discussion point.

You considered it a bug fix / contribution to the code.

I considered it a discussion point on code quality and best practice.

If you are happy to consider this as a discussion point on code quality
and best practice (as I thought I had explained the day before in the
meeting), then I am happy to start discussion in a meeting again.

>> I might have presented an alternative MVC but since the objections w=
here
>> to MVC and also SQLAlchemy when ever it would strengthen arguments
>> against MVC, without even waiting to discuss positives or negatives.
>>
>> I did not want all my "bug fix" patches for ceph-deploy not beign
>> reviewed due to peoples seeing my name, and fearing letting in any
>> patches which I did into the code base.
>=20
> I can only speak for myself here, but I would not do that and I don=E2=
=80=99t think my colleagues would either.  It would not lead to a very =
friendly community if any of us would rather have bugs in the code than=
 review perfectly good patches that fix real problems.

Now we are clear that I wanted to discuss improving the code style,
(particularly for new functionality in rgw)

As I understand it I should not in future:

1) Provide demo code on discussion points. Slides are a better idea.
2) Discuss implementation, best practice and design at the same time.
3) Make discussion points when I have any open pull requests for fear
that others may mix these independent issues.
4) Ever (even if explicitly stated as was the case) make a pull request
for any other purposes than intending to merge with the code base.

I should in future:

1) Raise all proposals in written form.
2) Raise all proposals in written form that is public such as this
mailing list first and never in a private meeting if I expect any
discussion.
3) Always assume the reader is going to conflate every concept in the
discussion unless explicitly written down in public.
4) Contact the author of "unhelpful" comments for clarification and giv=
e
them at least 2 working days to answer as they may have wrote and I may
have read different things from what is intended by the author or
interpreted by me the reader of "unhelpful" comments.


Your suggestions for how to avoid such friction and misunderstanding in
future are very welcome.

>>> I had not seen your wip_services_abstraction branch before, I've ju=
st
>>> taken a quick look now.  More comments would probably have made it
>>> easier to read, as would following PEP8. =20
>>
>> Good review points that would have encouraged me we where moving
>> forwards not backwards, and suggesting everythign has to be part of =
the
>> "boat anchor" facade we already have.
>>
>>> I don't think there's anything
>>> problematic about having a class that knows how to start and stop a
>>> service, but I don't know what comments you've received elsewhere (=
there
>>> aren't any on the PR).
>=20
> All the comments relevant to the class abstraction are in that PR.  O=
ther conversations have taken place on IRC, but that=E2=80=99s been aro=
und the proposal for more of an MVC style that incorporates SQL Alchemy=
, and that is more related to PR #320.  I=E2=80=99ve clarified my revie=
w on #317 to say that I like the classes for the init systems as well, =
but want to see them used a bit differently and to not use the higher l=
evel abstraction above them.

You have explicitly stated that you are open to such suggestions as
introducing classes and objects to the code base of ceph-deploy.

I hope you now understand that I misunderstood some statements you have
since withdrawn that led me to believe that you and others in the team
opposed any "change" in the code style ever.

I now understand I misunderstood the rules and practices you used for
communication.

=46ollowing this very helpful thread I will start a new thread on MVC. =
If
that goes well I will then start a discussion thread on implementation.

Best regards

Owen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
