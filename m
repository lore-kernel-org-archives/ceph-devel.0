From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph ISA-L git submodule
Date: Tue, 13 Jun 2017 17:51:31 +0200
Message-ID: <9e3edca1-efbd-a1dc-0809-da781d045f26@dachary.org>
References: <B209D98D8385BE41BC4DE002C072AEBE859F7544@fmsmsx118.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54001 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdFMPvf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jun 2017 11:51:35 -0400
In-Reply-To: <B209D98D8385BE41BC4DE002C072AEBE859F7544@fmsmsx118.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Mahalingam, Ganesh" <ganesh.mahalingam@intel.com>
Cc: "Gohad, Tushar" <tushar.gohad@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

[cc'ing ceph-devel]

Hi !

On 06/13/2017 05:25 PM, Mahalingam, Ganesh wrote:
> Hi Loic,
> Apologies for the duplicate communication. Just thought leaving an email would be better compared to trusting the persistence of IRC. :)
> 
> Was wondering if you could shed some light on how the community handles submodule updates? Does the maintainer get the latest from the upstream project and then a PR will just change the SHA reference or do we do a PR to the submodule as well?

Yes, it's basically how it is done.

> We wanted to update the ISA-L sources from v2.16 to v2.18 and hence the questions. 

The automated make check will use the new submodule to verify it is able to decode/encode shards.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
