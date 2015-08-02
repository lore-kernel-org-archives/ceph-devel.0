From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Signed-off-by and aliases
Date: Sun, 02 Aug 2015 17:19:39 +0100
Message-ID: <55BE431B.4070202@suse.de>
References: <55BBD384.7030703@dachary.org> <55BC7F4E.5070003@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47409 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbbHBQTk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 2 Aug 2015 12:19:40 -0400
In-Reply-To: <55BC7F4E.5070003@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 08/01/2015 09:11 AM, Wido den Hollander wrote:
> On 07/31/2015 09:59 PM, Loic Dachary wrote:
>> Hi Ceph,
>>
>> We require that each commit has a Signed-off-by line with the name and email of the author. The general idea is that the Ceph project trusts each developer to understand what it entails[1]. There is no formal verification : the person submitting the patch could use a fake name or publish code from someone else. In reality the odds of that happening and causing problem are so low that neither Ceph nor the Linux kernel felt the need to impose a more formal process. There is no bullet proof process anyway, it's all about balancing risks and costs.
>>
>> If a contributor was using an alias that looks like a real name (for instance I could contribute under the name Louis Lavile), (s)he would go unnoticed and her/his contribution would be accepted as any other. If the same contributor was using an alias that is obviously an alias (such as A. Nonymous), it would raise the question of accepting contributions Signed-off with an alias.
>>
>> I think Ceph should accept contributions that are signed with an alias because it does not make a difference.
>>
>> From a lawyer perspective, there is a difference between an alias and a real name, of course. Should the author be in court, (s)he would have to prove (s)he is the person behind the alias. If (s)he was using her/his real name, an ID card would be enough. And probably other differences that I don't see because IANAL. However since we already accept Signed-off-by that are not formally verified, we're already in a situation where we implicitly accept aliases. Explicitly accepting aliases would not change that, therefore it is not actually something we need to run by lawyers because nothing changes from a legal standpoint.
>>
>> What do you think ?
>>
> 
> Using an alias is just dumb since it would only make you loose the
> copyright since it's not you doing the commit.

Do you have a source that corroborates this statement? I would be deeply
grateful if you could point me to something of the sorts :)

As far as I could gather however, this doesn't seem to hold up.

As per the Berne Convention's Article 15 [1] number (1), identification
of an author is possible even using a pseudonym, where said pseudonym
"leaves no doubt as to his identity"; number (3) further states that

"In the case of anonymous and pseudonymous works, other than those
referred to in paragraph (1) above, the publisher whose name appears on
the work shall, in the absence of proof to the contrary, be deemed to
represent the author, and in this capacity he shall be entitled to
protect and enforce the author's rights. The provisions of this
paragraph shall cease to apply when the author reveals his identity and
establishes his claim to authorship of the work."

So this would have me believing that, as long as the original author has
some means of proving he is the original author using a given pseudonym,
said author can at any point in time reclaim authorship.

IANAL, but would think this whole thing hinges however on the
contribution being considered a 'work' that could benefit of protection.

  -Joao

[1] -
http://www.wipo.int/wipolex/en/treaties/text.jsp?file_id=283698#P192_37445



> 
> However, if we want to go for security, there is also a way to sign your
> Git commits using GPG [2].
> 
> [2]: https://git-scm.com/book/tr/v2/Git-Tools-Signing-Your-Work
> 
>> Cheers
>>
>> [1] SIGNING CONTRIBUTIONS https://github.com/ceph/ceph/blob/master/SubmittingPatches#L13
>>
> 
> 

