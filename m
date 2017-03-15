From: David Zafman <dzafman@redhat.com>
Subject: Re: [PATCH 1/1] EC backfill retries
Date: Wed, 15 Mar 2017 13:38:54 -0700
Message-ID: <52362dc8-faca-82f4-b1ac-dc7df6150afe@redhat.com>
References: <ormvcx2dr8.fsf@lxoliva.fsfla.org>
 <06c85dc1-3318-fc05-ec1a-7f68d3aecc37@redhat.com>
 <ork27qguwv.fsf@lxoliva.fsfla.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdCOUqF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 15 Mar 2017 16:46:05 -0400
In-Reply-To: <ork27qguwv.fsf@lxoliva.fsfla.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org


If it applies cleanly, base your code off of current jewel and specify 
any commits that needs to be cherry-picked so I can pull them in.  Doing 
this allows you to send in e-mail again.

Otherwise, create a pull request yourself.  Or push it all to the main 
ceph repo and giving me a branch name.

David


On 3/15/17 1:13 PM, Alexandre Oliva wrote:
> On Mar 10, 2017, David Zafman <dzafman@redhat.com> wrote:
>
>>      I can't apply your patch because sha1 e3eb1fd isn't in the ceph
>> repo
> That's no surprise; that's the result of my cherry-picking the two
> patches I listed as dependencies of mine.
>
>> and it won't apply cleanly.
> Do you have those two patches in the tree?  (see the first quoted
> paragraph below)
>
> I recall one of them was already in jewel or jewel-next when I picked it
> up, some time in December or so, but the other wasn't yet.
>
> Anyway, if you do have the two deps, maybe I'll have to rebase.  Just
> let me know the target and I'll try to take care of it.  I was targeting
> the jewel branch, but I see I failed to make that explicit in my email.
> Sorry about that.
>
>> On 3/7/17 9:33 AM, Alexandre Oliva wrote:
>>> Having applied David Zafman's patch for 13937 and Kefu Chai's for 17857,
>>> I still hit the problem described in issue 18162.  This mostly fixes it.
>>> There are still remaining known problems:

