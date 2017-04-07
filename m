From: David Zafman <dzafman@redhat.com>
Subject: Re: [PATCH 1/1] EC backfill retries
Date: Fri, 7 Apr 2017 10:15:36 -0700
Message-ID: <5b00ea2e-fd73-fa15-8e9e-8e2db59541fc@redhat.com>
References: <ormvcx2dr8.fsf@lxoliva.fsfla.org>
 <06c85dc1-3318-fc05-ec1a-7f68d3aecc37@redhat.com>
 <ork27qguwv.fsf@lxoliva.fsfla.org>
 <52362dc8-faca-82f4-b1ac-dc7df6150afe@redhat.com>
 <orwpbpf766.fsf@lxoliva.fsfla.org> <orwpaw2qph.fsf@lxoliva.fsfla.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934469AbdDGRPx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 7 Apr 2017 13:15:53 -0400
In-Reply-To: <orwpaw2qph.fsf@lxoliva.fsfla.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org


See my pull request consisting of my assembly of your patch:


https://github.com/ceph/ceph/pull/14054


David


On 4/7/17 8:16 AM, Alexandre Oliva wrote:
> On Mar 16, 2017, Alexandre Oliva <oliva@gnu.org> wrote:
>
>> On Mar 15, 2017, David Zafman <dzafman@redhat.com> wrote:
>>> If it applies cleanly
>> It did when I created it.
> And the 3 patches applied cleanly as I prepared to build my patched
> 10.2.6, so I can't imagine why they would have conflicted for you.  Are
> you sure you were trying to apply them to the jewel branch?
>
>> According to my logs, the commits I cherry-picked, that I referenced by
>> issue, were:
>> 82f5cc63404ce9f680d714fc85148946f2b2c376 (your patch for 13937)
>> (cherry picked from commit c51d70e1e837c972e42ddd5fa66f7ca4477b95cc)
>> b3224a18f6acc7ed54c2162b140a33b6146a16be (Kefu Chai's patch for 17857)

