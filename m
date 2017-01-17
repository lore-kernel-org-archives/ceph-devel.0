From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Request for advice on ceph compile time.
Date: Tue, 17 Jan 2017 08:15:19 +0100
Message-ID: <fd163449-6d11-e587-4ebc-08e5db2cb928@corp.ovh.com>
References: <CA+hcxJR65Ux2J+nUyFAXz08aZkrWVBKrSKeH-kH-Rqd-FLXNqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 7.mo302.mail-out.ovh.net ([137.74.110.80]:58744 "EHLO
        7.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdAQHPb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2017 02:15:31 -0500
In-Reply-To: <CA+hcxJR65Ux2J+nUyFAXz08aZkrWVBKrSKeH-kH-Rqd-FLXNqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 01/16/2017 08:19 PM, Victor Denisov wrote:
> Cephers,
>
> Could you please give me some advice on how to have a faster turn
> around for change - compile process. Currently I usually do a change
> and then compile which often takes quite a while and gets in the way
> of being in the flow. I'm trying to mitigate it by changing as big
> chunks as possible before compiling, but it's not a very pleasant
> experience. So, I thought may be you could share your experience.

Get a better CPU, preferably desktop one, ample amount of RAM (3GB per core 
is fine) and a reliable, at least MLC class SSD drive (TLC will get killed 
really fast). Building (full build, including test binaries) on Core i7-6700 
with 32GB of RAM takes around 15 minutes, slightly more when done in VM and 
noticeably more when done on spinning rust.
You can also try to offset the I/O speed with more RAM and more dangerous 
Linux file caching settings.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
