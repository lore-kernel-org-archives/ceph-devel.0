From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Signed-off-by and aliases
Date: Wed, 12 Aug 2015 13:54:22 +0300
Message-ID: <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com>
References: <55BBD384.7030703@dachary.org>
	<CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com>
	<55BFCAAB.1040707@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36840 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbHLKyY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Aug 2015 06:54:24 -0400
Received: by igbij6 with SMTP id ij6so109014005igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2015 03:54:23 -0700 (PDT)
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com. [209.85.223.175])
        by smtp.gmail.com with ESMTPSA id p79sm3613633iop.15.2015.08.12.03.54.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2015 03:54:23 -0700 (PDT)
Received: by iodb91 with SMTP id b91so15572449iod.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2015 03:54:22 -0700 (PDT)
In-Reply-To: <55BFCAAB.1040707@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 3, 2015 at 11:10 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 03/08/2015 21:18, John Spray wrote:
>> On Fri, Jul 31, 2015 at 8:59 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi Ceph,
>>>
>>> We require that each commit has a Signed-off-by line with the name =
and email of the author. The general idea is that the Ceph project trus=
ts each developer to understand what it entails[1]. There is no formal =
verification : the person submitting the patch could use a fake name or=
 publish code from someone else. In reality the odds of that happening =
and causing problem are so low that neither Ceph nor the Linux kernel f=
elt the need to impose a more formal process. There is no bullet proof =
process anyway, it's all about balancing risks and costs.
>>>
>>> If a contributor was using an alias that looks like a real name (fo=
r instance I could contribute under the name Louis Lavile), (s)he would=
 go unnoticed and her/his contribution would be accepted as any other. =
If the same contributor was using an alias that is obviously an alias (=
such as A. Nonymous), it would raise the question of accepting contribu=
tions Signed-off with an alias.
>>>
>>> I think Ceph should accept contributions that are signed with an al=
ias because it does not make a difference.
>>>
>>> From a lawyer perspective, there is a difference between an alias a=
nd a real name, of course. Should the author be in court, (s)he would h=
ave to prove (s)he is the person behind the alias. If (s)he was using h=
er/his real name, an ID card would be enough. And probably other differ=
ences that I don't see because IANAL. However since we already accept S=
igned-off-by that are not formally verified, we're already in a situati=
on where we implicitly accept aliases. Explicitly accepting aliases wou=
ld not change that, therefore it is not actually something we need to r=
un by lawyers because nothing changes from a legal standpoint.
>>>
>>> What do you think ?
>>
>> (Without any legal knowledge whatsoever, and speaking in general ter=
ms
>> rather than about any particular code or vendor's practices or
>> products)
>
> In these matters the project lead needs to make a decision that makes=
 sense and then ask a lawyers to implement it. We don't need to be lawy=
ers to do that.
>
>>
>> My understanding is that projects use a Signed-off-by line for the
>> contributor to certify that they agree with the "Developer's
>> Certificate of Origin".
>>
>> The purpose of a certificate or origin is that if I am distributing
>> AcmeProject packages, and EvilCorp says "hey, we found our highly
>> patented code in your package!" then I can say "actually this was
>> submitted by Elizabeth Windsor <liz@buckinghampalace.org>, who
>> certified to me that she had the rights to the code.  I can thus
>> demonstrate that the original infringement was by her, and any
>> infringement in my distribution of the software was accidental, I
>> acted in good faith."
>>
>> OTOH if I said "That code was contributed by A.Nonymous", then
>> EvilCorp would say "Well, that could just as easily have been one of
>> your own developers, acting anonymously, so you have not demonstrate=
d
>> that the infringement was unintentional".
>>
>> So in my opinion, it is necessary that any project wishing to apply =
a
>> "certificate of origin" process also needs to have a real name polic=
y.
>
> If that was indeed what a Signed-off-by does, I would also be against=
 using aliases. In reality a Signed-off-by is nothing more than a conve=
nient mean to get in touch with someone who claimed to be the author of=
 a patch.
>
> The companies making and distributing Free Software using Signed-off-=
by like Ceph does, do not attempt to even verify that the person behind=
 the Signed-off-by really is who (s)he claims. I don't think that's bec=
ause they have been careless for the past decade. I think that's becaus=
e it would not make a significant difference and that it would be a bur=
den to the project. The company lawyers would certainly claim that it w=
ould be better to verify the identity for each Signed-off-by. But in pr=
actice they don't push for it, not even for the Linux kernel who went i=
nto more legal troubles than any other Free Software project.
>
> My point is that there could already be a dozen of aliases that look =
like real names in the current Signed-off-by list. Explicitly accepting=
 aliases that look like aliases would just be an acknowledgement of wha=
t we already do.

I won't be merging any code with obvious aliases for exactly the
reasons John mentions. Obviously IANAL, but I think you'll find law
proceedings in the USA would look much less kindly on accepting
obvious aliases versus having a real name policy =E2=80=94 which we do,=
 even
if it's not diligently checked. Keep in mind that we generally have a
background on our contributors to track them down even if they are
using a non-obvious alias.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
