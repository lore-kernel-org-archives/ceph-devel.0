From: Loic Dachary <loic@dachary.org>
Subject: Re: libcrush C API documentation
Date: Wed, 25 Jan 2017 19:45:44 +0100
Message-ID: <8b0a6e90-b090-de9c-bf08-663f0c8ac222@dachary.org>
References: <14e5037f-65c0-51d5-c9bd-0d1302baf144@dachary.org>
 <20170125182557.GC2432@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37064 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdAYSpt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jan 2017 13:45:49 -0500
In-Reply-To: <20170125182557.GC2432@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 01/25/2017 07:25 PM, Adam C. Emerson wrote:
> On 25/01/2017, Loic Dachary wrote:
>> Hi Adam,
>>
>> I would be great if you could review the libcrush C API documentation merge request at http://libcrush.org/main/libcrush/merge_requests/1/diffs. I deliberately documented part of the external functions because some of them ( crush_make_uniform_bucket for instance ) are support functions for a higher level function ( crush_make_bucket for instance ). If you think a function should be documented and it is not, this is not because it's work in progress, it's because I may have misjudged it.
>>
>> The unsupported features are undocumented (for instance the tree and straw algorithms). They should probably be compiled out via a #if before the first standalone release of the library binary package. But it did not seem to be a good idea to dive into that while documenting.
>>
>> You can skip the review of the struct crush_map fields. Nothing was done except changing the existing comments to match Doxygen conventions. There is much to do to improve this. Explaining the tunables is not for the faint of heart.
>>
>> The format chosen for the documentation is Doxygen, as we discussed. Thanks for suggesting it :-)
>>
>> Cheers
> 
> I will be happy to! Do you want me to read for, mostly, technical
> coverage etc. or for style and usage and whatnot, too?

As much as you can :-) You can create the HTML pages localy with

git clone http://libcrush.org/main/libcrush.git
cd libcrush
doxygen doc/Doxygen
firefox doc/output/html/index.html

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
