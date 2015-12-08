From: Ning Yao <zay11022@gmail.com>
Subject: Re: problem about pgmeta object?
Date: Tue, 8 Dec 2015 19:08:15 +0800
Message-ID: <CALZt5jzpGn1koOwK2PZ2w6xj-UPibc2B60HU-f1ZayFNDSy3EQ@mail.gmail.com>
References: <CALZt5jx2bQKK6yE=bTu96CD=OE7uVGTagfqirHsXh5bNbS2t=w@mail.gmail.com>
	<alpine.DEB.2.00.1511180511420.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38625 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569AbbLHLIR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 06:08:17 -0500
Received: by wmec201 with SMTP id c201so25002135wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Dec 2015 03:08:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511180511420.7964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Umm, it seems that MemStore requires in memory meta object to keep the
attributes. So it is not a direct way to remove the pg_meta object
backend storage. Any suggestions?
I think we can just skip the pg_meta operation in FileStore api based
on the value of hoid.pgmeta(), not a generic strategy for all
backends.
Regards
Ning Yao


2015-11-18 21:12 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 18 Nov 2015, Ning Yao wrote:
>> Hi, Sage
>>
>> pgmeta object is a meta-object (like __head_00000000__2) without
>> significant information. It is created when in PG::_init() when
>> handling pg_create and split_coll and always exits there during pg's
>> life cycle until pg is removed in RemoveWQ. The real content related
>> to pgmeta-data is stored in omap. we may just treat pgmeta-object as a
>> logical object and not present it physically so that we can avoid
>> recursive searching object path by if(hoid.pgmeta())?
>> such as:
>> int FileStore::_omap_setkeys(coll_t cid, const ghobject_t &hoid,
>>     const map<string, bufferlist> &aset,
>>     const SequencerPosition &spos) {
>>   dout(15) << __func__ << " " << cid << "/" << hoid << dendl;
>>   Index index;
>>   int r;
>>   if(hoid.pgmeta())
>>     goto out;
>> ***
>> ***
>> ***
>> out:
>>   r = object_map->set_keys(hoid, aset, &spos);
>>   dout(20) << __func__ << " " << cid << "/" << hoid << " = " << r << dendl;
>>   return r;
>> }
>
> This seems like a reasonable hack. We never store any byte data in it.
> And if/when that changes, we can change this at the same time.
>
> sage
