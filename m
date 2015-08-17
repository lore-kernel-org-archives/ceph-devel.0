From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Signed-off-by and aliases
Date: Mon, 17 Aug 2015 13:19:21 -0700
Message-ID: <mqtfkc$ic7$1@ger.gmane.org>
References: <55BBD384.7030703@dachary.org> <CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com> <55BFCAAB.1040707@dachary.org> <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com> <55CB4163.9040504@dachary.org> <55CDABB2.4080401@suse.de> <55CDC978.20304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59920 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbbHQUTb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Aug 2015 16:19:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZRQsT-0003Ek-A5
	for ceph-devel@vger.kernel.org; Mon, 17 Aug 2015 22:19:29 +0200
Received: from 66.87.139.27 ([66.87.139.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2015 22:19:29 +0200
Received: from eternaleye by 66.87.139.27 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2015 22:19:29 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Loic Dachary wrote:

> Hi Joao,
<snipping quite a bit>

> It is quite impossible for us (non lawyers) to draw the line that
> separates parano=C3=AFa and common sense. Reason why most discussions=
 on these
> topics turn short. I cannot dismiss the scenario you describe and I'm
> quite sure asking a lawyer would not clarify anything. Mostly because
> whatever the question, the lawyer answer will always be : "maybe" and
> never "yes" or "no" ;-)

There are cases where lawyer's will say "yes" or "no" - it's just that =
those=20
tend to be "Yes, this will cost a lot of effort to succeed against" and=
 "No,=20
I don't think we can successfully argue that" :P

> Yet, we are to decide what makes sense and what does not. If you ask =
the
> OpenStack community, the majority agree that it is necessary to have =
a
> CLA. If you ask the Linux kernel community, the consensus seems to be=
 that
> there is no need for a CLA. etc.

I think part of the issue here is that "CLA" is a very overloaded term =
(in=20
the C++ sense).

Some use it to refer to copyright assignment, which is a portion of som=
e=20
CLAs.

Some use it to refer to "thick" CLAs, like the Project Harmony ones, wh=
ich=20
may or may not have copyright assignment depending on the individual CL=
A.

Others use it to refer to _any_ formal agreement regarding licensing be=
tween=20
the code author and some entity responsible for the overall body of cod=
e -=20
under which definition the kernel DCO qualifies.

Personally, I fall into the camp that says that a DCO-like system, whic=
h=20
ensures that input =3D output and attests to the right to submit, is=20
sufficient: Whethern the person submits the DCO under an alias or not, =
they=20
have asserted that *submissions under this name (even if it's an alias)=
 will=20
abide by the DCO* - and thus people accepting those patches have a reas=
on to=20
believe that the submissions are "clean" and in good faith.

Also, if that model came under fire, various groups involved in the ker=
nel=20
would have a vested interest in helping defend it. That's not a small t=
hing=20
to backstop on.

> So, how can one make an opinion on a topic (s)he does not fully under=
stand
> ? I chose to decide based on facts I have and favor what give us (the=
 Ceph
> project community) more flexibility. I don't think anyone has any fac=
t
> regarding legal troubles related to contributor using aliases. And si=
nce
> we don't verify contributor backgrounds anyway, acknowledging that we
> already accept aliases makes sense to me.

This is where I see a subtle, but meaningful distinction: Accepting fro=
m=20
aliases *which have submitted a DCO* means that the person behind the a=
lias,=20
even if we don't know their name, has bound themselves to a standard ov=
=20
behavior.

Accepting from arbitrary aliases does _not_ carry that meaning.

> The value of this thread is more about how we collectively form a
> consensus on a topic that has legal implications than the question of
> accepting aliases or not. As Greg mentioned, all developers/organizat=
ions
> holding a significant part of the Ceph copyright know each other. Wha=
tever
> is decided regarding aliases, it is not going to have any actual lega=
l
> impact. But it would be great if we can somehow come up with a consen=
sus.
> Ultimately the decision is not for us to make anyway: we're not a
> democracy. But it's not because a community has no power to decide th=
at it
> must not have an opinion ;-)

Entirely agreed.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
