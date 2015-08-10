From: =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KHQsNGF0LjQvdC+0LI=?=
	<sakhinov@gmail.com>
Subject: Re: inconsistent pgs
Date: Mon, 10 Aug 2015 17:12:46 +0300
Message-ID: <CAJnOFAp4mM+3AiDfEd_jvXXygcMh1VoXpw0O_z+VW8kWeLfKbg@mail.gmail.com>
References: <CAJnOFAqRjXcuO0bJN8PSLsnnMhBjYMOTJTFY8T+4Z36LaBiMfg@mail.gmail.com>
 <alpine.DEB.2.00.1508090712130.22099@cobra.newdream.net> <CAJnOFApACz47rukJpf50sY2hBvLoPM1+ZuSoTyaWXykxprrmtA@mail.gmail.com>
 <alpine.DEB.2.00.1508100531290.22099@cobra.newdream.net> <CAJnOFAqSX1UQ1iEFdHoNAoBXoxvRKOH60F1mPt-zR+w9veTSJQ@mail.gmail.com>
 <alpine.DEB.2.00.1508100641160.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35122 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbHJONI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 10:13:08 -0400
Received: by wicne3 with SMTP id ne3so23881351wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2015 07:13:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508100641160.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

I can't see any pattern in OSDs distribution by PGs. Looks like there
are all 8 OSDs of all 4 nodes have inconsistent pgs (4 other OSDs are
in other root/hosts ready to become cache tier).
uploaded ceph pg dump
# ceph-post-file ceph-pg-dump
ceph-post-file: 7fcce58a-8cfa-4e5f-aafb-f6b031d1795f

=D0=A1=D0=B0=D1=85=D0=B8=D0=BD=D0=BE=D0=B2 =D0=9A=D0=BE=D0=BD=D1=81=D1=82=
=D0=B0=D0=BD=D1=82=D0=B8=D0=BD
=D1=82=D0=B5=D0=BB.: +7 (909) 945-89-42


