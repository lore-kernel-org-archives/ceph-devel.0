From: Loic Dachary <loic@dachary.org>
Subject: Re: Lowering the weight to move PGs out
Date: Sun, 4 Jun 2017 14:11:26 +0200
Message-ID: <1dd4146c-98f8-fb0c-bdca-14b5d1bf791f@dachary.org>
References: <51ba058a-8ecf-4b43-1ee8-e5aae04f661a@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51711 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdFDMLb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jun 2017 08:11:31 -0400
In-Reply-To: <51ba058a-8ecf-4b43-1ee8-e5aae04f661a@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

There is a draft implementation of the rebalancing algorithm at http://libcrush.org/main/libcrush/merge_requests/32/diffs and it hopefully shows the benefit for exposing straws.

Cheers

On 05/28/2017 10:17 AM, Loic Dachary wrote:
> Hi Sage,
> 
> The most time consuming part of the optimization algorithm[1] comes from lowering the weight of the most over filled item. We cannot know exactly which value will push the desired number of PGs out. The values influenced by the weight are calculated during mapping[2] and derived from the parameters.
> 
> It would be useful find a way to expose all ln values (i.e. log(hash(PGid,r,item)) without the weight applied. A function behaving like map() but returning all straws from bucket_straw2_choose instead of chosing one based on the weights.
> 
> With the actual values influenced by the weights, we can calculate how much to lower the weight of a given item so that it does not win. Instead of trying small increments, we calculate the exact value.
> 
> What do you think ?
> 
> Cheers
> 
> [1] An algorithm to fix uneven CRUSH distributions in Ceph http://dachary.org/?p=4055
> [2] https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L323
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
