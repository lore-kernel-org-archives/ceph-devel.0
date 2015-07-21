From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: MVC in ceph-deploy.
Date: Tue, 21 Jul 2015 09:38:46 -0700
Message-ID: <CACkq2mofA=6ezC9VayL2zF124BkngNc6AZ9ww_0CdyQzsU78=Q@mail.gmail.com>
References: <55A4F165.4060402@suse.com> <CACkq2mph0_rOpUu5peAq_4AJ1aa3N0E2=-i_XxcR1eyxF4kkow@mail.gmail.com>
 <55A8CB6E.9040508@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35180 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933108AbbGUQjH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 12:39:07 -0400
Received: by obbop1 with SMTP id op1so119124031obb.2
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 09:39:06 -0700 (PDT)
In-Reply-To: <55A8CB6E.9040508@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Owen,

I think the primary concern I have that I want to discuss more about
is cluster state discovery.  I'm worried about how this scales.
Normally when I think about MVC, I think of a long-running application
or something with a persistent data store for the model (or both).
ceph-deploy is neither of these, so the act of querying the cluster
first and loading all the data into the (memory-backed) model upon
every ceph-deploy invocation concerns me.

=46or querying pools and monitors, it seems fine.  What happens when we
have 1000s of OSDs?

I don't think we'd want to add any kind of data persistence to
ceph-deploy (not that you've suggested it), so that means we would
have to load the model every time.  Right now we take more of a
Pythonic approach of "it's better to ask for forgiveness than
permission", meaning that we just try to do the action in question and
deal with any exceptions that arise.  I'm a little hesitant to try to
infer or pull much knowledge of a Ceph cluster's state into
ceph-deploy, as the cluster's state is quite complicated and dynamic
just because it's a large distributed system.  Of course the monitors
deal with that for us, and I think we would just be querying the
monitor(s) for the latest state.

In general that's my primary feedback.  Are there issues with scaling
to large clusters?  Does it become a large overhead to load the model
if someone runs ceph-deploy repeatedly (say, adding OSDs to one node,
then the next, then the next, and they've done it with separate calls
to ceph-deploy each time).

How do we deal with updating the model in failure scenarios?  We have
to re-query the monitor and update the model to make sure our local
representation is accurate.  I suppose that applies even for
non-failure. For example when we are proposing a change to the model,
say we want to add an OSD, we see go off to a node to create/deploy
the OSD and everything comes back okay.  But to really be sure, we
probably need to query the monitor and see what the status of the OSD
is (is it defined?  is it up?) and to re-sync the model.  It seems
like a lot of back and forth interaction to keep the model up to date,
and ultimately we lose all that information when the application
exits.

That's my initial feedback.

 - Travis

On Fri, Jul 17, 2015 at 2:31 AM, Owen Synge <osynge@suse.com> wrote:
> On 07/17/2015 08:16 AM, Travis Rhoden wrote:
>> Hi Owen,
>>
>> I'm still giving this one some thought. I've gone back and reviewed
>> https://github.com/ceph/ceph-deploy/pull/320 a few more times.  I do
>> understand how it works (it took a couple times through it), and
>> cosmetic things notwithstanding I can appreciate what it is doing.  =
I
>> also fully get that the choice of sqlalchemy vs <choice of data stor=
e>
>> makes no difference to the merit of the idea.  I'm still formulating
>> my opinion, however, but wanted to let you know I was thinking about
>> it.
>
> Thanks for this reply, but please don't get too focused on the patch.
>
> At the time of writing this patch I thought MVC would be completely
> uncontentious. It was never intended to illustrate the benefits of MV=
C.
> That is more work than this patch was intended to achieve.
>
> It was written to show a model can be practically done with a sqlalch=
emy
> implementation of an MVC's model with no important deployment overhea=
d,
> and illustrate how SQL queries can be mapped easily as an advantage o=
f
> using a RDBMS model, rather than illustrating MVC best practice.
>
> The rest of the email tries to show horn the patch into the discussio=
n
> of the validity of MVC with respect to the patch:
>
>         https://github.com/ceph/ceph-deploy/pull/320
>
> Its a nights work and only a discussion point, its half existing code=
 I
> already have (for rgw setup), and half MVC in its self.
>
> Please think of it more as an aid to a conversation (like slides) rat=
her
> than as final or a good example of MVC best practice. It would need m=
ore
> work to be this, and its probably a days work to be close to a good e=
xample.
>
> The model is clear, but the views could be clearer in the way they ar=
e
> abstracted, and can be extended in consistent ways, so I made a few
> comment on the patch showing where I think the code is not very MVC.
>
> A good example in how its not MVC enough to be an MVC example is the
> "set" operations that should be in a controller method, and comparing
> data in the model, the data in the model should be loaded via views. =
In
> addition if the model is based on a RDBMS, the set operations would b=
e
> performed by the RDBMS and not in python.
>
> The first post in this thread is more stand alone in where I would se=
e
> us going if we went MVC. The development of the patch helped me see m=
any
> places where we could add consistency by being more MVC, rather than
> actually following the design pattern enough to show best practice.
>
> I would be happy to chat about the code face to face but reviewing th=
is
> code directly without comments does not show the benefits of MVC.
>
> In summary about this patch:
>
> (1) It is intended to be a point of interactive discussion, rather th=
an
> left stand alone, and could do with more functions illustrating how
> similar these can be.
>
> (2) It is far from fully MVC, both as a discussion point it includes =
not
> very MVC code, partially to show how the code could be made more MVC,
> and as I time boxed the effort and run out of time.
>
> (3) It must be understood as its more correct in model, than it is in
> view separation, and controller clarity.
>
> (4) I rather enjoyed making a Relational model of all complete ceph
> clusters, and this code is more expanded than needed at this point (b=
ut
> it was fun).
>
> (5) In the relational  model I have not followed complete "3rd normal
> form" as I feel that for cluster models in an MVC context its nice to
> have entities map closely with reality, (and help make touples map
> closely to tasks) rather than use more complexity, for the sake of le=
ss
> data in the database which I don't think is an important objective.
>
> (6) the model was also expanded to be more "complete" than needed for
> this discussion, in part for some new members of the SUSE ceph team t=
o
> understand the constraints and structure of a ceph cluster deployment=
=2E
>
> Best regards
>
> Owen
>
>
>
>>
>>  - Travis
>>
>> On Tue, Jul 14, 2015 at 4:24 AM, Owen Synge <osynge@suse.com> wrote:
>>> Dear all,
>>>
>>> ceph-deploy is to quote
>>>
>>> <quote>
>>> It is not a generic deployment system, it is only for Ceph, and is
>>> designed for users who want to quickly get Ceph running with sensib=
le
>>> initial settings without the overhead of installing Chef, Puppet or=
 Juju.
>>>
>>> It does not handle client configuration beyond pushing the Ceph con=
fig
>>> file and users who want fine-control over security settings, partit=
ions
>>> or directory locations should use a tool such as Chef or Puppet.
>>> </quote>
>>>
>>> What we have currently in ceph-deploy is mixing cluster state disco=
very,
>>> cluster state modification, in many functions with no attempt to re=
use
>>> state discovery code. I see no consistent design pattern, but can s=
ee
>>> code that is production grade. Being production grade code I oppose
>>> major code changes that might break functionality happening all at =
once.
>>>
>>> I propose with some small changes for finding out what is to be don=
e,
>>> storing it in one place, finding out what state the cluster is and
>>> storing it in one place. Then comparing these two stored states, th=
en
>>> making changes as needed to the clusters state as just general good
>>> practice. This is can be called MVC in design pattern terminology i=
f all
>>> the state gathering code is separated from all the state changing c=
ode,
>>> these would then be View parts to MVC. The controller would be the
>>> component that directs the interaction between the model and the vi=
ews
>>> which also should be separate.
>>>
>>> From experience I have found that MVC has 5 major benefits compared=
 to
>>> the way ALL of the code base is in ceph-deploy for a project like
>>> ceph-deploy when I have made similar incremental changes toward thi=
s
>>> design pattern in the past on the YAIM project for deploying dcache=
=2E
>>> (which was more complex than ceph deployment and I had to write it =
in BASH)
>>>
>>> (1) Cluster state discovery code only has to be developed tested an=
d
>>> used once as it is placed in model.
>>>
>>> (2) the MVC model can be nested, so potentially removing the need t=
o
>>> iterate across nodes, in more than one place in the code base.
>>>
>>> (3) Making the code MVC will allow the model and the view that is
>>> involved in state gathering code to be reused the functionality and
>>> validation of ceph-deploy in general will improve siginifcantly.
>>>
>>> (4) The command line to desired model state, "view" code can be sha=
red
>>> by all ceph-deploy components.
>>>
>>> (5) By discovering the state of the cluster before changing any clu=
ster
>>> state, things such as needing a change of ceph.conf, which requires=
 a
>>> flag argument to allow this, can be detected at the start of an
>>> operation so the user can get a clear and early error, rather than
>>> failing at a later stage for configuration. Making cluster configur=
ation
>>> closer to atomic, and following the good practice of failing fast.
>>>
>>> For me this clearly sates why MVC is a good standard approach to cl=
uster
>>> management that will reduce code duplication in many areas of the c=
ode
>>> base and simple way to keep the code base extensible.
>>>
>>> Considering we do not have this model, some may consider moving to =
this
>>> model a major re-factor. I think this is invalid because I think it=
s
>>> reasonable to see it from this perspective:
>>>
>>> (A) we can start on an area of the code base that is under new
>>> development. eg rgw support in ceph-deploy.
>>>
>>> (B) I can see removing code duplication as a incremental process th=
at
>>> will each have its own change.
>>>
>>> (C) I do not see the need to move all code to an MVC model at the s=
ame time.
>>>
>>> (D) I do not see splitting your code into discovery , storing state=
 and
>>> applying changes to significantly increase the work for any one cha=
nge.
>>>
>>> Now my points are made I have a couple of final misunderstandings t=
o
>>> clear up in any discussion of MVC:
>>>
>>> (I) I would be happy for the model to be based upon python objects.
>>>
>>> (II) While I like the idea of using sqlalcamy and sqllite as a nice=
 way
>>> to get a type safe model with firm constraints, I do not see this a=
s the
>>> only way we can make a model for MVC. I demonstrated in a code samp=
le
>>> with a draft of a complete relational model to ceph cluster deploym=
ent
>>> using sqllite in memory, that made use of the flexibility of setupt=
ools
>>> the deployment issues people raised with this approach where not
>>> present. This said it is essential to understand I do not see this =
as
>>> more than a potential implementation, or in any way other than as a
>>> potential implementation, of a model for the use by the MVC design =
patten.
>>>
>>> So to summarise:
>>>
>>> I think we should go toward an MVC pattern in ceph-deploy for new
>>> development (such as rgw), in preference to code consistency across
>>> ceph-deploy.
>>>
>>> I think we should re-factor existing code to use a shared model in =
an
>>> MVC pattern only after the model has matured with new development w=
ork
>>> based upon it.
>>>
>>> I think even if ceph-deploy never gets any new functionality, beyon=
d
>>> what is currently planned, moving to MVC will reduce the support bu=
rden
>>> in the long/medium term and potentially in the short term.
>>>
>>> Should further features ever be commissioned from ceph-deploy I thi=
nk
>>> any work already done towards building an MVC pattern will be reuse=
d and
>>> result in less work.
>>>
>>> Best regards
>>>
>>> Owen
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffe=
r, HRB
> 21284 (AG
> N=C3=BCrnberg)
>
> Maxfeldstra=C3=9Fe 5
>
> 90409 N=C3=BCrnberg
>
> Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
