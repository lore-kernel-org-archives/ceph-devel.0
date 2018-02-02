From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Better anticipation for minor releases
Date: Fri, 2 Feb 2018 22:35:20 +0100
Message-ID: <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com>
 <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
 <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz>
 <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
 <robbat2-20180202T195241-795645967Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeBBVfX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:35:23 -0500
In-Reply-To: <robbat2-20180202T195241-795645967Z@orbis-terrarum.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>, Ken Dreyer <kdreyer@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 02/02/2018 08:55 PM, Robin H. Johnson wrote:
> On Fri, Feb 02, 2018 at 10:15:14AM -0700, Ken Dreyer wrote:
>> This is just my opinion: we should have a quick "bump commit + tag"
>> Jenkins job that pushes the Git tag live as soon as possible. In
>> particular we should not wait for packages to be build + signed +
>> published on download.ceph.com before pushing the bump commit + tag
>> live.
>>
>> Bumping and tagging in Git should take a minute or two, whereas
>> building, signing, and rsync'ing all the packages for that tag takes
>> hours. I think this time-intensive process causes the Git history to
>> diverge for too long.
> Thought:
> - Tag or branch a candidate commit for going INTO the QE phase, say
>    v12.2.3-rcX.
> - Run QE on that tag.
> - If QE passes entirely, create final tag at same commit as rc tag.

That assumes it's possible the release tooling supports releasing 
something other than the tip of a branch (i.e. a SHA1 or tag), though, 
right?

Nathan
