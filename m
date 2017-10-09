From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: Multisite 3+ zones
Date: Mon, 9 Oct 2017 08:45:11 -0700
Message-ID: <CAKRxputmk4OUq4UPDi357HEUvr6U2UhiBEuQpyPmrKdiiB42wA@mail.gmail.com>
References: <CAKRxpusXtf+Xj9+nsbN_GP7CmeqF09vMZnMnM7wA-JvvuJypYw@mail.gmail.com>
 <CABo9giS0K_2U-TdP-H-tVcA494jynf-NmzHeoXxO5a2DF4payA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:55462 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754357AbdJIPpN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Oct 2017 11:45:13 -0400
Received: by mail-it0-f44.google.com with SMTP id l196so1297215itl.4
        for <ceph-devel@vger.kernel.org>; Mon, 09 Oct 2017 08:45:13 -0700 (PDT)
In-Reply-To: <CABo9giS0K_2U-TdP-H-tVcA494jynf-NmzHeoXxO5a2DF4payA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Thanks for the clarifications. one comment below.

>> If this is supported, what happens if zone1 data is modified, while at
>> the same time a zone2 modifies the same data but the data was not yet
>> copied from the zone1 to zone2. How is this conflict handled? Does
>> last write win?
>>
>Yes the last write will win (in the end)

(feature request)I know this is a very popular solution, but I wanted
to shine in on this. I think it is a very bad solution. We have run
into catastrophic loss of data due to this algorithm and has happened
many times, just because someone eventually close out files not
realizing there were other instances. Usually the lost data is very
recently modified. The analogy for developers is if there was source
code conflict, the last write wins. It would be more helpful if both
versions were preserved for manual merge.

On Tue, Oct 3, 2017 at 5:52 AM, Orit Wasserman <owasserm@redhat.com> wrote:
> On Mon, Oct 2, 2017 at 11:41 PM, Two Spirit <twospirit6905@gmail.com> wrote:
>> The documenation I saw talked about multi-zones, but seems to stop in
>> the details at 2 zones whereas,  before, Jewel's Master zone(RW) wrote
>> to Slave Zone(RO), and now after Jewel, writing to the Slave is doable
>> (implying RW) to either zone. and didn't address the case of 3 or more
>> zones. I thought the Master/Slave architecture implied it was limited
>> to 2 zones.
>>
> In the new multisite (from Jewel) the default is RW but it is possible to set a
> zone to be read only (slave).
>
>> Is RW to any zone supported in 3+ zone configurations? The whole
>> master/slave idea doesn't seem to make sense when talking about 3+
>> zones. I'm taking a guess that this must be fully meshed, and RW to
>> any modifications in one zone replicates to *all* other zones
>> (independent on the number of replicas specified in any cluster)
>>
>
> Yes, we support 3+ zones configuration. All the zones in the zonegroup
> replicated to each other , so yes it is a mesh. the Read Only zones only
> read from the other zones.
>
>> If this is supported, what happens if zone1 data is modified, while at
>> the same time a zone2 modifies the same data but the data was not yet
>> copied from the zone1 to zone2. How is this conflict handled? Does
>> last write win?
>>
> Yes the last write will win (in the end)
>
>> Is the RADOS "primary copy", "Chain", and "Splay" replication strategy
>> also used in multisite traffic?
> don't think those are related to multisite traffic which is based on REST API
>
> Regards,
> Orit
