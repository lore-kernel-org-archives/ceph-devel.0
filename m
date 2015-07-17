From: Travis Rhoden <trhoden@redhat.com>
Subject: Re: python facade pattern implementation in ceph and ceph-deploy is bad practice?
Date: Thu, 16 Jul 2015 20:40:20 -0700
Message-ID: <9DE253D4-FB80-47C6-8E36-5AFFFD318515@redhat.com>
References: <559E4814.8030007@suse.com> <559E50F2.7030801@redhat.com> <559E6228.8090604@suse.com> <3C4B78C7-D8FA-4EA0-84CE-129CE0852AB1@redhat.com> <55A4CC8C.7010206@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59525 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbbGQDkV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jul 2015 23:40:21 -0400
In-Reply-To: <55A4CC8C.7010206@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org


> On Jul 14, 2015, at 1:47 AM, Owen Synge <osynge@suse.com> wrote:
>=20
> On 07/09/2015 09:58 PM, Travis Rhoden wrote:
>>=20
>>> On Jul 9, 2015, at 4:59 AM, Owen Synge <osynge@suse.com> wrote:
>>>=20
>>> On 07/09/2015 12:46 PM, John Spray wrote:
>>>> Owen,
>>>=20
>>> Hi John,
>>>=20
>>> thanks for your reasonable mail.
>>>=20
>>>> Please can you say what your overall goal is with recent ceph-depl=
oy
>>>> patches?=20
>>>=20
>>> To give ceph-deploy code features we have in downstream ceph-deploy=
 to
>>> upstream.
>>>=20
>>> All I am trying to do is reduce copious code duplication during the
>>> process of up streaming. It seems such duplication is wanted for re=
asons
>>> I am yet to understand.
>>>=20
>>> I only understand that due to architectural bad practices such as t=
his
>>> one in how to do a basic facade class.
>>>=20
>>> I made my downstream code OS preferred directory neutral, and init
>>> system neutral using abstractions.
>>=20
>> I=E2=80=99ve added a new set of comments in https://github.com/ceph/=
ceph-deploy/pull/317 that hopefully clarifies my position.
>=20
> A lot thank you.
>=20
>> I am *not* in favor of copious code duplication.
>=20
> Good. I am glad you clarified this in both the pull request and in th=
is
> thread.
>=20
>> I *am* in favor of not introducing new paradigms or architectures in=
 the stable 1.5.x series.  The 1.5.x series is packaged and supported d=
ownstream, and introducing major changes will complicate that.  ceph-de=
ploy has been in a state where the main changes we have been taking are=
: (1) bug/security fixes (2) new features to keep up with Ceph features=
 (like civetweb-based RGW) (3) fixes to make user help and execution ou=
tput more clear.
>=20
> Good. This was my major issue, that led to this thread.
>=20
>> A major refactoring (I would consider anything that moves away from =
the current facade paradigm to be major in 1.5.x) doesn=E2=80=99t fit i=
nto that.  However, ceph-deploy is not dead or maintenance only, so lon=
g as there is community interest.  The upstream installer developers (o=
f which I am one) and Red Hat (also me again) are looking at alternativ=
es for more robust installation solutions that do not involve ceph-depl=
oy.  That is also a motivation for not making major changes, like those=
 proposed in https://github.com/ceph/ceph-deploy/pull/320.  I am concer=
ned that it will make long-term maintenance more complicated.
>=20
> I quiet understand redhat and upstreams perspective that ceph-deploy =
is
> NOT a good plan going forward as a "robust installation solutions" fo=
r
> large clusters. I also favour using more conventional cluster managem=
ent
> solutions on large and production clusters.
>=20
> To me, when working on new functionality, such as rgw with fastcgi or
> civetweb is not re factoring.
>=20
> My only remaining fear is that you consider a major re-factoring is f=
or
> me minor changes for new development.
>=20
> This probably only reflects our different attitudes to the compromise
> between incremental improvement Vs consistency.

Probably a very true observation.

>=20
>>>> Whether a given structure is right or wrong is really a
>>>> function of the overall direction.  If you are aiming to make
>>>> ceph-deploy into an extensible framework that can do things in par=
allel,
>>>> then you need to say so, and that's a bigger conversation about wh=
ether
>>>> that's a reasonable goal for a tool which has so far made a virtue=
 of
