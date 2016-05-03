From: Shinobu Kinjo <shinobu.kj@gmail.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 17:10:58 +0900
Message-ID: <CAFdRU70rd9osK=4Yj_S-vtFPOX6m6qsa=u7nH2p1PWQaDvt_5Q@mail.gmail.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
	<1707978395.1022.1462224339784@ox.pcextreme.nl>
	<CAFdRU70KCjhemzL2f2YLKotpVxyarag2WWkTQWny42v6q85dTA@mail.gmail.com>
	<alpine.DEB.2.11.1605021745510.26967@cpach.fuggernut.com>
	<06681238D8946F44A60AA400760A1CBF023447C8@SHSMSX103.ccr.corp.intel.com>
	<BL2PR02MB21152C53B868E3CF9763CD07F47A0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<693203691.24062915.1462255202807.JavaMail.zimbra@redhat.com>
	<BL2PR02MB21154FFDA5DC5CA499D4F7CEF47A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Reply-To: skinjo@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35674 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbcECIK7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 04:10:59 -0400
Received: by mail-ig0-f169.google.com with SMTP id bi2so108500393igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2016 01:10:58 -0700 (PDT)
In-Reply-To: <BL2PR02MB21154FFDA5DC5CA499D4F7CEF47A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Yuan Zhou <yuan.zhou@intel.com>, Sage Weil <sage@newdream.net>, Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 3, 2016 at 3:29 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> You need to recreate OSDs (mkfs) in order to move to rocksdb, it is not a seamless transition as per I know..

Yeah, you're right.

>> >> We're thinking about switching the default backend on the mon from
>> >> leveldb to rocksdb.

But we're talking about mon...

>
> -----Original Message-----
> From: Shinobu Kinjo [mailto:skinjo@redhat.com]
> Sent: Monday, May 02, 2016 11:00 PM
> To: Somnath Roy
> Cc: Yuan Zhou; Sage Weil; Wido den Hollander; Ceph Development
> Subject: Re: mon switch from leveldb to rocksdb
>
>> I think filestore is already supporting rocksdb as OMAP..
>
> If the RocksDB library is there, yes...
>
> What is really challenge in here to me is, as Sage mentioned:
>
>> if someone wants to convert, they can add/remove/replace mons in their cluster to get there.
>
> Maybe this is a related issue:
>
> https://github.com/facebook/rocksdb/issues/677
>
> What do you think?
>
> Cheers,
> Shinobu.
>
> ----- Original Message -----
> From: "Somnath Roy" <Somnath.Roy@sandisk.com>
> To: "Yuan Zhou" <yuan.zhou@intel.com>, "Sage Weil" <sage@newdream.net>, skinjo@redhat.com
> Cc: "Wido den Hollander" <wido@42on.com>, "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, May 3, 2016 2:28:56 PM
> Subject: RE: mon switch from leveldb to rocksdb
>
> I think filestore is already supporting rocksdb as OMAP..
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Zhou, Yuan
> Sent: Monday, May 02, 2016 10:25 PM
> To: Sage Weil; skinjo@redhat.com
> Cc: Wido den Hollander; Ceph Development
> Subject: RE: mon switch from leveldb to rocksdb
>
> Hi Sage,
>
> how about the filestore_omap_backend? It's set to leveldb by default now. Would it be set to rocksdb also?
>
> thanks, -yuan
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Tuesday, May 3, 2016 5:47 AM
> To: skinjo@redhat.com
> Cc: Wido den Hollander <wido@42on.com>; Ceph Development <ceph-devel@vger.kernel.org>
> Subject: Re: mon switch from leveldb to rocksdb
>
> On Tue, 3 May 2016, Shinobu Kinjo wrote:
>> If possible, it would be much better to make it pluggable so that we
>> select what we want.
>
> Yeah, that is the plan.  The mon_keyvaluedb will select leveldb or rocksdb.  We'd just switch the default over at some point, once we're satisfied with stability.
>
> After thinking about this some more I agree with Wido that the conversion isn't useful enough to bother with.  We can just make new mons use rocksdb, and if someone wants to convert, they can add/remove/replace mons in their cluster to get there.
>
> sage
>
>
>
>>
>> On Tue, May 3, 2016 at 6:25 AM, Wido den Hollander <wido@42on.com> wrote:
>> >
>> >> Op 2 mei 2016 om 20:49 schreef Sage Weil <sweil@redhat.com>:
>> >>
>> >>
>> >> We're thinking about switching the default backend on the mon from
>> >> leveldb to rocksdb.  Rocksdb is better maintained, has a stronger
>> >> feature set, is generally faster, and is linked statically, which
>> >> means we won't be vulnerable to buggy distro packages.
>> >>
>> >> There is one blocker, though.  Some distro leveldbs name the sst
>> >> files with the .ldb suffix.  (Some don't; very annoying.)  There is
>> >> a unit test in rocksdb that tries to verify that ldb is silently
>> >> renamed to sst, and it passes, but the test is incomplete: the test
>> >> failes to verify that ldb/sst files can actually be read, and it turns out only the 'check'
>> >> path (not the normal open and read it path) handles ldb properly.
>> >>
>> >> Anyway, once that works, rocksdb will magically upgrade from
>> >> leveldb to rocksdb.  Note that once that happens you can't switch
>> >> from rocksdb back to leveldb without recreating the mon.
>> >>
>> >> Alternatively, we could not worry about upgrading existing leveldb
>> >> instances and just make newly created mons default to rocksdb.
>> >>
>> >> 1) Thoughts on moving to rocksdb in general?
>> >>
>> >> 2) Importance of leveldb->rocksdb conversion?
>> >>
>> >
>> > I would not touch this auto conversion at first. I know there is things to gain, but is it enough to gain that it might be worth while potentially corrupting monitors?
>> >
>> > Is it that LevelDB doesn't handle large cluster load for example? Imho the majority of Ceph clusters is still far below 500 OSDs.
>> >
>> > Personally I always try to stay away from touching the MONs datastore. Always feels a bit scary.
>> >
>> > Wido
>> >
>> >> 3) Anyone want to fix the ldb handling in rocksdb?
>> >>
>> >> Thanks!
>> >> sage
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe
>> >> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > ceph-devel" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Email:
>> shinobu@linux.com
>> GitHub:
>> shinobu-x
>> Blog:
>> Life with Distributed Computational System based on OpenSource
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).



-- 
Email:
shinobu@linux.com
GitHub:
shinobu-x
Blog:
Life with Distributed Computational System based on OpenSource
