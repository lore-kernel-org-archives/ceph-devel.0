From: Guang Yang <guangyy@gmail.com>
Subject: Re: Long peering - throttle at FileStore::queue_transactions
Date: Tue, 5 Jan 2016 14:33:54 -0800
Message-ID: <CAKtk8hf8nDy75TdCvVAsy-tu9RXuAns+ARuvs1yr51JDUHn4mA@mail.gmail.com>
References: <CAKtk8hdb1dTJ013Qed1D9Wu_wWNvTM9H0hjqg2PGVr9xBnt51g@mail.gmail.com>
	<alpine.DEB.2.11.1601042220510.29548@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:32899 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbcAEWdy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jan 2016 17:33:54 -0500
Received: by mail-yk0-f180.google.com with SMTP id k129so275287414yke.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jan 2016 14:33:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601042220510.29548@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Samuel Just <sjust@redhat.com>

On Mon, Jan 4, 2016 at 7:21 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 4 Jan 2016, Guang Yang wrote:
>> Hi Cephers,
>> Happy New Year! I got question regards to the long PG peering..
>>
>> Over the last several days I have been looking into the *long peering*
>> problem when we start a OSD / OSD host, what I observed was that the
>> two peering working threads were throttled (stuck) when trying to
>> queue new transactions (writing pg log), thus the peering process are
>> dramatically slow down.
>>
>> The first question came to me was, what were the transactions in the
>> queue? The major ones, as I saw, included:
>>
>> - The osd_map and incremental osd_map, this happens if the OSD had
>> been down for a while (in a large cluster), or when the cluster got
>> upgrade, which made the osd_map epoch the down OSD had, was far behind
>> the latest osd_map epoch. During the OSD booting, it would need to
>> persist all those osd_maps and generate lots of filestore transactions
>> (linear with the epoch gap).
>> > As the PG was not involved in most of those epochs, could we only take and persist those osd_maps which matter to the PGs on the OSD?
>
> This part should happen before the OSD sends the MOSDBoot message, before
> anyone knows it exists.  There is a tunable threshold that controls how
> recent the map has to be before the OSD tries to boot.  If you're
> seeing this in the real world, be probably just need to adjust that value
> way down to something small(er).
It would queue the transactions and then sends out the MOSDBoot, thus
there is still a chance that it could have contention with the peering
OPs (especially on large clusters where there are lots of activities
which generates many osdmap epoch). Any chance we can change the
*queue_transactions* to "apply_transactions*, thus we block there
waiting for the persistent of the osdmap. At least we may be able to
do that during OSD booting? The concern is, if the OSD is active, the
apply_transaction would take longer with holding the osd_lock..
I don't find such tuning, could you elaborate? Thanks!
>
> sage
>
