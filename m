From: Gregory Farnum <greg@gregs42.com>
Subject: Re: proposal to stop using "backport: " in commit logs
Date: Mon, 13 Apr 2015 11:53:07 -0700
Message-ID: <CAC6JEv8DTj2mdJspfe8Xo9VOFaRgH6egz3Uh2V_wo-UcwdXfSg@mail.gmail.com>
References: <552BF349.50909@redhat.com>
	<CAC6JEv8BqBkispnR7xZmC66p8YO4ckHH2mQFy_vt6MB+U=u-ZA@mail.gmail.com>
	<552BFCBA.2010201@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38448 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbbDMSxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 14:53:09 -0400
Received: by igbqf9 with SMTP id qf9so52192267igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 11:53:08 -0700 (PDT)
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com. [209.85.213.172])
        by mx.google.com with ESMTPSA id 72sm1702930iof.36.2015.04.13.11.53.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2015 11:53:08 -0700 (PDT)
Received: by igblo3 with SMTP id lo3so54401254igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 11:53:07 -0700 (PDT)
In-Reply-To: <552BFCBA.2010201@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Apr 13, 2015 at 10:28 AM, Loic Dachary <loic@dachary.org> wrote:
>
> Hi Greg,
>
> On 13/04/2015 19:04, Gregory Farnum wrote:
>> On Mon, Apr 13, 2015 at 9:48 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
>>> A while ago this came up in #ceph-devel and I wanted to bring it to a
>>> wider audience.
>>>
>>> Should we stop the convention of adding the "backport: " tags in Git?
>>>
>>> Loic brought up the point that this data is essentially immutable after
>>> we merge it, and it's better to point at a Redmine tracker where we can
>>> alter the "backport" field.
>>>
>>> This makes it easier to adjust the "backport" data after the code's been
>>> merged to master. It also makes it easier for whoever is corralling the
>>> backport efforts, because the person only have one place to look
>>> (Redmine) instead of two (Redmine + git commit logs).
>>>
>>> For what it's worth I agree with Loic on this.
>>>
>>> Any objections?
>>
>> Why don't we just treat the backport commit tag as an expected value,
>> and any corresponding redmine data as the canonical one?
>
> That's what we currently do, I think.
>
>> I find the
>> backport tags to be useful when reviewing commits and I think the
>> authorial intention matters.
>
> A git-notes could be added for that purpose instead.

Huh, I'm not previously familiar with that mechanism. Is there any
particular reason you didn't use that for tracking backport states to
begin with? It looks like it's sort of designed for this purpose.
