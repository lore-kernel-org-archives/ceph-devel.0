From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Better anticipation for minor releases
Date: Fri, 2 Feb 2018 13:28:57 +0100
Message-ID: <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com>
 <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeBBM26 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:28:58 -0500
In-Reply-To: <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-devel-owner@vger.kernel.org

On 02/02/2018 01:05 PM, Alfredo Deza wrote:
>> If we approximately stop accepting new PRs at the third week, ask leads at
>> beginning of week 4 and go through only critical PRs for week 4; and go to
>> QE in week5,6 we might be able to somewhat get to a more scheduled minor
>> releases.
> 
> This might be a bit hard to deal with, how do you prevent a PR from
> getting merged? I've seen several times PRs getting merged at the last
> minute,
> with little to no testing, and breaking a release :( It hasn't
> happened much lately, but I don't know of a way to block all PRs for a
> period of time

Do we have a way of releasing a given SHA1 (which has passed QE) even 
when additional PRs have been merged on top of it?

IIRC in the past we could only release the tip of the named (jewel, 
luminous) branch. That does indeed create a risk of PRs getting merged 
post-QE and inadvertently finding their way into a release.

Nathan
