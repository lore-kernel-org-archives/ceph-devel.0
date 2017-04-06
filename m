From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Why modify.organizationmap failed
Date: Thu, 6 Apr 2017 12:26:38 +0200
Message-ID: <609c2ba7-e316-d712-4ef0-6789c80ec553@corp.ovh.com>
References: <CAN=xyVVMm5F218Ear1212MfkkghTqT3UPqhiL--Jz+mbsEQMoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 6.mo302.mail-out.ovh.net ([137.74.110.79]:36233 "EHLO
        6.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbdDFK0m (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 06:26:42 -0400
In-Reply-To: <CAN=xyVVMm5F218Ear1212MfkkghTqT3UPqhiL--Jz+mbsEQMoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qi Shi <m13913886148@gmail.com>, ceph-devel@vger.kernel.org

On 04/06/2017 11:56 AM, qi Shi wrote:
> https://github.com/ceph/ceph/pull/14361
>
> I modified organizationmap file, but it's build failed.
>
> Why organizationmap will be build ? it looks like a document.

It's a temporary issue, you can safely ignore it. I suggested a long time 
ago to have Jenkins ignore anything that looks like just a doc change and 
AFAIK nobody did anything in that direction.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