>>>> maintaining modest ambitions.
>>>=20
>>> Understood and irrelevant.
>>>=20
>>> As I stated in the email you replied to the issue of only one insta=
nce
>>> existing which prevents processing more than one node at a time, or
>>> even, connecting to two servers at the same time (so you can query
>>> update a second node) can be worked around, by importing the module=
s as
>>> objects, but issue (2) the structural "orange" issues are far more
>>> serious, leading to structural artifacts of a badly implemented fac=
ade
>>> pattern interfere with the complete code base.
>>>=20
>>>> Along these lines, I noticed that you recently submitted a pull re=
quest
>>>> to ceph-deploy that added a dependency on SQLAlchemy, and several
>>>> hundred lines of extra boilerplate code -- this kind of thing is
>>>> unlikely to get a warm reception without a stronger justification =
for
>>>> the extra weight.  While I don't know how related that is to the p=
oints
>>>> you're making in this post, but it certainly inspires some curiosi=
ty
>>>> about where you're going with this.
>>>=20
>>> It was presented as a possible way to make a MVC model.
>>>=20
>>> It was only a POC, that this way of doing things could do all that =
is
>>> required.
>>>=20
>>> I pulled this POC as it was told to me that no matter what I said M=
VC or
>>> structural changes to ceph-deploy in any way where to be opposed by
>>> former developers of ceph-deploy.
>>=20
>> We=E2=80=99ve been trying to only accept code into ceph-deploy that =
has a corresponding bugzilla or Ceph tracker bug referenced. I mention =
this because it helps us answer the question =E2=80=9Cwhat problem does=
 this solve=E2=80=9D?  We haven=E2=80=99t enforced to all contributors =
in the community, but we=E2=80=99re trying to be more stringent about i=
t.  The code you=E2=80=99ve proposed in https://github.com/ceph/ceph-de=
ploy/pull/320 seems to mainly address creating required RGW pools.  I=E2=
=80=99d like to see a bug opened against that so that we can see if it =
is indeed something that needs to be fixed.  It may very well be that t=
his is something that RGW is supposed to be doing itself (just talking =
out loud again).
>=20
> I think here we see the reason why I pulled my discussion point.
>=20
> You considered it a bug fix / contribution to the code.
>=20
> I considered it a discussion point on code quality and best practice.
>=20
> If you are happy to consider this as a discussion point on code quali=
ty
> and best practice (as I thought I had explained the day before in the
> meeting), then I am happy to start discussion in a meeting again.

I do think the waters got muddied.  I take some blame for that.  It is =
much easier to evaluate the code in light of the exact problem it is tr=
ying to fix rather than seeing it as a model for something different.  =
You did make it clear that it was for discussion only.  We do this all =
the time, actually.  Usually by prefixing Pull Request titles with =E2=80=
=9CDNM=E2=80=9D =E2=80=94 =E2=80=9CDo Not Merge=E2=80=9D.  Though somet=
imes that can also be =E2=80=9CI want you to review this early, even th=
ough it=E2=80=99s not ready=E2=80=9D.

>=20
>>> I might have presented an alternative MVC but since the objections =
where
>>> to MVC and also SQLAlchemy when ever it would strengthen arguments
>>> against MVC, without even waiting to discuss positives or negatives=
=2E
>>>=20
>>> I did not want all my "bug fix" patches for ceph-deploy not beign
>>> reviewed due to peoples seeing my name, and fearing letting in any
>>> patches which I did into the code base.
>>=20
>> I can only speak for myself here, but I would not do that and I don=E2=
=80=99t think my colleagues would either.  It would not lead to a very =
friendly community if any of us would rather have bugs in the code than=
 review perfectly good patches that fix real problems.
>=20
> Now we are clear that I wanted to discuss improving the code style,
> (particularly for new functionality in rgw)
>=20
> As I understand it I should not in future:
>=20
> 1) Provide demo code on discussion points. Slides are a better idea.

I don=E2=80=99t think any of us want slides. :)  DNM pull requests are =
fine.