2015-08-10 16:51 GMT+03:00 Sage Weil <sage@newdream.net>:
> On Mon, 10 Aug 2015, ?????????? ??????? wrote:
>> Uploaded another corrupted piece.
>>
>> 2015-08-10 16:18:40.027726 7f7979697700 -1 log_channel(cluster) log
>> [ERR] : be_compare_scrubmaps: 3.fd shard 6: soid
>> f2e832fd/rbd_data.ab7174b0dc51.0000000000000249/head//3 data_digest
>> 0x64e94460 !=3D known data_digest 0xaec3bea8 from auth shard 10
>>
>> # ceph-post-file ceph-6-rbd_data.ab7174b0dc51.0000000000000249
>> ceph-post-file: e96e5828-b97c-45f1-8e3f-23abbf700865
>>
>> # ceph-post-file ceph-10-rbd_data.ab7174b0dc51.0000000000000249
>> ceph-post-file: e1277a33-74a5-4d46-93c8-266bd81867db
>>
>> I dont' think of bad disk:
>> - all OSDs SMART is clean,
>> - I tried to ceph pg repair 3.d8 on another OSDs in the past with th=
e
>> same result. Then I rebalanced the cluster so that pg 3.d8 moved to
>> [7,1].
>
> Again, it's all single bit changes:
>
> 144081,144082c144081,144082
> < 002c74e0  05 00 00 00 04 00 00 00  ff ff ff ff 04 00 00 00  |......=
=2E.........|
> < 002c74f0  ff ff ff ff 09 00 00 00  ff ff ff ff 04 00 00 00  |......=
=2E.........|
> ---
>> 002c74e0  04 00 00 00 04 00 00 00  ff ff ff ff 04 00 00 00  |.......=
=2E........|
>> 002c74f0  ff ff ff ff 08 00 00 00  ff ff ff ff 04 00 00 00  |.......=
=2E........|
> 144086,144087c144086,144087
> < 002c7530  03 00 00 00 1c 00 00 00  ff ff ff ff 08 00 00 00  |......=
=2E.........|
> < 002c7540  ff ff ff ff 03 00 00 00  04 00 00 00 08 00 00 00  |......=
=2E.........|
> ---
>> 002c7530  02 00 00 00 1c 00 00 00  ff ff ff ff 08 00 00 00  |.......=
=2E........|
>> 002c7540  ff ff ff ff 02 00 00 00  04 00 00 00 08 00 00 00  |.......=
=2E........|
> 144092c144092
> < 002c7590  04 00 00 00 ff ff ff ff  03 00 00 00 01 00 00 00  |......=
=2E.........|
> ---
>> 002c7590  04 00 00 00 ff ff ff ff  02 00 00 00 01 00 00 00  |.......=
=2E........|
> 144095c144095
> < 002c75c0  ff ff ff ff 04 00 00 00  ff ff ff ff 03 00 00 00  |......=
=2E.........|
> ---
>> 002c75c0  ff ff ff ff 04 00 00 00  ff ff ff ff 02 00 00 00  |.......=
=2E........|
> 173907c173907
> < 0033c070  ff ff ff ff 03 00 00 00  0c 00 00 00 ff ff ff ff  |......=
=2E.........|
> ---
>> 0033c070  ff ff ff ff 02 00 00 00  0c 00 00 00 ff ff ff ff  |.......=
=2E........|
> 199740c199740
> < 003a1020  ff ff c7 86 38 02 00 00  ff ff ff ff 6b 00 c7 86  |....8.=
=2E.....k...|
> ---
>> 003a1020  ff ff c7 86 38 02 00 00  ff ff ff ff 6a 00 c7 86  |....8..=
=2E....j...|
>
> It looks like it's also always the least significant bit in a 4-byte =
word.
>
> Can you see if there is any pattern to which OSDs are used for the
> inconsistent PGs?
>
> sage
>
>
>>
>> ??????? ??????????
>> ???.: +7 (909) 945-89-42
>>
>>
>> 2015-08-10 15:32 GMT+03:00 Sage Weil <sage@newdream.net>:
>> > On Mon, 10 Aug 2015, ?????????? ??????? wrote:
>> >> Posted 2 files
>> >>
>> >> ceph-1-rbd_data.3ef8442ae8944a.0000000000000aff
>> >> ceph-post-file: 10cddc98-7177-47d8-9a97-4868856f974b
>> >>
>> >> ceph-7-rbd_data.3ef8442ae8944a.0000000000000aff
>> >> ceph-post-file: f2861c0a-fc9a-4078-b95c-d5ba3cf6057e
>> >>
>> >> By the way, file names were found like this
>> >> /var/lib/ceph/osd/ceph-1/current/3.d8_head/DIR_8/DIR_D/DIR_2/rbd\=
udata.3ef8442ae8944a.0000000000000aff__head_CC49F2D8__3
>> >> /var/lib/ceph/osd/ceph-7/current/3.d8_head/DIR_8/DIR_D/DIR_2/DIR_=
=46/rbd\udata.3ef8442ae8944a.0000000000000aff__head_CC49F2D8__3
>> >> There is "rbd\udata." in the prefix, not "rbd_data.". Don't know =
if it
>> >> relevant to this case or not. Just FYI.
>> >
>> > The file contents differ by exactly one bit (0x0a -> 0x0b).  I wou=
ld
>> > look at the other PGs that are coming up inconsistent (ceph pg dum=
p | grep
>> > inconsistent) and see if there is a pattern to which OSDs they map=
 to.
>> > Maybe you just have a bad disk?
>> >
>> > sage
>> >
>> >
>> >>
>> >> ??????? ??????????
>> >> ???.: +7 (909) 945-89-42
>> >>
>> >>
>> >> 2015-08-09 17:23 GMT+03:00 Sage Weil <sage@newdream.net>:
>> >> > On Sat, 8 Aug 2015, ?????????? ??????? wrote:
>> >> >> Hi!
>> >> >>
>> >> >> I have a large number of inconsistent pgs 229 of 656, and it's
>> >> >> increasing every hour.
>> >> >> I'm using ceph version 0.94.2 (5fb85614ca8f354284c713a2f9c6108=
60720bbf3).
>> >> >>
>> >> >> For example, pg 3.d8:
>> >> >> # ceph health detail | grep 3.d8
>> >> >> pg 3.d8 is active+clean+scrubbing+deep+inconsistent, acting [1=
,7]
>> >> >>
>> >> >> # grep 3.d8 /var/log/ceph/ceph-osd.1.log | less -S
>> >> >> 2015-08-07 13:10:48.311810 7f5903f7a700 0 log_channel(cluster)=
 log
