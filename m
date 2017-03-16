From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH 1/1] EC backfill retries
Date: Thu, 16 Mar 2017 14:44:17 -0300
Message-ID: <orwpbpf766.fsf@lxoliva.fsfla.org>
References: <ormvcx2dr8.fsf@lxoliva.fsfla.org>
        <06c85dc1-3318-fc05-ec1a-7f68d3aecc37@redhat.com>
        <ork27qguwv.fsf@lxoliva.fsfla.org>
        <52362dc8-faca-82f4-b1ac-dc7df6150afe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:35959 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbdCPRov (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Mar 2017 13:44:51 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id v2GHihKG014114
        for <ceph-devel@vger.kernel.org>; Thu, 16 Mar 2017 17:44:44 GMT
In-Reply-To: <52362dc8-faca-82f4-b1ac-dc7df6150afe@redhat.com> (David Zafman's
        message of "Wed, 15 Mar 2017 13:38:54 -0700")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mar 15, 2017, David Zafman <dzafman@redhat.com> wrote:

> If it applies cleanly

It did when I created it.  As I said, I won't have time to look into
this in the short term (that's why it took me so long to post it to
begin with, and why I posted it in spite of known problems).

> base your code off of current jewel and specify
> any commits that needs to be cherry-picked so I can pull them in.

According to my logs, the commits I cherry-picked, that I referenced by
issue, were:

82f5cc63404ce9f680d714fc85148946f2b2c376 (your patch for 13937)
(cherry picked from commit c51d70e1e837c972e42ddd5fa66f7ca4477b95cc)

b3224a18f6acc7ed54c2162b140a33b6146a16be (Kefu Chai's patch for 17857)

> Otherwise, create a pull request yourself.

I don't think I can do that.  The proprietary web interface with which
these things are done doesn't work for me.

> Or push it all to the main ceph repo and giving me a branch name.

I don't have permission to push to the main ceph repo AFAIK, but I'd be
glad to do that if I did.  Just probably not before the end of the
month; I'm very pressed for time, and I'll be mostly offline, till then.

I hope this is enough to get you going.

Thanks!

> On 3/15/17 1:13 PM, Alexandre Oliva wrote:
>> On Mar 10, 2017, David Zafman <dzafman@redhat.com> wrote:
>> 
>>> I can't apply your patch because sha1 e3eb1fd isn't in the ceph
>>> repo
>> That's no surprise; that's the result of my cherry-picking the two
>> patches I listed as dependencies of mine.
>> 
>>> and it won't apply cleanly.
>> Do you have those two patches in the tree?  (see the first quoted
>> paragraph below)
>> 
>> I recall one of them was already in jewel or jewel-next when I picked it
>> up, some time in December or so, but the other wasn't yet.
>> 
>> Anyway, if you do have the two deps, maybe I'll have to rebase.  Just
>> let me know the target and I'll try to take care of it.  I was targeting
>> the jewel branch, but I see I failed to make that explicit in my email.
>> Sorry about that.
>> 
>>> On 3/7/17 9:33 AM, Alexandre Oliva wrote:
>>>> Having applied David Zafman's patch for 13937 and Kefu Chai's for 17857,
>>>> I still hit the problem described in issue 18162.  This mostly fixes it.
>>>> There are still remaining known problems:


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
