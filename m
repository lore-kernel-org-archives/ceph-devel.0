From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: proposal to stop using "backport: " in commit logs
Date: Tue, 14 Apr 2015 00:59:24 +0100
Message-ID: <552C585C.9030807@suse.de>
References: <552BF349.50909@redhat.com>	<CAC6JEv8BqBkispnR7xZmC66p8YO4ckHH2mQFy_vt6MB+U=u-ZA@mail.gmail.com>	<552BFCBA.2010201@dachary.org> <CAC6JEv8DTj2mdJspfe8Xo9VOFaRgH6egz3Uh2V_wo-UcwdXfSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49483 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbbDMX7Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 19:59:25 -0400
In-Reply-To: <CAC6JEv8DTj2mdJspfe8Xo9VOFaRgH6egz3Uh2V_wo-UcwdXfSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>, Loic Dachary <loic@dachary.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/13/2015 07:53 PM, Gregory Farnum wrote:
> On Mon, Apr 13, 2015 at 10:28 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>> Hi Greg,
>>
>> On 13/04/2015 19:04, Gregory Farnum wrote:
>>> On Mon, Apr 13, 2015 at 9:48 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
>>>> A while ago this came up in #ceph-devel and I wanted to bring it to a
>>>> wider audience.
>>>>
>>>> Should we stop the convention of adding the "backport: " tags in Git?
>>>>
>>>> Loic brought up the point that this data is essentially immutable after
>>>> we merge it, and it's better to point at a Redmine tracker where we can
>>>> alter the "backport" field.
>>>>
>>>> This makes it easier to adjust the "backport" data after the code's been
>>>> merged to master. It also makes it easier for whoever is corralling the
>>>> backport efforts, because the person only have one place to look
>>>> (Redmine) instead of two (Redmine + git commit logs).
>>>>
>>>> For what it's worth I agree with Loic on this.
>>>>
>>>> Any objections?
>>>
>>> Why don't we just treat the backport commit tag as an expected value,
>>> and any corresponding redmine data as the canonical one?
>>
>> That's what we currently do, I think.
>>
>>> I find the
>>> backport tags to be useful when reviewing commits and I think the
>>> authorial intention matters.
>>
>> A git-notes could be added for that purpose instead.
> 
> Huh, I'm not previously familiar with that mechanism. Is there any
> particular reason you didn't use that for tracking backport states to
> begin with? It looks like it's sort of designed for this purpose.

I agree.  git-notes seem like the way to go for this -- also, mind blown
at finding about git-notes, looks amazing!

  -Joao

