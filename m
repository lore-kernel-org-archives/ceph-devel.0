From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Difference between convention and enforcement.
Date: Tue, 14 Jul 2015 12:03:34 +0100
Message-ID: <CAC6JEv-duFj3+PUqq-jzrpTTnd1P8ihSeyB-FXY+JmjkEeam_w@mail.gmail.com>
References: <559E4814.8030007@suse.com>
	<6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com>
	<55A4E756.7090206@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36167 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbbGNLDg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jul 2015 07:03:36 -0400
Received: by ieik3 with SMTP id k3so8621734iei.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2015 04:03:35 -0700 (PDT)
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com. [209.85.213.176])
        by smtp.gmail.com with ESMTPSA id h7sm7641359igt.3.2015.07.14.04.03.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 04:03:34 -0700 (PDT)
Received: by iggf3 with SMTP id f3so9274298igg.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2015 04:03:34 -0700 (PDT)
In-Reply-To: <55A4E756.7090206@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Travis Rhoden <trhoden@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hey Owen,
I haven't followed any of the conversations you've had in ceph-deploy
land, but I've been trying to keep track of the ones on ceph-devel et
al. I can't comment on very much of it because I suck at Python =E2=80=94=
 I
can write C in any language, and do so! ;)

I interject this comment because there are a lot of C developers in
the community who are doing their best in Python, and it has
historically been important (and, I think, still is?) that they be
able to contribute meaningful change to our python codebases. I think
that has biased a lot of the architecture decisions our python
developers made over the years and I'm not sure if everybody's on the
same page about it.

As an example, I can follow the include chains in ceph-deploy without
any problem and make appropriate changes to them. The in-memory
SQLAlchemy code you posted just left me scratching my head trying to
figure out how any of it worked. That doesn't make it *bad*, but
there's definitely a higher assumed knowledge base/learning curve
which we'd need to decide we want to adopt. In ceph-deploy
particularly that's a bit of a problem since it's (at least nominally,
although that mission has been slowly eroded) supposed to be a model
for people building their configuration management or other deployment
systems.

Anyway, I hope this outside observation is helpful to everybody; if
not please ignore. :)
-Greg

On Tue, Jul 14, 2015 at 11:41 AM, Owen Synge <osynge@suse.com> wrote:
> Dear Travis,
>
> We clearly disagree in this area.
>
> I hope me explaining my perspective is not seen as unhelpful.
>
> On 07/09/2015 07:00 PM, Travis Rhoden wrote:
>>> (2B) inflexible / complex include paths for shared code between fac=
ade
>>> > implementations.
>>> >
>> I disagree here.  There are plenty of places to put code that is com=
mon and does not have to be duplicated.  I definitely don=E2=80=99t wan=
t code in each host module that knows how to deal with systemd. The cod=
e that does have to be in each host module is how to detect/assign what=
 init system is being used, and how to call into the appropriate (commo=
n) module to do what it needs.
>>
>> As for complex include paths, I=E2=80=99m not sure I have much of an=
 argument here other than to say that all frameworks have their convent=
ions.  I don=E2=80=99t see what we are doing as anything different than=
 what is enforced/recommended by many frameworks/scaffolds popular in W=
eb app and MVC paradigms like RoR, Pyramid, Django, etc.  It=E2=80=99s =
just convention to learn.
>
> I don't understand why you chose to defend this. Please expand your
> argument.
>
> I will not go into the negative side effects of importing modules as
> objects in the include paths, as a work around for potential side
> effects of our current fa=C3=A7ade model, as this topic is more compl=
ex than
> the points I do raise in this email, but I will expand them should th=
ese
> arguments not be valid, as I would like to understand where we intend=
 to
> go, and how we minimise long term maintenance and maximise extensibil=
ity.
>
> Here are the simpler reasons why I don't agree:
>
> I hate the enforced code structures used my many "popular" frameworks
> especially common in web frameworks but I accept that these enforce v=
ery
> clear standard design patterns that are known to scale and be extensi=
ble
> and you acknowledge this difference to the ceph-deploy code base simp=
ly
> by calling them MVC. *
>
> Having enforced relative paths between code files defined by the
> implementation of the code is a great limitation.
>
> While one can place code modules in the correct location if only one
> thing defines the correct location, one can easily get into difficult=
ies
> 2 obvious limitations in tolerating this are:
>
> (1) by having two parts of the code base enforcing relative paths
> between modules.
>
> (2) by having relationships between modules become needlessly complex
> because the enforced relationship says the code must go in a place th=
at
> is not correct to solve the problem. (this is analogous to the death =
of
> hierarchical databases and their replacement with relational database=
s)
>
> So since the issue is most serious if you have 2 components in the co=
de
> base that "enforce" module layout, and we only have one, we are only
> preventing further components that "enforce" module layout.
>
> Admittedly neither of these issues has _prevented_ development on
> ceph-deploy so far, or led to duplication now you withdrew your comme=
nts
> about all fa=C3=A7ades being the same.
>
> Due to the fa=C3=A7ade defining module location we so far have, some =
things
> have become confused in where the module can be placed that are clear=
ly
> OS specific.
>
> Examples include:
>
>         ceph_deploy/util/constants.py which is clearly includes const=
ants that
> are OS specific, such as package names.
>
>         ceph_deploy/util/pkg_managers.py which clearly is a set of OS=
 specific
> implementations.
>
> Both of these lead to unnecessary complications, when they could be
> fa=C3=A7ades in their own right and should have the modules moved if =
we
> continue to have this enforced module location in the fa=C3=A7ade imp=
lementation.
>
> This inconsistency will not effect customers but does effect the clar=
ity
> of the code, and leads to more conditionals than we might have if we
> took in my opinion a cleaner implementation to our model.
>
> I will _not_ provide sample code of improvements, as this may lead to
> people discussing irrelevant issues, until this point is resolved as =
my
> mistake, or an area that is agreed can be improved.
>
> Best regards
>
> Owen
>
>
> * It is one the many reasons I abandoned django in favour of Pyramid =
for
> my personal projects, even though django only enforced separation of
> components Model View and controller, pyramid to my recollection (its
> been 3 years at least) only recommended a module relationship path  .
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
