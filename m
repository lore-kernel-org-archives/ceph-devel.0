From: Loic Dachary <loic@dachary.org>
Subject: Re: releasing jewel v10.2.3 ?
Date: Sun, 21 Aug 2016 22:27:52 +0200
Message-ID: <57BA0EC8.3050008@dachary.org>
References: <57B698D0.1050409@dachary.org>
 <1074794425.66535.1471591086293.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53429 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbcHUU16 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Aug 2016 16:27:58 -0400
In-Reply-To: <1074794425.66535.1471591086293.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "wido@42on.com" <wido@42on.com>, Kefu Chai <kchai@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


Hi Wido,

Almost all pull requests requested for 10.2.3 are merged except this one. There is a backport at https://github.com/ceph/ceph/pull/10804 . It will need testing and it may take some time. 

@Kefu Is there a job we can run to verify it does the right thing in jewel ?

Cheers

On 19/08/2016 09:18, wido@42on.com wrote:
> 
> 
>> Op 19 aug. 2016 om 07:28 heeft Loic Dachary <loic@dachary.org> het volgende geschreven:
>>
>> Hi Sage,
>>
>> Here are the issues that would be in jewel v10.2.3 if we decided to release it now: http://tracker.ceph.com/versions/518
>> And here is the backport queue : http://tracker.ceph.com/projects/ceph/issues?query_id=96
>>
>> Do you think it is time to cut the release and ask QE to start testing ?
>>
> 
> I think that this one is a good candidate to go in as well. Since 10.2.4 can take a while.
> 
> http://tracker.ceph.com/issues/17023 / https://github.com/ceph/ceph/pull/10725
> 
> Nasty one which might catch users and leave them wondering why the OSDs are not coming up.
> 
> Wido
> 
>> Cheers
>>
>> -- 
>> LoÃ¯c Dachary, Artisan Logiciel Libre
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Loïc Dachary, Artisan Logiciel Libre
