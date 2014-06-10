From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: incomplete PG
Date: Tue, 10 Jun 2014 08:58:30 +0800
Message-ID: <CAMm-wcJgkpmiyxBLEtfUHTTC5QDTKUaNrqqZiUdHfsq=kGr7jA@mail.gmail.com>
References: <20140606132000.GA17468@unsen.q53.spb.ru>
	<alpine.DEB.2.00.1406060856330.31587@cobra.newdream.net>
	<20140606191851.GB17468@unsen.q53.spb.ru>
	<20140609131011.GC17468@unsen.q53.spb.ru>
	<CAMm-wcLe0A_VLKoL=r8MhSO_2HG0Mp7zzmVnoWze-RcqfL2xsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:48216 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226AbaFJA6b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jun 2014 20:58:31 -0400
Received: by mail-vc0-f176.google.com with SMTP id im17so7046499vcb.35
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jun 2014 17:58:30 -0700 (PDT)
In-Reply-To: <CAMm-wcLe0A_VLKoL=r8MhSO_2HG0Mp7zzmVnoWze-RcqfL2xsg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexey Kurnosov <alexey@kurnosov.spb.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sorry, the last sentence should be "You can NOT remove PG, except you
remove the whole Pool."

On 10 June 2014 08:57, Dong Yuan <yuandong1222@gmail.com> wrote:
> InComplete PG means this PG can't get enough metadata (PG logs) to
> enter Active state. This may be because some unrepairable data damage.
>
> You can remove PG, except you remove the whole Pool.
>
> On 9 June 2014 21:10, Alexey Kurnosov <alexey@kurnosov.spb.ru> wrote:
>>
>> Guys, what should i do to erase an incomplete PG?
>> Use special utils,  hexedit, any methods?
>>
>>
>> On Fri, Jun 06, 2014 at 11:18:51PM +0400, Alexey Kurnosov wrote:
>>> On Fri, Jun 06, 2014 at 08:57:46AM -0700, Sage Weil wrote:
>>> > On Fri, 6 Jun 2014, Alexey Kurnosov wrote:
>>> > > Hi all.
>>> > >
>>> > > Sorry for a rude offtop, but looks like nobody can help me at ceph-users.
>>> > > Here is the link to my email:
>>> > > http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-June/040383.html
>>> > > Here some additional data:
>>> > > http://pastebin.com/Nc4y3S1U
>>> > >
>>> > > During read requests i can see in logs:
>>> > > 2014-06-06 13:28:08.586262 7f335f29f700 10 osd.7 21942 dequeue_op 0x356cb40 prio 127 cost 0 latency 0.000352 osd_op(client.11324.1:436 rb.0.1465.2ae8944a.000000000bb1 [read 0~131072] 4.b940a077 e21942) v4 pg pg[4.77( empty local-les=0 n=0 ec=144 les/c 19162/16786 21941/21941/21941) [7,2] r=0 lpr=21941 pi=8764-21940/115 mlcod 0'0 incomplete]
>>> > >
>>> > >
>>> > > Any help would be appreciated.
>>> >
>>> > This looks like a hangup somewhere in teh osd/osd communication that is
>>> > preventing the peering/probing from happening.  Since you're running
>>> > emperor and we stopped testing and backporting fixes there a while back
>>> > I'm not sure offhand what bug fix is missing.  My suggestion is to upgrade
>>> > to 0.80.1 firefly as a first step.
>>> Upgrade has been performed. I do not see any changes.
>>>
>>>
>>> >
>>> > FWIW simply restartin the OSDs involved in those PGs will probably also
>>> > get things rolling, but this bug will still be present.
>>> I restarted it many times. Looks like PG copies all are incomplete.
>>>
>>>
>>> >
>>> > sage
>>> >
>>> >
>>> >  >
>>> > >
>>> > > (Somebody hit similar issue here: http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-February/007948.html)
>>> > >
>>> > > --
>>> > > Alexey Kurnosov
>>> > >
>>> > >
>>> > >
>>> > >
>>> > >
>>> > >
>>>
>>> --
>>> Alexey Kurnosov
>>>
>>
>>
>
>
>
> --
> Dong Yuan
> Email:yuandong1222@gmail.com



-- 
Dong Yuan
Email:yuandong1222@gmail.com
