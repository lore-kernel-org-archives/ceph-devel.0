From: Owen Synge <osynge@suse.com>
Subject: Re: MVC in ceph-deploy.
Date: Fri, 17 Jul 2015 11:31:26 +0200
Message-ID: <55A8CB6E.9040508@suse.com>
References: <55A4F165.4060402@suse.com> <CACkq2mph0_rOpUu5peAq_4AJ1aa3N0E2=-i_XxcR1eyxF4kkow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:38986 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329AbbGQJc5 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 17 Jul 2015 05:32:57 -0400
In-Reply-To: <CACkq2mph0_rOpUu5peAq_4AJ1aa3N0E2=-i_XxcR1eyxF4kkow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 07/17/2015 08:16 AM, Travis Rhoden wrote:
> Hi Owen,
>=20
> I'm still giving this one some thought. I've gone back and reviewed
> https://github.com/ceph/ceph-deploy/pull/320 a few more times.  I do
> understand how it works (it took a couple times through it), and
> cosmetic things notwithstanding I can appreciate what it is doing.  I
> also fully get that the choice of sqlalchemy vs <choice of data store=
>
> makes no difference to the merit of the idea.  I'm still formulating
> my opinion, however, but wanted to let you know I was thinking about
> it.

Thanks for this reply, but please don't get too focused on the patch.

At the time of writing this patch I thought MVC would be completely
uncontentious. It was never intended to illustrate the benefits of MVC.
That is more work than this patch was intended to achieve.

It was written to show a model can be practically done with a sqlalchem=
y
implementation of an MVC's model with no important deployment overhead,
and illustrate how SQL queries can be mapped easily as an advantage of
using a RDBMS model, rather than illustrating MVC best practice.

The rest of the email tries to show horn the patch into the discussion
of the validity of MVC with respect to the patch:

	https://github.com/ceph/ceph-deploy/pull/320

Its a nights work and only a discussion point, its half existing code I
already have (for rgw setup), and half MVC in its self.

Please think of it more as an aid to a conversation (like slides) rathe=
r
than as final or a good example of MVC best practice. It would need mor=
e
work to be this, and its probably a days work to be close to a good exa=
mple.

The model is clear, but the views could be clearer in the way they are
abstracted, and can be extended in consistent ways, so I made a few
comment on the patch showing where I think the code is not very MVC.

A good example in how its not MVC enough to be an MVC example is the
"set" operations that should be in a controller method, and comparing
data in the model, the data in the model should be loaded via views. In
addition if the model is based on a RDBMS, the set operations would be
performed by the RDBMS and not in python.

The first post in this thread is more stand alone in where I would see
us going if we went MVC. The development of the patch helped me see man=
y
places where we could add consistency by being more MVC, rather than
actually following the design pattern enough to show best practice.

I would be happy to chat about the code face to face but reviewing this
code directly without comments does not show the benefits of MVC.

In summary about this patch:

(1) It is intended to be a point of interactive discussion, rather than
left stand alone, and could do with more functions illustrating how
similar these can be.

(2) It is far from fully MVC, both as a discussion point it includes no=
t
very MVC code, partially to show how the code could be made more MVC,
and as I time boxed the effort and run out of time.

(3) It must be understood as its more correct in model, than it is in
view separation, and controller clarity.

(4) I rather enjoyed making a Relational model of all complete ceph
clusters, and this code is more expanded than needed at this point (but
it was fun).

(5) In the relational  model I have not followed complete "3rd normal
form" as I feel that for cluster models in an MVC context its nice to
have entities map closely with reality, (and help make touples map
closely to tasks) rather than use more complexity, for the sake of less
data in the database which I don't think is an important objective.

(6) the model was also expanded to be more "complete" than needed for
this discussion, in part for some new members of the SUSE ceph team to
understand the constraints and structure of a ceph cluster deployment.

Best regards

Owen