> 2) Discuss implementation, best practice and design at the same time.
> 3) Make discussion points when I have any open pull requests for fear
> that others may mix these independent issues.

This is hard to say.  I certainly don=E2=80=99t think that it is bad to=
 have pull request open when trying to talk about major architectural c=
hanges.  Each PR should stand on its own merit, and be reviewed individ=
ually.  What is probably helpful is if we make the intent of each PR cl=
ear =E2=80=94 as in this is a simple bug fix, this is a discussion poin=
t / idea, etc.

> 4) Ever (even if explicitly stated as was the case) make a pull reque=
st
> for any other purposes than intending to merge with the code base.

Again, I wouldn=E2=80=99t go that far.  I think most of speak code bett=
er than slides.  When proposing something major, it=E2=80=99s always a =
risk.  You have to fully flesh out the idea to make it work and convinc=
e others that it=E2=80=99s good, but that takes time and effort that yo=
u are guaranteed to see pay off.  If enough discussion can happen early=
 on to see if the idea will be well received, that=E2=80=99s better for=
 everyone.  I think you did try to do that, and the change in design pa=
ttern was not well received.  However in this context, I know I evaluat=
ed it in terms of *could* I merge this right now, not =E2=80=9Cwould th=
is be worthwhile down the road=E2=80=9D.

>=20
> I should in future:
>=20
> 1) Raise all proposals in written form.
> 2) Raise all proposals in written form that is public such as this
> mailing list first and never in a private meeting if I expect any
> discussion.

Open discussion is best, for sure.  The more eyes the better.  When we =
chatted in our standup, it was a difficult forum as it was not the corr=
ect audience.  Those daily standups pretty much never will be right for=
um, as they are much more of the form =E2=80=9Cwhat did you do yesterda=
y, what are you going to do today, and is there anything blocking your =
progress?=E2=80=9D.  They are meant to be fast paced and keep the group=
 up to date with everyone else=E2=80=99s activities.

> 3) Always assume the reader is going to conflate every concept in the
> discussion unless explicitly written down in public.
> 4) Contact the author of "unhelpful" comments for clarification and g=
ive
> them at least 2 working days to answer as they may have wrote and I m=
ay
> have read different things from what is intended by the author or
> interpreted by me the reader of "unhelpful" comments.
>=20
>=20
> Your suggestions for how to avoid such friction and misunderstanding =
in
> future are very welcome.

I think we are on the right track right here =E2=80=94 sticking to ceph=
-devel the mailing list, and IRC.  As for comments you deem unhelpful, =
asking for clarification does seem like the way to go.

>=20
>>>> I had not seen your wip_services_abstraction branch before, I've j=
ust
>>>> taken a quick look now.  More comments would probably have made it
>>>> easier to read, as would following PEP8. =20
>>>=20
>>> Good review points that would have encouraged me we where moving
>>> forwards not backwards, and suggesting everythign has to be part of=
 the
>>> "boat anchor" facade we already have.
>>>=20
>>>> I don't think there's anything
>>>> problematic about having a class that knows how to start and stop =
a
>>>> service, but I don't know what comments you've received elsewhere =
(there
>>>> aren't any on the PR).
>>=20
>> All the comments relevant to the class abstraction are in that PR.  =
Other conversations have taken place on IRC, but that=E2=80=99s been ar=
ound the proposal for more of an MVC style that incorporates SQL Alchem=
y, and that is more related to PR #320. I=E2=80=99ve clarified my revie=
w on #317 to say that I like the classes for the init systems as well, =
but want to see them used a bit differently and to not use the higher l=
evel abstraction above them.
>=20
> You have explicitly stated that you are open to such suggestions as
> introducing classes and objects to the code base of ceph-deploy.
>=20
> I hope you now understand that I misunderstood some statements you ha=
ve
> since withdrawn that led me to believe that you and others in the tea=
m
> opposed any "change" in the code style ever.
>=20
> I now understand I misunderstood the rules and practices you used for
> communication.
>=20
> Following this very helpful thread I will start a new thread on MVC. =
If
> that goes well I will then start a discussion thread on implementatio=
n.

 I think that sounds like a prudent plan.

>=20
> Best regards
>=20
> Owen

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
