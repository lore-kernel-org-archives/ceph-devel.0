From: Florian Haas <florian@hastexo.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their performance
 impact
Date: Mon, 14 Jan 2013 21:17:27 +0100
Message-ID: <50F467D7.6040706@hastexo.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com> <50F40C4B.6000301@inktank.com> <CAPUexz9X5rZGG6epWPj1qEUcM_ZNyEbDWizUVCGkqY=4btvQqA@mail.gmail.com> <CAPYLRzivOA41NUa4-M1f_NZ71e2GetHnxB9pZ_CQtj3hxo33FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51528 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757535Ab3ANURc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 15:17:32 -0500
Received: by mail-ee0-f46.google.com with SMTP id e49so2143024eek.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 12:17:31 -0800 (PST)
In-Reply-To: <CAPYLRzivOA41NUa4-M1f_NZ71e2GetHnxB9pZ_CQtj3hxo33FA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/14/2013 06:34 PM, Gregory Farnum wrote:
> On Mon, Jan 14, 2013 at 6:09 AM, Florian Haas <florian@hastexo.com> wrote:
>> Hi Mark,
>>
>> thanks for the comments.
>>
>> On Mon, Jan 14, 2013 at 2:46 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
>>> Hi Florian,
>>>
>>> Couple of comments:
>>>
>>> "OSDs use a write-ahead mode for local operations: a write hits the journal
>>> first, and from there is then being copied into the backing filestore."
>>>
>>> It's probably important to mention that this is true by default only for
>>> non-btrfs file systems.  See:
>>>
>>> http://ceph.com/wiki/OSD_journal
>>
>> I am well aware of that, but I've yet to find a customer (or user)
>> that's actually willing to entrust a production cluster with several
>> hundred terabytes of data to btrfs. :) Besides, the whole post is
>> about whether or not to use dedicated SSD block devices for OSD
>> journals, and if you're tossing everything into btrfs you've already
>> made the decision to use in-filestore journals.
> 
> That is absolutely not the case. btrfs works just fine with an
> external journal on SSD or whatever else; what made you think
> otherwise?

A misunderstanding on my part. Also, I was overly broad in my comment.
What I really meant to say was that if I'm using a btrfs filestore, and
a separate dedicated block device for the journal, then the journaling
mode is write-ahead and not parallel.

Which was a wrong assumption on my part, as an external journal combined
with a btrfs filestore seems to support parallel journaling mode just
fine. For some reason I had supposed the journal had to be in the same
btrfs as the filestore for this to work.

Sorry for the confusion.

Cheers,
Florian
