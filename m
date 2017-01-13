From: Loic Dachary <loic@dachary.org>
Subject: Re: Shaman build fails with "reference is not a tree"
Date: Fri, 13 Jan 2017 16:11:55 +0100
Message-ID: <f7625cc6-2fd7-3ace-31ad-c10dcef66e52@dachary.org>
References: <0dc16c42-995c-8623-f2e6-5b69868f8e15@suse.cz>
 <6002374e-e889-ab23-b2f6-c9aad7de6db1@suse.cz>
 <alpine.DEB.2.11.1701131435390.1911@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56049 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbdAMPMC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2017 10:12:02 -0500
In-Reply-To: <alpine.DEB.2.11.1701131435390.1911@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Alfredo Deza <adeza@redhat.com>, "Mick, Dan" <dmick@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 01/13/2017 03:36 PM, Sage Weil wrote:
> On Fri, 13 Jan 2017, Nathan Cutler wrote:
>> The error is reproducible by running the following commands:
>>
>> git clone http://github.com/ceph/ceph
>> git checkout hammer
>> git submodule update --init
>>
>> So it's not a Shaman issue. Looks more like a git repo issue.
> 
> I just tried this and it's working for me...  
> 422e26633267b25c225975b456a9f4fc40091a2e is the precious-v0.94.9 branch in 
> rocksdb.git.

I just pushed it ;-) http://tracker.ceph.com/issues/18521 tracks the problem. I have no clue what caused it in the first place.

> 
> sage


> 
>>
>> On 01/13/2017 12:36 PM, Nathan Cutler wrote:
>>> Is it me, or is Shaman is acting weird? wip-hammer-backports build
>>> suddenly fails because:
>>>
>>> Submodule 'src/rocksdb' (https://github.com/ceph/rocksdb) registered for
>>> path 'src/rocksdb'
>>> Cloning into 'src/rocksdb'...
>>> fatal: reference is not a tree: 422e26633267b25c225975b456a9f4fc40091a2e
>>> Unable to checkout '422e26633267b25c225975b456a9f4fc40091a2e' in
>>> submodule path 'src/rocksdb'
>>>
>>> Some googling suggests the following might help:
>>>
>>> git submodule sync
>>> git submodule update
>>>
>>
>> -- 
>> Nathan Cutler
>> Software Engineer Distributed Storage
>> SUSE LINUX, s.r.o.
>> Tel.: +420 284 084 037
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
