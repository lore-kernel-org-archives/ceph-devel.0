From: Owen Synge <osynge@suse.com>
Subject: Re: Difference between convention and enforcement.
Date: Tue, 14 Jul 2015 13:54:08 +0200
Message-ID: <55A4F860.8030309@suse.com>
References: <559E4814.8030007@suse.com>	<6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com>	<55A4E756.7090206@suse.com> <CAC6JEv-duFj3+PUqq-jzrpTTnd1P8ihSeyB-FXY+JmjkEeam_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:38862 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbGNLzx (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 14 Jul 2015 07:55:53 -0400
In-Reply-To: <CAC6JEv-duFj3+PUqq-jzrpTTnd1P8ihSeyB-FXY+JmjkEeam_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Travis Rhoden <trhoden@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Gregory,

On 07/14/2015 01:03 PM, Gregory Farnum wrote:
> Hey Owen,
> I haven't followed any of the conversations you've had in ceph-deploy
> land, but I've been trying to keep track of the ones on ceph-devel et
> al. I can't comment on very much of it because I suck at Python =E2=80=
=94 I
> can write C in any language, and do so! ;)

/me giggles

Much much better than Fortran in any language.

On this subject:

I have to brush up my C++ myself and look forward to helping when I get
the opportunity and totally understand where you are coming from. I loo=
k
forward to getting back to C++, so when I get to this area I will need
lot of help from you guys who will probably pull your hair out and say =
I
am programming C++ like its 2005 even when it all comes back.

> I interject this comment because there are a lot of C developers in
> the community who are doing their best in Python, and it has
> historically been important (and, I think, still is?) that they be
> able to contribute meaningful change to our python codebases. I think
> that has biased a lot of the architecture decisions our python
> developers made over the years and I'm not sure if everybody's on the
> same page about it.

Of this I am sure.

> As an example, I can follow the include chains in ceph-deploy without
> any problem and make appropriate changes to them. The in-memory
> SQLAlchemy code you posted just left me scratching my head trying to
> figure out how any of it worked. That doesn't make it *bad*, but
> there's definitely a higher assumed knowledge base/learning curve
> which we'd need to decide we want to adopt. In ceph-deploy
> particularly that's a bit of a problem since it's (at least nominally=
,
> although that mission has been slowly eroded) supposed to be a model
> for people building their configuration management or other deploymen=
t
> systems.

=46or me this thread is about the fa=C3=A7ade pattern, which for me is =
a
separate discussion.

Both these discussions got intertwined, and I wish they could be unlink=
ed.

I wish I had never even talked of or mentioned SQLAlchemy, as this is a
very tiny detail that is almost unimportant compared to the use of
design patterns and in that discussion MVC in particular. It is one of
many ways we could implement a model and my ideal of how _I_ would do
things, and am still happy if people are keen on MVC but not SQLAlchemy=
=2E

I hope this thread can be limited to the discussion of the fa=C3=A7ade,=
 and
we move all MVC discussion to the MVC thread I started.

> Anyway, I hope this outside observation is helpful to everybody; if
> not please ignore. :)

It is helpful, I have been programming python for 12 years, and forget
that this has had an impact, and led me to not make issues cross
language enough.

Thanks

Owen

PS

Realising it is actually 12 years since some a collaborator at CERN gav=
e
me python test scripts to maintain when they left CERN, for the C++
project I was working on, is really scary.


