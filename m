From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Nodown/Noout by OSD_ID?
Date: Thu, 21 Jan 2016 09:47:56 +0800
Message-ID: <CAEYCsV+ELKWAGHD4qo5Lw3_=99zp1ubK2E0n=DsiVHhStzWqXA@mail.gmail.com>
References: <CAEYCsVLFUYAeKT_2bxyA1DpC5K5yzS6JHM=eJ=4WuGpjdypTnw@mail.gmail.com>
	<alpine.DEB.2.11.1601200813250.4600@cpach.fuggernut.com>
	<CALe9h7cqj+ck9-tKBgKuSx=4KcPSJnjO3O=eWSfV3yUT3J=QcQ@mail.gmail.com>
	<alpine.DEB.2.11.1601201025140.4600@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33804 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbcAUBr4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 20:47:56 -0500
Received: by mail-yk0-f171.google.com with SMTP id a85so32308966ykb.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jan 2016 17:47:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601201025140.4600@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Yeah,  mark a whole tree is cool.

We can do that in API level but in implementation, seems we still need
to set the flag on OSD level for simplicity. For example, say RackA
and B are belongs to Row A in crush tree, then if we do:
     ceph [osdmap? crush? ] set RowA noout
     ceph [osdmap? crush? ] set RackA noup
     ceph [osdmap? crush? ] unset RackB noout

As a result, OSDs in Rack A should be noup+noout, but OSDs in RackB
should have no flag setted.  The easiest way in my mind might be
traversal the crush subtree and mark the flag on  vector<uint8_t>
osd_state for every OSD, uint8_t is just enough for now....but next
time if we want to have more state will be struggle.


#define CEPH_OSD_NOUP     (1<<4)  /* osd cannot be marked up */
#define CEPH_OSD_NODOWN     (1<<5)  /* osd cannot be marked down */
#define CEPH_OSD_NOIN     (1<<6)  /* osd cannot be marked in */
#define CEPH_OSD_NOOUT     (1<<7)  /* osd cannot be marked out */


The APIs we would like to support are:

1. ceph XXX set/unset {crush_subtree_name} {flag}
2. ceph osd tree will show flag of each OSD (if it has)
3. ceph health should show the number of OSD with flags.
4. ceph health detail show OSDs with flgas.


3) and 4) need to iterate the  vector<uint8_t> osd_state in OSDMap.



Looks good for you?

Xiaoxi


2016-01-20 23:26 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 20 Jan 2016, John Spray wrote:
>> On Wed, Jan 20, 2016 at 1:32 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Wed, 20 Jan 2016, Xiaoxi Chen wrote:
>> >> Hi,
>> >>
>> >>      In many case we need to tag some OSD with NODOWN/NOOUT/NOUP/NOIN
>> >> tag, but we dont want it cluster wise as these tag may stop other OSDs
>> >> doing self-healthing.As a an example when an recovered OSD need to
>> >> catch up with the OSDMap, to prevent flipping we set
>> >> NODOWN/NOOUT/NOUP, but if other OSD failed by disk error, the failure
>> >> will be hidden and we are in the risk of lossing the data.
>> >>
>> >>      Is that reasonable to have these flag work in OSD granularity?
>> >> say ceph osd nodown osd.xxx?
>> >>      Quick look at the code seems NODOWN/NOUP is easier as we could
>> >> have new status bits in OSDMap
>> >>      /* status bits */
>> >> #define CEPH_OSD_EXISTS  (1<<0)
>> >> #define CEPH_OSD_UP      (1<<1)
>> >> #define CEPH_OSD_AUTOOUT (1<<2)  /* osd was automatically marked out */
>> >> #define CEPH_OSD_NEW     (1<<3)  /* osd is new, never marked in */
>> >>
>> >> #define CEPH_OSD_NOUP     (1<<4)  /* osd cannot be marked in */
>> >> #define CEPH_OSD_NODOWN     (1<<5)  /* osd cannot be marked out */
>> >>
>> >>      But for NOIN/NOOUT seems a bit struggle as IN/OUT depends on
>> >> weight? Any suggestion?
>> >
>> > This looks reasonable if we can sort out a good interface and suitable
>> > health warnings.  For example, ceph health and ceph -s should say "N osds
>> > have noin set", and 'ceph health detail' should tell you which ones.
>> >
>> > Maybe something like
>> >
>> >  ceph osd set-osd osd.123 noin
>> >
>> > ?  I don't particularly like that but we can't do 'ceph osd set ...' since
>> > that does global osdmap flags.
>>
>> I think we should make this operate on arbitrary named CRUSH nodes
>> rather than just OSDs, so that someone can mark a whole host/rack.
>
> Good call!  Yeah, definitely.
>
> I wonder if we should make a tree_flags map that lets you map existing
> state bits over a set of OSDs, or whether it should be an independent and
> new way to store hierarchical state.  Probably the latter is less prone to
> error.
>
> sage
>
