From: Loic Dachary <loic@dachary.org>
Subject: Re: releasing jewel v10.2.3 ?
Date: Mon, 22 Aug 2016 12:18:07 +0200
Message-ID: <57BAD15F.8010508@dachary.org>
References: <57B698D0.1050409@dachary.org>
 <20160822095936.kj4ymayc52cnmbh3@nora.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42367 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753791AbcHVKSO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 06:18:14 -0400
In-Reply-To: <20160822095936.kj4ymayc52cnmbh3@nora.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>, ceph-devel@vger.kernel.org

Hi Fabian,

Since it has not yet been merged in master yet there is little chance the backport will make it to 10.2.3. It would be nice to document a workaround in http://tracker.ceph.com/issues/16255 in the meantime.

Cheers

On 22/08/2016 11:59, Fabian Grünbichler wrote:
> On Fri, Aug 19, 2016 at 07:27:44AM +0200, Loic Dachary wrote:
>> Hi Sage,
>>
>> Here are the issues that would be in jewel v10.2.3 if we decided to release it now: http://tracker.ceph.com/versions/518
>> And here is the backport queue : http://tracker.ceph.com/projects/ceph/issues?query_id=96
>>
>> Do you think it is time to cut the release and ask QE to start testing ?
>>
>> Cheers
>>
>> -- 
>> Loïc Dachary, Artisan Logiciel Libre
>>
> 
> We'd like to also see http://tracker.ceph.com/issues/16255 included if
> possible, as it currently blocks upgrades to Jewel for existing
> installations.
> 
> Regards,
> Fabian
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
