From: Sandon Van Ness <sandon@inktank.com>
Subject: Re: ARM benchmarks for the erasure code plugin
Date: Fri, 27 Jun 2014 10:23:11 -0700
Message-ID: <53ADA87F.8080808@inktank.com>
References: <53ADA5EC.5030302@dachary.org> <alpine.DEB.2.00.1406271016080.12946@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:38505 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaF0RXN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 13:23:13 -0400
Received: by mail-pd0-f175.google.com with SMTP id v10so4617408pde.6
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jun 2014 10:23:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1406271016080.12946@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Yeah, they should be up and available as we are not testing them 
anymore. They do have issues where they randomly went down before and if 
any of them are down feel free to to hit me up and I can get them fixed up.

says37->saya44 are the newer machines that have the faster CPU's and 
more ram and stuff (newer arch).

On 06/27/2014 10:16 AM, Sage Weil wrote:
> The machine types are tala and saya; you should be able to grab one with
> teuthology-lock.  Hopefully they are up...
>
> sage
>
> On Fri, 27 Jun 2014, Loic Dachary wrote:
>
>> Hi Sandon,
>>
>> Would it be possible to get access to an ARM based machine to run erasure code plugins benchmarks ? The idea is to get a baseline similar to what https://github.com/ceph/ceph/pull/1875 shows and figure out where we stand. At this point any ARM processor will do. Eventually we will want to give NEON[1] enabled processors a try but right now we have nothing take advantage of that ;-)
>>
>> Cheers
>>
>> [1] http://en.wikipedia.org/wiki/NEON_%28instruction_set%29#NEON
>>
>> -- 
>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>

