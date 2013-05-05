From: Gregory Farnum <greg@inktank.com>
Subject: Re: Erasure encoding as a storage backend
Date: Sat, 4 May 2013 21:51:47 -0700
Message-ID: <CAPYLRziAvz-DvPpX5aArQM_D8x27Lt+2ea9rtuOCTNcj-fnOFw@mail.gmail.com>
References: <5185428B.6070109@dachary.org>
	<C93B376E-72EF-4822-9559-ECF6F2962AA7@cs.ucsc.edu>
	<51855512.20207@dachary.org>
	<C38EEFE7-DC29-4325-B268-5BB85B1E4D9A@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:63513 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3EEEvt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 May 2013 00:51:49 -0400
Received: by mail-wi0-f179.google.com with SMTP id l13so1671303wie.0
        for <ceph-devel@vger.kernel.org>; Sat, 04 May 2013 21:51:48 -0700 (PDT)
In-Reply-To: <C38EEFE7-DC29-4325-B268-5BB85B1E4D9A@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, May 4, 2013 at 11:47 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>
> On May 4, 2013, at 11:36 AM, Loic Dachary <loic@dachary.org> wrote:
>
>>
>>
>> On 05/04/2013 08:27 PM, Noah Watkins wrote:
>>>
>>> On May 4, 2013, at 10:16 AM, Loic Dachary <loic@dachary.org> wrote:
>>>
>>>> it would be great to get feedback before the ceph summit to address the most prominent issues.
>>>
>>> One thing that has been in the back of my mind is how this proposal is influenced (if at all) by a future that includes declustered per-file raid in CephFS. I realize that may be a distant future, but it seems as though there could be a lot of overlap for the (non-client driven) rebuild/recovery component of such an architecture.
>>
>> Hi Noah,
>>
>> I'm not sure what declustered per-file raid is, which means it had no influence on this proposal ;-) Would you be so kind as to educate me ?
>
> I'm definitely far from an expert on the topic. But briefly the way I think about it is:
>
> Currently CephFS stripes a file byte stream across a set of objects (e.g. first MB in object 0, 2nd in object 1, etc..), and each of these objects is in turn replicated. Following a failure, PGs re-replicate objects.
>
> In client drive raid the striping algorithm is changed, and clients are calculating and distributing parity. In this case the parity rather than replication provides redundancy. So, one might consider storing objects in a pool with replication size 1. However, the standard PG that does replication wouldn't be able to handle faults correctly (parity rebuild, rather than re-replication), and a smart PG like the ErasureCodedPG would be needed.
>
> So it seems like the problems are related, but I'm not sure exactly how much overlap there is :)

I'm pretty sure we'd just want to use erasure-coded RADOS pools,
rather than trying to do any CephFS magic erasure encoding. Doing it
above the RADOS layers would introduce some very odd behaviors in
terms of losing objects, as you've mentioned, and requires the clients
to do a lot more network traffic for reads and writes.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
