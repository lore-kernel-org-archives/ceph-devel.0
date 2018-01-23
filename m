From: David Zafman <dzafman@redhat.com>
Subject: Re: [ceph-users] ghost degraded objects
Date: Mon, 22 Jan 2018 17:38:13 -0800
Message-ID: <a21fc9c4-058e-3905-019f-32e2f0c715b9@redhat.com>
References: <CAE63xUN4+fzJFjEOwKU-gXjqk+=8=gugU97V2xA4fx9oBrwvUQ@mail.gmail.com>
 <alpine.DEB.2.11.1801191309430.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbeAWBiO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Jan 2018 20:38:14 -0500
In-Reply-To: <alpine.DEB.2.11.1801191309430.24931@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ugis <ugis22@gmail.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com


Yes, the pending backport for what we have so far is in 
https://github.com/ceph/ceph/pull/20055

With this changes a backfill caused by marking an osd out has the 
results as shown:


     health: HEALTH_WARN
             115/600 objects misplaced (19.167%)

...
   data:
     pools:   1 pools, 1 pgs
     objects: 200 objects, 310 kB
     usage:   173 GB used, 126 GB / 299 GB avail
     pgs:     115/600 objects misplaced (19.167%)
              1 active+remapped+backfilling

David


On 1/19/18 5:14 AM, Sage Weil wrote:
> On Fri, 19 Jan 2018, Ugis wrote:
>> Running Luminous 12.2.2, noticed strange behavior lately.
>> When for example setting "ceph osd out X" closer to the reballancing
>> end "degraded" objects still show up, but in "pgs:" section of ceph -s
>> no degraded pgs are still recovering, just ramapped and no degraded
>> pgs can be found in "ceph pg dump"
>>
>>    health: HEALTH_WARN
>>              355767/30286841 objects misplaced (1.175%)
>>              Degraded data redundancy: 28/30286841 objects degraded
>> (0.000%), 96 pgs unclean
>>
>>    services:
>>      ...
>>      osd: 38 osds: 38 up, 37 in; 96 remapped pgs
>>
>>    data:
>>      pools:   19 pools, 4176 pgs
>>      objects: 9859k objects, 39358 GB
>>      usage:   114 TB used, 120 TB / 234 TB avail
>>      pgs:     28/30286841 objects degraded (0.000%)
>>               355767/30286841 objects misplaced (1.175%)
>>               4080 active+clean
>>               81   active+remapped+backfilling
>>               15   active+remapped+backfill_wait
>>
>>
>> Where those 28 degraded objects come from?
> There aren't actually degraded objects.. in this case it's just
> misreporting that there are.
>
> This is a known issue in luminous.  Shortly after release we noticed the
> problem and David has been working on several changes to the stats
> calculation to improve the reporting, but those changes have not been
> backported (and aren't quite complete, either--getting a truly accurate
> number there is nontrivial in some cases it turns out).
>
>> In such cases usually when backfilling is done degraded objects also
>> disappear, but normally degraded objects should fix before remapped
>> ones by priority.
> Yes.
>
> It's unfortunately a scary warning (there shouldn't be degraded
> objects... and generally speaking aren't) that understandably alarms
> users.  We hope to have this sorted out soon!
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

