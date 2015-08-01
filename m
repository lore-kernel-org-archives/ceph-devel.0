From: Wido den Hollander <wido@42on.com>
Subject: Re: Signed-off-by and aliases
Date: Sat, 01 Aug 2015 10:11:58 +0200
Message-ID: <55BC7F4E.5070003@42on.com>
References: <55BBD384.7030703@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:60009 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbbHAIMD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 Aug 2015 04:12:03 -0400
In-Reply-To: <55BBD384.7030703@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 07/31/2015 09:59 PM, Loic Dachary wrote:
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
> 

Using an alias is just dumb since it would only make you loose the
copyright since it's not you doing the commit.

However, if we want to go for security, there is also a way to sign your
Git commits using GPG [2].

[2]: https://git-scm.com/book/tr/v2/Git-Tools-Signing-Your-Work

> Cheers
> 
> [1] SIGNING CONTRIBUTIONS https://github.com/ceph/ceph/blob/master/SubmittingPatches#L13
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
