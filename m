From: Amit Vijairania <amit.vijairania@gmail.com>
Subject: Re: Crushmap ruleset for rack aware PG placement
Date: Mon, 15 Sep 2014 11:21:54 -0700
Message-ID: <CADgBPFA_WogRign88XbRH2BAdBe44JchsnF=r8dRp=YnpR_Brg@mail.gmail.com>
References: <CADgBPFCVUVQZtHNkSsuMhskL2X-FTBTYy6zcav3CRpNCBGHJgg@mail.gmail.com>
	<alpine.DEB.2.00.1409150826060.513@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51744 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239AbaIOSVy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 14:21:54 -0400
Received: by mail-ie0-f170.google.com with SMTP id tp5so5163974ieb.29
        for <ceph-devel@vger.kernel.org>; Mon, 15 Sep 2014 11:21:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409150826060.513@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "William Bloom (wibloom)" <wibloom@cisco.com>, "Cecil Lee -X (cecille - TEKSYSTEMS INC at Cisco)" <cecille@cisco.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Sage!  We will test this and share our observations..

Regards,
Amit

Amit Vijairania  |  415.610.9908
--*--


On Mon, Sep 15, 2014 at 8:28 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi Amit,
>
> On Mon, 15 Sep 2014, Amit Vijairania wrote:
>> Hello!
>>
>> In a two (2) rack Ceph cluster, with 15 hosts per rack (10 OSD per
>> host / 150 OSDs per rack), is it possible to create a ruleset for a
>> pool such that the Primary and Secondary PGs/replicas are placed in
>> one rack and Tertiary PG/replica is placed in the other rack?
>>
>> root standard {
>>   id -1 # do not change unnecessarily
>>   # weight 734.400
>>   alg straw
>>   hash 0 # rjenkins1
>>   item rack1 weight 367.200
>>   item rack2 weight 367.200
>> }
>>
>> Given there are only two (2) buckets, but three (3) replica, is it
>> even possible?
>
> Yes:
>
> rule myrule {
>         ruleset 1
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step choose firstn 2 type rack
>         step chooseleaf firstn 2 type host
>         step emit
> }
>
> That will give you 4 osds, spread across 2 hosts in each rack.  The pool
> size (replication factor) is 3, so RADOS will just use the first three (2
> hosts in first rack, 1 host in second rack).
>
> sage
>
>
>
>
>> I think following Giant blueprint is trying to address scenario I
>> described above.. Is the following blueprint targeted for Giant
>> release?
>> http://wiki.ceph.com/Planning/Blueprints/Giant/crush_extension_for_more_flexible_object_placement
>>
>>
>> Regards,
>> Amit Vijairania  |  Cisco Systems, Inc.
>> --*--
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
