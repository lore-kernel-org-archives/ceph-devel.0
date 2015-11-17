From: Guang Yang <guangyy@gmail.com>
Subject: Re: Newly added monitor infinitely sync store
Date: Mon, 16 Nov 2015 17:48:58 -0800
Message-ID: <CAKtk8heH8PxxNB_YhQGcnVo=mX=NZ2uPqm6Obb5QfJ8ZuEvqGg@mail.gmail.com>
References: <CAKtk8hdHfR8eAMD0dMS+kETmg4rHxLCXp_p_DW_HTzjr-FhASg@mail.gmail.com>
	<alpine.DEB.2.00.1511131614350.7964@cobra.newdream.net>
	<CAKtk8hcsbmfZ_pu=2OY9ke8irkbMk69weps+RSs3Npuo9A0stw@mail.gmail.com>
	<alpine.DEB.2.00.1511131701520.7964@cobra.newdream.net>
	<CAKtk8he-6_uUqUDFCE2TJAPZyY=yPEN=pVm14m03qihvhdskbQ@mail.gmail.com>
	<CAKtk8heRQ=+baTwsKw2aco01dzC6Prz3XjdxXA3kNGvLw9+2kQ@mail.gmail.com>
	<alpine.DEB.2.00.1511161741520.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33806 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbKQBs7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Nov 2015 20:48:59 -0500
Received: by ykfs79 with SMTP id s79so271455879ykf.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2015 17:48:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511161741520.7964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, joao@suse.de

On Mon, Nov 16, 2015 at 5:42 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 16 Nov 2015, Guang Yang wrote:
>> I spoke to a leveldb expert, it looks like this is a known pattern on
>> LSM tree data structure - the tail latency for range scan could be far
>> longer than avg/median since it might need to mmap several sst files
>> to get the record.
>>
>> Hi Sage,
>> Do you see any harm to increase the default value for this setting
>> (e.g. 20 minutes)? Or should I add the advise for monitor
>> trouble-shooting?
>
> The timeout is just for a round trip for the sync process, right?  I think
> increasing it a bit (2x or 3x?) is okay, but 20 minutes to do a single
> chunk is a lot.
Yeah the timeout is for a single round trip (there is timeout reset
mechanism at both sides).
>
> The underlying problem in your cases is that your store is huge (by ~2
> orders of magnitude), so I'm not sure we should tune against that :)
Ok, let me apply the patches and monitor the db growth.
>
> sage
>
>
>  >
>> Thanks,
>> Guang
>>
>> On Fri, Nov 13, 2015 at 9:07 PM, Guang Yang <guangyy@gmail.com> wrote:
>> > Thanks Sage! I will definitely try those patches.
>> >
>> > For this one, I finally managed to bring the new monitor in by
>> > increasing the mon_sync_timeout from its default 60 to 60000 to make
>> > sure the syncing does not restart and result in an infinite loop..
>> >
>> > On Fri, Nov 13, 2015 at 5:04 PM, Sage Weil <sage@newdream.net> wrote:
>> >> On Fri, 13 Nov 2015, Guang Yang wrote:
>> >>> Thanks Sage!
>> >>>
>> >>> On Fri, Nov 13, 2015 at 4:15 PM, Sage Weil <sage@newdream.net> wrote:
>> >>> > On Fri, 13 Nov 2015, Guang Yang wrote:
>> >>> >> I was wrong the previous analysis, it was not the iterator got reset,
>> >>> >> the problem I can see now, is that during the syncing, a new round of
>> >>> >> election kicked off and thus it needs to probe the newly added
>> >>> >> monitor, however, since it hasn't been synced yet, it will restart the
>> >>> >> syncing from there.
>> >>> >
>> >>> > What version of this?  I think this is something we fixed a while back?
>> >>> This is on Giant (c51c8f9d80fa4e0168aa52685b8de40e42758578), is there
>> >>> a commit I can take a look?
>> >>
>> >> Hrm, I guess it was way befoer that.. I'm thinking of
>> >> b8af38b6fc161691d637631d9ce8ab84fb3d27c7 which was pre-firefly.  So I'm
>> >> not sure exactly why an election would be restarting the sync in your
>> >> case..
>> >>
>> >> You mentioned elsewhere that your mon store was very large, though (more
>> >> than 10's of GB), which suggests you might be hitting the
>> >> min_last_epoch_clean problem (which prevents osdmap trimming).. see
>> >> b41408302b6529a7856a3b0a08c35e5fa284882e.  This was backported to hammer
>> >> and firefly but not giant.
>> >>
>> >> sage
>> >>
>>
>>
