From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH 1/1] EC backfill retries
Date: Wed, 15 Mar 2017 17:13:52 -0300
Message-ID: <ork27qguwv.fsf@lxoliva.fsfla.org>
References: <ormvcx2dr8.fsf@lxoliva.fsfla.org>
        <06c85dc1-3318-fc05-ec1a-7f68d3aecc37@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:33005 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbdCOUOn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Mar 2017 16:14:43 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id v2FKEYqa012439
        for <ceph-devel@vger.kernel.org>; Wed, 15 Mar 2017 20:14:35 GMT
In-Reply-To: <06c85dc1-3318-fc05-ec1a-7f68d3aecc37@redhat.com> (David Zafman's
        message of "Fri, 10 Mar 2017 12:34:21 -0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mar 10, 2017, David Zafman <dzafman@redhat.com> wrote:

>     I can't apply your patch because sha1 e3eb1fd isn't in the ceph
> repo

That's no surprise; that's the result of my cherry-picking the two
patches I listed as dependencies of mine.

> and it won't apply cleanly.

Do you have those two patches in the tree?  (see the first quoted
paragraph below)

I recall one of them was already in jewel or jewel-next when I picked it
up, some time in December or so, but the other wasn't yet.

Anyway, if you do have the two deps, maybe I'll have to rebase.  Just
let me know the target and I'll try to take care of it.  I was targeting
the jewel branch, but I see I failed to make that explicit in my email.
Sorry about that.

> On 3/7/17 9:33 AM, Alexandre Oliva wrote:
>> Having applied David Zafman's patch for 13937 and Kefu Chai's for 17857,
>> I still hit the problem described in issue 18162.  This mostly fixes it.
>> There are still remaining known problems:

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
