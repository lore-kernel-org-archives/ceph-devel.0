From: John Spray <jspray@redhat.com>
Subject: Re: Signed-off-by and aliases
Date: Mon, 3 Aug 2015 20:18:20 +0100
Message-ID: <CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com>
References: <55BBD384.7030703@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33831 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbHCTSk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 15:18:40 -0400
Received: by pawu10 with SMTP id u10so19291152paw.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 12:18:39 -0700 (PDT)
In-Reply-To: <55BBD384.7030703@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 31, 2015 at 8:59 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> We require that each commit has a Signed-off-by line with the name and email of the author. The general idea is that the Ceph project trusts each developer to understand what it entails[1]. There is no formal verification : the person submitting the patch could use a fake name or publish code from someone else. In reality the odds of that happening and causing problem are so low that neither Ceph nor the Linux kernel felt the need to impose a more formal process. There is no bullet proof process anyway, it's all about balancing risks and costs.
>
> If a contributor was using an alias that looks like a real name (for instance I could contribute under the name Louis Lavile), (s)he would go unnoticed and her/his contribution would be accepted as any other. If the same contributor was using an alias that is obviously an alias (such as A. Nonymous), it would raise the question of accepting contributions Signed-off with an alias.
>
> I think Ceph should accept contributions that are signed with an alias because it does not make a difference.
>
> From a lawyer perspective, there is a difference between an alias and a real name, of course. Should the author be in court, (s)he would have to prove (s)he is the person behind the alias. If (s)he was using her/his real name, an ID card would be enough. And probably other differences that I don't see because IANAL. However since we already accept Signed-off-by that are not formally verified, we're already in a situation where we implicitly accept aliases. Explicitly accepting aliases would not change that, therefore it is not actually something we need to run by lawyers because nothing changes from a legal standpoint.
>
> What do you think ?

(Without any legal knowledge whatsoever, and speaking in general terms
rather than about any particular code or vendor's practices or
products)

My understanding is that projects use a Signed-off-by line for the
contributor to certify that they agree with the "Developer's
Certificate of Origin".

The purpose of a certificate or origin is that if I am distributing
AcmeProject packages, and EvilCorp says "hey, we found our highly
patented code in your package!" then I can say "actually this was
submitted by Elizabeth Windsor <liz@buckinghampalace.org>, who
certified to me that she had the rights to the code.  I can thus
demonstrate that the original infringement was by her, and any
infringement in my distribution of the software was accidental, I
acted in good faith."

OTOH if I said "That code was contributed by A.Nonymous", then
EvilCorp would say "Well, that could just as easily have been one of
your own developers, acting anonymously, so you have not demonstrated
that the infringement was unintentional".

So in my opinion, it is necessary that any project wishing to apply a
"certificate of origin" process also needs to have a real name policy.

John
