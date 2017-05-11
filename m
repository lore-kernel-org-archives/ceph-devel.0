From: Loic Dachary <loic@dachary.org>
Subject: Re: [GSoC] Spandan : Smarter Reweight by Utilisation
Date: Thu, 11 May 2017 09:41:17 +0200
Message-ID: <a140c940-bced-f2a7-a64e-9e1b740b9920@dachary.org>
References: <CAAXqJ+pqL99uU3RszVRj34tbYx8GmRF4ZF_D1Eh3-u-XAX1_-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38157 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754380AbdEKHlV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 03:41:21 -0400
In-Reply-To: <CAAXqJ+pqL99uU3RszVRj34tbYx8GmRF4ZF_D1Eh3-u-XAX1_-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

[cc'ing ceph-devel for the record]

Hi Spandan,

On 05/11/2017 07:22 AM, Spandan Kumar Sahu wrote:
> Hello Loic,
> 
> I am Spandan Kumar Sahu, a student from India, selected for the
> Smarter Reweight by Utilisation project under the GSoC programme.
> 
> I would like to know what parameters you used for analysing the
> performance of the reweight algorithm? From the thread on "revisiting
> uneven distribution" I saw you were using the distribution as the only
> criteria to analyze the performance. 

Yes.

> May be we could use some more
> parameters like, "net data flow over the network" or "the number of
> writes to achieve the desired weight distribution" etc.

These additional criterions would be an interesting future direction.

> 
> A link to your Ceph repo would be of great help.

https://github.com/dachary/ceph/

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
