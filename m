From: Guang Yang <guangyy@gmail.com>
Subject: Re: Newly added monitor infinitely sync store
Date: Fri, 13 Nov 2015 21:07:59 -0800
Message-ID: <CAKtk8he-6_uUqUDFCE2TJAPZyY=yPEN=pVm14m03qihvhdskbQ@mail.gmail.com>
References: <CAKtk8hdHfR8eAMD0dMS+kETmg4rHxLCXp_p_DW_HTzjr-FhASg@mail.gmail.com>
	<alpine.DEB.2.00.1511131614350.7964@cobra.newdream.net>
	<CAKtk8hcsbmfZ_pu=2OY9ke8irkbMk69weps+RSs3Npuo9A0stw@mail.gmail.com>
	<alpine.DEB.2.00.1511131701520.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:32958 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbKNFIA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Nov 2015 00:08:00 -0500
Received: by ykdv3 with SMTP id v3so178808327ykd.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 Nov 2015 21:07:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511131701520.7964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, joao@suse.de

Thanks Sage! I will definitely try those patches.

For this one, I finally managed to bring the new monitor in by
increasing the mon_sync_timeout from its default 60 to 60000 to make
sure the syncing does not restart and result in an infinite loop..

On Fri, Nov 13, 2015 at 5:04 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 13 Nov 2015, Guang Yang wrote:
>> Thanks Sage!
>>
>> On Fri, Nov 13, 2015 at 4:15 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Fri, 13 Nov 2015, Guang Yang wrote:
>> >> I was wrong the previous analysis, it was not the iterator got reset,
>> >> the problem I can see now, is that during the syncing, a new round of
>> >> election kicked off and thus it needs to probe the newly added
>> >> monitor, however, since it hasn't been synced yet, it will restart the
>> >> syncing from there.
>> >
>> > What version of this?  I think this is something we fixed a while back?
>> This is on Giant (c51c8f9d80fa4e0168aa52685b8de40e42758578), is there
>> a commit I can take a look?
>
> Hrm, I guess it was way befoer that.. I'm thinking of
> b8af38b6fc161691d637631d9ce8ab84fb3d27c7 which was pre-firefly.  So I'm
> not sure exactly why an election would be restarting the sync in your
> case..
>
> You mentioned elsewhere that your mon store was very large, though (more
> than 10's of GB), which suggests you might be hitting the
> min_last_epoch_clean problem (which prevents osdmap trimming).. see
> b41408302b6529a7856a3b0a08c35e5fa284882e.  This was backported to hammer
> and firefly but not giant.
>
> sage
>
