From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: mon config update
Date: Mon, 8 Jan 2018 14:26:49 +0100
Message-ID: <3c4d5398-e50a-e677-acb7-1f4d325ee684@corp.ovh.com>
References: <alpine.DEB.2.11.1801051716570.24931@piezo.novalocal>
 <2b36d420-2646-4955-24ae-ed4a3688c094@corp.ovh.com>
 <alpine.DEB.2.11.1801081310360.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo302.mail-out.ovh.net ([137.74.110.74]:55629 "EHLO
        1.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756835AbeAHN0x (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 08:26:53 -0500
In-Reply-To: <alpine.DEB.2.11.1801081310360.24931@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 18-01-08 02:12 PM, Sage Weil wrote:
>>> A sample from my vstart cluster (vstart is only putting some of its
>>> options in the mon so far, so this shows both conf and mon as sources):
>>>
>>> gnit:build (wip-config) 11:28 AM $ bin/ceph config dump
>>> WHO    MASK OPTION                                VALUE
>>> global      crush_chooseleaf_type                 0
>>> global      mon_pg_warn_min_per_osd               3
>>> global      osd_pool_default_min_size             1
>>> global      osd_pool_default_size                 1
>>> mds         mds_debug_auth_pins                   true
>>> mds         mds_debug_frag                        true
>>> mds         mds_debug_subtrees                    true
>>> mon         mon_allow_pool_deletes                true
>>> [..]
>>> gnit:build (wip-config) 11:33 AM $ bin/ceph config get osd.0
>>> WHO    MASK      OPTION                    VALUE
>>> global           crush_chooseleaf_type     0
>>> osd    class:ssd debug_bluestore           0/0
>>> osd    host:gnit debug_filestore           20/20
>>> global host:gnit debug_monc                15/15
>>> osd.0            debug_osd                 33/33
>>> global           mon_pg_warn_min_per_osd   3
>>> osd              osd_copyfrom_max_chunk    524288
>>> osd              osd_debug_misdirected_ops true
>>> osd              osd_debug_op_order        true
>>> global           osd_pool_default_min_size 1
>>> global           osd_pool_default_size     1
>>> osd              osd_scrub_load_threshold  2000
>>>
>>> (osd.0 is an ssd)
>>>
>>> Thoughts?
>>
>> I assume that this will support json output.
>> Wouldn't mind having a "changeable in runtime" column in these outputs. I know
>> it's semi-reliable, but it's still better than experimenting or searching for
>> it in code (which may be difficult for non-devs).
> 
> What about in the JSON output only?  Concerned about spending horizontal
> space on a binary flag...

A single asterisk character before/after option name - without additional 
column - would do good enough. I'm quite often asked whether some particular 
option can be changed at runtime or not, so that would make everyone's life 
easier. Sure, this doesn't cover the cases of runtime-changeable options 
that are not explicitly observed (confusing people in the process), but 
that's another story.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
