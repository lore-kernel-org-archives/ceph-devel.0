From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS and the next giant release v0.87.2
Date: Thu, 16 Apr 2015 16:22:48 -0700
Message-ID: <CAC6JEv9FuG8Vr=SjwuACrggj4U8-Qe82u-K9Bu_ZOSapSGWkYQ@mail.gmail.com>
References: <552E316D.5060703@dachary.org>
	<CAC6JEv8iAOHb2+R9TXFwQ0BnmaY-zYfq4E7MzZsK_Doa7LN5gA@mail.gmail.com>
	<553042E5.4040501@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34032 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbDPXWt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 19:22:49 -0400
Received: by iget9 with SMTP id t9so18271697ige.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 16:22:49 -0700 (PDT)
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com. [209.85.213.180])
        by mx.google.com with ESMTPSA id d8sm140776igl.19.2015.04.16.16.22.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 16:22:48 -0700 (PDT)
Received: by igbhj9 with SMTP id hj9so1844775igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 16:22:48 -0700 (PDT)
In-Reply-To: <553042E5.4040501@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

On Thu, Apr 16, 2015 at 4:16 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> On 17/04/2015 00:44, Gregory Farnum wrote:
>> On Wed, Apr 15, 2015 at 2:37 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi Greg,
>>>
>>> The next giant release as found at https://github.com/ceph/ceph/tree/giant passed the fs suite (http://tracker.ceph.com/issues/11153#fs). Do you think it is ready for QE to start their own round of testing ?
>>>
>>> Note that it will be the last giant release.
>>>
>>> Cheers
>>>
>>> P.S. http://tracker.ceph.com/issues/11153#Release-information has direct links to the pull requests merged into giant since v0.87.1 in case you need more context about one of them.
>>
>> All those PRs look like fine ones to release.
>>
>> I remember you went through a big purge of giant-tagged backports at
>> one point though (when we thought we weren't going to do any more
>> releases at all). Did that get somehow undone and all of those dealt
>> with?
>
> I inadvertendly closed a few issue that I should not have (less than 10 more than 5 IIRC). I carefully reviewed all of them and they have been dealt with indeed. There now is a HOWTO to prevent that kind of mistake, hopefully. http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_resolve_issues_that_are_Pending_Backport
>
>> Some of them were more important than others and it would be
>> some work for me to reconstruct the list, but I'll need to do that if
>> you haven't already. :/
>
> There are a four giant issues that are candidate for backporting : http://tracker.ceph.com/projects/ceph/issues?query_id=68, only one of which is related to CephFS. Do you think it must be included in this last giant release ?

Nope, not that one!

This all looks good to me then, thanks.
-Greg
