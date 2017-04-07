From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH 1/1] EC backfill retries
Date: Fri, 07 Apr 2017 12:16:26 -0300
Message-ID: <orwpaw2qph.fsf@lxoliva.fsfla.org>
References: <ormvcx2dr8.fsf@lxoliva.fsfla.org>
        <06c85dc1-3318-fc05-ec1a-7f68d3aecc37@redhat.com>
        <ork27qguwv.fsf@lxoliva.fsfla.org>
        <52362dc8-faca-82f4-b1ac-dc7df6150afe@redhat.com>
        <orwpbpf766.fsf@lxoliva.fsfla.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:35997 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933873AbdDGPQh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Apr 2017 11:16:37 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id v37FGXRT005249
        for <ceph-devel@vger.kernel.org>; Fri, 7 Apr 2017 15:16:34 GMT
In-Reply-To: <orwpbpf766.fsf@lxoliva.fsfla.org> (Alexandre Oliva's message of
        "Thu, 16 Mar 2017 14:44:17 -0300")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mar 16, 2017, Alexandre Oliva <oliva@gnu.org> wrote:

> On Mar 15, 2017, David Zafman <dzafman@redhat.com> wrote:
>> If it applies cleanly

> It did when I created it.

And the 3 patches applied cleanly as I prepared to build my patched
10.2.6, so I can't imagine why they would have conflicted for you.  Are
you sure you were trying to apply them to the jewel branch?

> According to my logs, the commits I cherry-picked, that I referenced by
> issue, were:

> 82f5cc63404ce9f680d714fc85148946f2b2c376 (your patch for 13937)
> (cherry picked from commit c51d70e1e837c972e42ddd5fa66f7ca4477b95cc)

> b3224a18f6acc7ed54c2162b140a33b6146a16be (Kefu Chai's patch for 17857)

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
