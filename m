From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their
 performance impact
Date: Mon, 14 Jan 2013 09:34:21 -0800
Message-ID: <CAPYLRzivOA41NUa4-M1f_NZ71e2GetHnxB9pZ_CQtj3hxo33FA@mail.gmail.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
	<50F40C4B.6000301@inktank.com>
	<CAPUexz9X5rZGG6epWPj1qEUcM_ZNyEbDWizUVCGkqY=4btvQqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:61822 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533Ab3ANReW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 12:34:22 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so2685771qca.31
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 09:34:22 -0800 (PST)
In-Reply-To: <CAPUexz9X5rZGG6epWPj1qEUcM_ZNyEbDWizUVCGkqY=4btvQqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 14, 2013 at 6:09 AM, Florian Haas <florian@hastexo.com> wrote:
> Hi Mark,
>
> thanks for the comments.
>
> On Mon, Jan 14, 2013 at 2:46 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
>> Hi Florian,
>>
>> Couple of comments:
>>
>> "OSDs use a write-ahead mode for local operations: a write hits the journal
>> first, and from there is then being copied into the backing filestore."
>>
>> It's probably important to mention that this is true by default only for
>> non-btrfs file systems.  See:
>>
>> http://ceph.com/wiki/OSD_journal
>
> I am well aware of that, but I've yet to find a customer (or user)
> that's actually willing to entrust a production cluster with several
> hundred terabytes of data to btrfs. :) Besides, the whole post is
> about whether or not to use dedicated SSD block devices for OSD
> journals, and if you're tossing everything into btrfs you've already
> made the decision to use in-filestore journals.

That is absolutely not the case. btrfs works just fine with an
external journal on SSD or whatever else; what made you think
otherwise?
-Greg
