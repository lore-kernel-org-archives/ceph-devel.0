From: Owen Synge <osynge@suse.com>
Subject: Difference between convention and enforcement.
Date: Tue, 14 Jul 2015 12:41:26 +0200
Message-ID: <55A4E756.7090206@suse.com>
References: <559E4814.8030007@suse.com> <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:36863 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbGNKnV (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 14 Jul 2015 06:43:21 -0400
In-Reply-To: <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@redhat.com>
Cc: ceph-devel@vger.kernel.org

Dear Travis,

We clearly disagree in this area.

I hope me explaining my perspective is not seen as unhelpful.

On 07/09/2015 07:00 PM, Travis Rhoden wrote:
>> (2B) inflexible / complex include paths for shared code between faca=
de
>> > implementations.
>> >=20
> I disagree here.  There are plenty of places to put code that is comm=
on and does not have to be duplicated.  I definitely don=E2=80=99t want=
 code in each host module that knows how to deal with systemd. The code=
 that does have to be in each host module is how to detect/assign what =
init system is being used, and how to call into the appropriate (common=
) module to do what it needs.
>=20
> As for complex include paths, I=E2=80=99m not sure I have much of an =
argument here other than to say that all frameworks have their conventi=
ons.  I don=E2=80=99t see what we are doing as anything different than =
what is enforced/recommended by many frameworks/scaffolds popular in We=
b app and MVC paradigms like RoR, Pyramid, Django, etc.  It=E2=80=99s j=
ust convention to learn.

I don't understand why you chose to defend this. Please expand your
argument.

I will not go into the negative side effects of importing modules as
objects in the include paths, as a work around for potential side
effects of our current fa=C3=A7ade model, as this topic is more complex=
 than
the points I do raise in this email, but I will expand them should thes=
e
arguments not be valid, as I would like to understand where we intend t=
o
go, and how we minimise long term maintenance and maximise extensibilit=
y.

Here are the simpler reasons why I don't agree:

I hate the enforced code structures used my many "popular" frameworks
especially common in web frameworks but I accept that these enforce ver=
y
clear standard design patterns that are known to scale and be extensibl=
e
and you acknowledge this difference to the ceph-deploy code base simply
by calling them MVC. *

Having enforced relative paths between code files defined by the
implementation of the code is a great limitation.

While one can place code modules in the correct location if only one
thing defines the correct location, one can easily get into difficultie=
s
2 obvious limitations in tolerating this are:

(1) by having two parts of the code base enforcing relative paths
between modules.

(2) by having relationships between modules become needlessly complex
because the enforced relationship says the code must go in a place that
is not correct to solve the problem. (this is analogous to the death of
hierarchical databases and their replacement with relational databases)

So since the issue is most serious if you have 2 components in the code
base that "enforce" module layout, and we only have one, we are only
preventing further components that "enforce" module layout.

Admittedly neither of these issues has _prevented_ development on
ceph-deploy so far, or led to duplication now you withdrew your comment=
s
about all fa=C3=A7ades being the same.

Due to the fa=C3=A7ade defining module location we so far have, some th=
ings
have become confused in where the module can be placed that are clearly
OS specific.

Examples include:

	ceph_deploy/util/constants.py which is clearly includes constants that
are OS specific, such as package names.

	ceph_deploy/util/pkg_managers.py which clearly is a set of OS specific
implementations.

Both of these lead to unnecessary complications, when they could be
fa=C3=A7ades in their own right and should have the modules moved if we
continue to have this enforced module location in the fa=C3=A7ade imple=
mentation.

This inconsistency will not effect customers but does effect the clarit=
y
of the code, and leads to more conditionals than we might have if we
took in my opinion a cleaner implementation to our model.

I will _not_ provide sample code of improvements, as this may lead to
people discussing irrelevant issues, until this point is resolved as my
mistake, or an area that is agreed can be improved.

Best regards

Owen


* It is one the many reasons I abandoned django in favour of Pyramid fo=
r
my personal projects, even though django only enforced separation of
components Model View and controller, pyramid to my recollection (its
been 3 years at least) only recommended a module relationship path  .
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