> -Greg
>=20
> On Tue, Jul 14, 2015 at 11:41 AM, Owen Synge <osynge@suse.com> wrote:
>> Dear Travis,
>>
>> We clearly disagree in this area.
>>
>> I hope me explaining my perspective is not seen as unhelpful.
>>
>> On 07/09/2015 07:00 PM, Travis Rhoden wrote:
>>>> (2B) inflexible / complex include paths for shared code between fa=
cade
>>>>> implementations.
>>>>>
>>> I disagree here.  There are plenty of places to put code that is co=
mmon and does not have to be duplicated.  I definitely don=E2=80=99t wa=
nt code in each host module that knows how to deal with systemd. The co=
de that does have to be in each host module is how to detect/assign wha=
t init system is being used, and how to call into the appropriate (comm=
on) module to do what it needs.
>>>
>>> As for complex include paths, I=E2=80=99m not sure I have much of a=
n argument here other than to say that all frameworks have their conven=
tions.  I don=E2=80=99t see what we are doing as anything different tha=
n what is enforced/recommended by many frameworks/scaffolds popular in =
Web app and MVC paradigms like RoR, Pyramid, Django, etc.  It=E2=80=99s=
 just convention to learn.
>>
>> I don't understand why you chose to defend this. Please expand your
>> argument.
>>
>> I will not go into the negative side effects of importing modules as
>> objects in the include paths, as a work around for potential side
>> effects of our current fa=C3=A7ade model, as this topic is more comp=
lex than
>> the points I do raise in this email, but I will expand them should t=
hese
>> arguments not be valid, as I would like to understand where we inten=
d to
>> go, and how we minimise long term maintenance and maximise extensibi=
lity.
>>
>> Here are the simpler reasons why I don't agree:
>>
>> I hate the enforced code structures used my many "popular" framework=
s
>> especially common in web frameworks but I accept that these enforce =
very
>> clear standard design patterns that are known to scale and be extens=
ible
>> and you acknowledge this difference to the ceph-deploy code base sim=
ply
>> by calling them MVC. *
>>
>> Having enforced relative paths between code files defined by the
>> implementation of the code is a great limitation.
>>
>> While one can place code modules in the correct location if only one
>> thing defines the correct location, one can easily get into difficul=
ties
>> 2 obvious limitations in tolerating this are:
>>
>> (1) by having two parts of the code base enforcing relative paths
>> between modules.
>>
>> (2) by having relationships between modules become needlessly comple=
x
>> because the enforced relationship says the code must go in a place t=
hat
>> is not correct to solve the problem. (this is analogous to the death=
 of
>> hierarchical databases and their replacement with relational databas=
es)
>>
>> So since the issue is most serious if you have 2 components in the c=
ode
>> base that "enforce" module layout, and we only have one, we are only
>> preventing further components that "enforce" module layout.
>>
>> Admittedly neither of these issues has _prevented_ development on
>> ceph-deploy so far, or led to duplication now you withdrew your comm=
ents
>> about all fa=C3=A7ades being the same.
>>
>> Due to the fa=C3=A7ade defining module location we so far have, some=
 things
>> have become confused in where the module can be placed that are clea=
rly
>> OS specific.
>>
>> Examples include:
>>
>>         ceph_deploy/util/constants.py which is clearly includes cons=
tants that
>> are OS specific, such as package names.
>>
>>         ceph_deploy/util/pkg_managers.py which clearly is a set of O=
S specific
>> implementations.
>>
>> Both of these lead to unnecessary complications, when they could be
>> fa=C3=A7ades in their own right and should have the modules moved if=
 we
>> continue to have this enforced module location in the fa=C3=A7ade im=
plementation.
>>
>> This inconsistency will not effect customers but does effect the cla=
rity
>> of the code, and leads to more conditionals than we might have if we
>> took in my opinion a cleaner implementation to our model.
>>
>> I will _not_ provide sample code of improvements, as this may lead t=
o
>> people discussing irrelevant issues, until this point is resolved as=
 my
>> mistake, or an area that is agreed can be improved.
>>
>> Best regards
>>
>> Owen
>>
>>
>> * It is one the many reasons I abandoned django in favour of Pyramid=
 for
>> my personal projects, even though django only enforced separation of
>> components Model View and controller, pyramid to my recollection (it=
s
>> been 3 years at least) only recommended a module relationship path  =
=2E
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
