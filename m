From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 5 May 2015 07:31:11 -0700
Message-ID: <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com>
References: <5548807A.6060103@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33675 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993184AbbEEObN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 10:31:13 -0400
Received: by iecrt8 with SMTP id rt8so146341580iec.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 May 2015 07:31:12 -0700 (PDT)
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com. [209.85.213.175])
        by mx.google.com with ESMTPSA id z3sm7399439igr.7.2015.05.05.07.31.11
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2015 07:31:11 -0700 (PDT)
Received: by iget9 with SMTP id t9so79504738ige.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 May 2015 07:31:11 -0700 (PDT)
In-Reply-To: <5548807A.6060103@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Kefu Chai <kchai@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 5, 2015 at 1:34 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Kefu,
>
> In the context of https://github.com/ceph/ceph/pull/4449 and https://=
github.com/ceph/ceph/pull/4544 I see you're going out of your way to im=
plement mechanisms that make it possible to require less dependencies w=
hen running
>
>    ./configure
>
> than what is required by
>
>    ./make check
>
> I think the right solution is to require the same set of dependencies=
, regardless. It can easily be done by running ./install-deps.sh[1].
>
> This script is already used in jenkins.ceph.com and saved us from the=
 recurring pain of manually updating the jenkins slaves every time a de=
pendency was added to either ceph.spec.in or debian/control.
>
> Although it is possible to run ./configure with a subset of the depen=
dencies that are required to run make check, it trades automatic instal=
lation of packages for significant manual maintenance. It saves a littl=
e disk and bandwidth every time a dependency is modified in the ceph.sp=
ec.in or debian/control files, which happens a few times a months at mo=
st. The work items to manually maintain this difference:
>
> * the set of dependencies that ./configure requires needs to be manua=
lly maintained, it is not listed anywhere at the moment. It changes les=
s often than ceph.spec.in or debian/control but it does change from tim=
e to time
> * the configure script has to be engineered to only require dependenc=
ies (assuming these dependencies are listed somewhere). In other word, =
every time you change the configure script you have to be extra careful=
 to not introduce a new dependency, even when it would help implement w=
hat you're after in a simpler way.
> * the configure script dependencies in the context of CI actually cha=
nge every time you consider using --enable-something because it modifie=
s the set of files your tarbal is made of. If the corresponding somethi=
ng is not installed, the configure will likely not do what you want and=
 you'll have to add something manually on the CI machine (or use instal=
l-deps.sh but that would defeat the purpose of separating configure dep=
endencies from make dependencies)
> * to avoid adding dependencies to configure, it is tempting to forbid=
 file generation when preparing the tarbal (I'm thinking .8 generation =
specifically), although it is legitimate for the tarbal generation to i=
nvolve some processing and transformation of the sources that require t=
ools to run
> * it is very unlikely a new developer will remember configure depende=
ncies and make dependencies are different and mistakes will be done all=
 the time, creating needless frustration

Maybe I'm missing something, but...

configure's purpose in life is to set up the build system so that Ceph
will successfully build on the current system. If configure assumes
that you have stuff installed that you don't need to have installed to
build, then it is not doing its job.
Similarly, if "make check" won't run on a system that otherwise builds
Ceph, that's a problem with "make check", not a problem with configure
or the rest of Ceph. If we require *extra* dependencies to support
make check that's very bad =E2=80=94 it's becoming more popular for ven=
dors to
build Ceph on more exotic architectures and systems, and the chances
are good that they'll do the minimal porting job, and simply skip
running "make check" if it requires extra bits.

Now, there are times when we decide something is important so we have
configure default to one configuration and require a flag to change
it. But in general that's not what we want to do, and IIRC there was
an issue where configure was actually failing despite it being
perfectly fine to build without some library or other.

Etc etc.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