>> >> >> [INF] : 3.d8 repair starts 2015-08-07 13:12:05.703084 7f5903f7=
a700 -1
>> >> >> log_channel(cluster) log [ERR] : repair 3.d8
>> >> >> cbd2d0d8/rbd_data.6a5cf474b0dc51.0000000000000b1f/head//3 on d=
isk data
>> >> >> digest 0x6e4d80bf !=3D 0x6fb5b103 2015-08-07 13:13:26.837524
>> >> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
>> >> >> b5892d8/rbd_data.dbe674b0dc51.00000000000001b9/head//3 on disk=
 data
>> >> >> digest 0x79082779 !=3D 0x9f102f3d 2015-08-07 13:13:44.874725
>> >> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
>> >> >> ee6dc2d8/rbd_data.e7592ae8944a.0000000000000833/head//3 on dis=
k data
>> >> >> digest 0x63ab49d0 !=3D 0x68778496 2015-08-07 13:14:19.378582
>> >> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
>> >> >> d93e14d8/rbd_data.3ef8442ae8944a.0000000000000729/head//3 on d=
isk data
>> >> >> digest 0x3cdb1f5c !=3D 0x4e0400c2 2015-08-07 13:23:38.668080
>> >> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : 3.d8 repair 4=
 errors,
>> >> >> 0 fixed 2015-08-07 13:23:38.714668 7f5903f7a700 0 log_channel(=
cluster)
>> >> >> log [INF] : 3.d8 deep-scrub starts 2015-08-07 13:25:00.656306
>> >> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.=
d8
>> >> >> cbd2d0d8/rbd_data.6a5cf474b0dc51.0000000000000b1f/head//3 on d=
isk data
>> >> >> digest 0x6e4d80bf !=3D 0x6fb5b103 2015-08-07 13:26:18.775362
>> >> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.=
d8
>> >> >> b5892d8/rbd_data.dbe674b0dc51.00000000000001b9/head//3 on disk=
 data
>> >> >> digest 0x79082779 !=3D 0x9f102f3d 2015-08-07 13:26:42.084218
>> >> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.=
d8
>> >> >> ee6dc2d8/rbd_data.e7592ae8944a.0000000000000833/head//3 on dis=
k data
>> >> >> digest 0x59a6e7e0 !=3D 0x68778496 2015-08-07 13:26:56.495207
>> >> >
>> >> > This indicates the stored crc doesn't match the observed crc,
>> >> > and
>> >> >
>> >> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : be_compare_sc=
rubmaps:
>> >> >> 3.d8 shard 1: soid
>> >> >> cc49f2d8/rbd_data.3ef8442ae8944a.0000000000000aff/head//3 data=
_digest
>> >> >> 0x4e20a792 !=3D known data_digest 0xc0e9b2d2 from auth shard 7
>> >> >
>> >> > this indicates two replicas do not match.
>> >> >
>> >> >> 2015-08-07 13:27:12.134765 7f5903f7a700 -1 log_channel(cluster=
) log
>> >> >> [ERR] : deep-scrub 3.d8
>> >> >> d93e14d8/rbd_data.3ef8442ae8944a.0000000000000729/head//3 on d=
isk data
>> >> >> digest 0x3cdb1f5c !=3D 0x4e0400c2
>> >> >>
>> >> >> osd.7.log is clean for that period of time.
>> >> >> /var/log/dmesg is also clean.
>> >> >
>> >> > This really shouldn't happen, but there has been one recently f=
ixed bug
>> >> > that could have corrupted a replica.  Can you locate two mismat=
ched copies
>> >> > of some object on two different OSDs, and use ceph-post-file so=
 that we
>> >> > can take a look at the actual corruption?  For this PG, for exa=
mple, the
>> >> > mismatched copies are on osd.1 and osd.7.  On those hosts, you =
can find
>> >> > the backing file with
>> >> >
>> >> >  find /var/lib/ceph/osd/ceph-1/current/3.d8_head | grep rbd_dat=
a.3ef8442ae8944a.0000000000000aff
>> >> >
>> >> > Alternatively, if the data is sensitive, can you diff the hexdu=
mp -C
>> >> > output of both files, see what the differing bytes look like, a=
nd describe
>> >> > that to us?
>> >> >
>> >> > Thanks!
>> >> > sage
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>> >>
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
