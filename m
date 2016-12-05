From: David Zafman <dzafman@redhat.com>
Subject: Re: raw rados listing with seek to marker
Date: Mon, 5 Dec 2016 12:40:06 -0800
Message-ID: <c303bb90-16bf-080b-8415-c732f1872189@redhat.com>
References: <CADRKj5Tv-NN8gCJgR-X2kCVtYzNJnS9r78FtaGZm6GrX3s2EuQ@mail.gmail.com>
 <alpine.DEB.2.11.1612051440090.2711@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbcLEUkH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Dec 2016 15:40:07 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38C3F3F724
        for <ceph-devel@vger.kernel.org>; Mon,  5 Dec 2016 20:40:07 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1612051440090.2711@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "Just, Samuel" <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 12/5/16 6:40 AM, Sage Weil wrote:
> On Sat, 3 Dec 2016, Yehuda Sadeh-Weinraub wrote:
>
>>   - what to do with the old object listing api? the code internally
>> defaults to using it, so if implementing seek only for nobjects it
>> won't work by default. I'm not sure we want to implement it for the
>> legacy listing infrastructure.
> Hmm... I think we should implement it for the non-"n" variant too (I
> don't think it's necessarily legacy; users may be enumerating
> within a namespace).
>
>
We could immediately stop using the non-"n" variant within the "n" api 
because backwards compatibility is not required.  Now that we are at 
Jewel or beyond we know all OSDs support the PGNLS protocol. However, as 
Sage points out if you are enumerating within a namespace there is the 
overhead of the responses which would contain the same namespace for 
every object.  Finally, we could still deprecate the non-"n" librados 
api at any time independently of the protocol.

If we retain the PGLS and PGNLS wire protocols for efficiency sake, then 
a raw seek capability would have to function as the other operations do 
now and route to the right api/protocol depending on whether all_nspaces 
is in effect or not.

David