>=20
>  - Travis
>=20
> On Tue, Jul 14, 2015 at 4:24 AM, Owen Synge <osynge@suse.com> wrote:
>> Dear all,
>>
>> ceph-deploy is to quote
>>
>> <quote>
>> It is not a generic deployment system, it is only for Ceph, and is
>> designed for users who want to quickly get Ceph running with sensibl=
e
>> initial settings without the overhead of installing Chef, Puppet or =
Juju.
>>
>> It does not handle client configuration beyond pushing the Ceph conf=
ig
>> file and users who want fine-control over security settings, partiti=
ons
>> or directory locations should use a tool such as Chef or Puppet.
>> </quote>
>>
>> What we have currently in ceph-deploy is mixing cluster state discov=
ery,
>> cluster state modification, in many functions with no attempt to reu=
se
>> state discovery code. I see no consistent design pattern, but can se=
e
>> code that is production grade. Being production grade code I oppose
>> major code changes that might break functionality happening all at o=
nce.
>>
>> I propose with some small changes for finding out what is to be done=
,
>> storing it in one place, finding out what state the cluster is and
>> storing it in one place. Then comparing these two stored states, the=
n
>> making changes as needed to the clusters state as just general good
>> practice. This is can be called MVC in design pattern terminology if=
 all
>> the state gathering code is separated from all the state changing co=
de,
>> these would then be View parts to MVC. The controller would be the
>> component that directs the interaction between the model and the vie=
ws
>> which also should be separate.
>>
>> From experience I have found that MVC has 5 major benefits compared =
to
>> the way ALL of the code base is in ceph-deploy for a project like
>> ceph-deploy when I have made similar incremental changes toward this
>> design pattern in the past on the YAIM project for deploying dcache.
>> (which was more complex than ceph deployment and I had to write it i=
n BASH)
>>
>> (1) Cluster state discovery code only has to be developed tested and
>> used once as it is placed in model.
>>
>> (2) the MVC model can be nested, so potentially removing the need to
>> iterate across nodes, in more than one place in the code base.
>>
>> (3) Making the code MVC will allow the model and the view that is
>> involved in state gathering code to be reused the functionality and
>> validation of ceph-deploy in general will improve siginifcantly.
>>
>> (4) The command line to desired model state, "view" code can be shar=
ed
>> by all ceph-deploy components.
>>
>> (5) By discovering the state of the cluster before changing any clus=
ter
>> state, things such as needing a change of ceph.conf, which requires =
a
>> flag argument to allow this, can be detected at the start of an
>> operation so the user can get a clear and early error, rather than
>> failing at a later stage for configuration. Making cluster configura=
tion
>> closer to atomic, and following the good practice of failing fast.
>>
>> For me this clearly sates why MVC is a good standard approach to clu=
ster
>> management that will reduce code duplication in many areas of the co=
de
>> base and simple way to keep the code base extensible.
>>
>> Considering we do not have this model, some may consider moving to t=
his
>> model a major re-factor. I think this is invalid because I think its
>> reasonable to see it from this perspective:
>>
>> (A) we can start on an area of the code base that is under new
>> development. eg rgw support in ceph-deploy.
>>
>> (B) I can see removing code duplication as a incremental process tha=
t
>> will each have its own change.
>>
>> (C) I do not see the need to move all code to an MVC model at the sa=
me time.
>>
>> (D) I do not see splitting your code into discovery , storing state =
and
>> applying changes to significantly increase the work for any one chan=
ge.
>>
>> Now my points are made I have a couple of final misunderstandings to
>> clear up in any discussion of MVC:
>>
>> (I) I would be happy for the model to be based upon python objects.
>>
>> (II) While I like the idea of using sqlalcamy and sqllite as a nice =
way
>> to get a type safe model with firm constraints, I do not see this as=
 the
>> only way we can make a model for MVC. I demonstrated in a code sampl=
e
>> with a draft of a complete relational model to ceph cluster deployme=
nt
>> using sqllite in memory, that made use of the flexibility of setupto=
ols
>> the deployment issues people raised with this approach where not
>> present. This said it is essential to understand I do not see this a=
s
>> more than a potential implementation, or in any way other than as a
>> potential implementation, of a model for the use by the MVC design p=
atten.
>>
>> So to summarise:
>>
>> I think we should go toward an MVC pattern in ceph-deploy for new
>> development (such as rgw), in preference to code consistency across
>> ceph-deploy.
>>
>> I think we should re-factor existing code to use a shared model in a=
n
>> MVC pattern only after the model has matured with new development wo=
rk
>> based upon it.
>>
>> I think even if ceph-deploy never gets any new functionality, beyond
>> what is currently planned, moving to MVC will reduce the support bur=
den
>> in the long/medium term and potentially in the short term.
>>
>> Should further features ever be commissioned from ceph-deploy I thin=
k
>> any work already done towards building an MVC pattern will be reused=
 and
>> result in less work.
>>
>> Best regards
>>
>> Owen
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
