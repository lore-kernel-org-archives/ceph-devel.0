From: Ira Cooper <ira@wakeful.net>
Subject: Re: CephFS and Samba hang on copy of large file
Date: Tue, 16 Aug 2016 07:59:23 -0400
Message-ID: <CAAPGDwJDNRuBUxaBMCHU-zsMWTLAesi2Upqs2gKVprH=hmz5ew@mail.gmail.com>
References: <1423426743.2483.1471267435085@ox.pcextreme.nl>
 <CAAPGDwLxomxLJMZNsW7qs9vqjnxH9zbBkUjBok7tsHXA_rt3yA@mail.gmail.com>
 <1197956778.2488.1471268140723@ox.pcextreme.nl> <CAAPGDwKx6w3s5gG9FHu91kLz4kurPD+B1cQNdo8oKYmGu2L-Qg@mail.gmail.com>
 <1951857528.2492.1471269515710@ox.pcextreme.nl> <CANP1eJHBW4e2wYKV0z0fRMVaGu_tmn+KewACsupnhoB4uGeTHg@mail.gmail.com>
 <1229560418.2529.1471343525435@ox.pcextreme.nl> <CAAPGDwJ_B8kC3ye1G54dDRO_7yUhDN67PswYLZb1EL6GQtRjKg@mail.gmail.com>
 <1252645494.2536.1471344242365@ox.pcextreme.nl> <CAAPGDwJV_+G7ZQ0pzrSuLxtDuHDoiU-yYgv0ohxL47qTr99PqA@mail.gmail.com>
 <1519079957.2552.1471347820959@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35769 "EHLO
	mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbcHPL7o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2016 07:59:44 -0400
Received: by mail-ua0-f176.google.com with SMTP id n59so117221994uan.2
        for <ceph-devel@vger.kernel.org>; Tue, 16 Aug 2016 04:59:44 -0700 (PDT)
In-Reply-To: <1519079957.2552.1471347820959@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Milosz Tanski <milosz@adfin.com>

On Tue, Aug 16, 2016 at 7:43 AM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 16 augustus 2016 om 12:48 schreef Ira Cooper <ira@wakeful.net>:
>>
>>
>> On Tue, Aug 16, 2016 at 6:44 AM, Wido den Hollander <wido@42on.com> wrote:
>> >
>> >> Op 16 augustus 2016 om 12:38 schreef Ira Cooper <ira@wakeful.net>:
>> >>
>> >>
>> >> On Tue, Aug 16, 2016 at 6:32 AM, Wido den Hollander <wido@42on.com> wrote:
>> >> >
>> >> >> Op 15 augustus 2016 om 23:36 schreef Milosz Tanski <milosz@adfin.com>:
>> >> >>
>> >> >>
>> >> >> On Mon, Aug 15, 2016 at 9:58 AM, Wido den Hollander <wido@42on.com> wrote:
>> >> >> >
>> >> >> >> Op 15 augustus 2016 om 15:43 schreef Ira Cooper <ira@wakeful.net>:
>> >> >> >>
>> >> >> >>
>> >> >> >> On Mon, Aug 15, 2016 at 9:35 AM, Wido den Hollander <wido@42on.com> wrote:
>> >> >> >> >
>> >> >> >> >> Op 15 augustus 2016 om 15:27 schreef Ira Cooper <ira@wakeful.net>:
>> >> >> >> >>
>> >> >> >> >>
>> >> >> >> >> Have you tried the ceph VFS module in Samba yet?
>> >> >> >> >>
>> >> >> >> >
>> >> >> >> > Yes. That works, but the performance is a lot lower. So for that we are testing/using the CephFS kernel client.
>> >> >> >> >
>> >> >> >> > I would also like to see the VFS module upstream in Samba, you still need to manually patch it in.
>> >> >> >>
>> >> >> >> It is in upstream Samba.
>> >> >> >>
>> >> >> >> https://git.samba.org/?p=samba.git;a=blob;f=source3/modules/vfs_ceph.c;h=59e9b9cf9b3e8e5313a20823994fcacf9e4b4168;hb=f1b42ec778e08875e076df7fdf67dd69bf9b2757
>> >> >> >>
>> >> >> >> It's been there a while now.
>> >> >> >>
>> >> >> >> I'm curious what you are patching in, and what the performance numbers are. :)
>> >> >> >
>> >> >> > No, sorry for that confusion. I meant DEB and/or RPM packages. You have to compile manually which not all companies like.
>> >> >> >
>> >> >> > With the kernel client we see about 200MB/sec and with VFS about 50MB/sec.
>> >> >>
>> >> >> I'm willing to bet that at lest some of it is page cache & read ahead.
>> >> >>
>> >> >
>> >> > Probably indeed. Tested with Jewel and VFS and we see a much higher throughput right now.
>> >> >
>> >> > We had to disable sendfile in Samba though.
>> >> >
>> >> > Still, it's not good that Samba locked up and stayed in status D. That should not happen.
>> >>
>> >> Sendfile doesn't make much sense with a userspace filesystem like vfs_ceph.
>> >>
>> >
>> > True, but it was still in the config. Had to debug that.
>> >
>> >> You said performance improved, how much?
>> >>
>> >
>> > We went from 50MB/sec to 150 ~ 200MB/sec write speed.
>> >
>> > Writing directly to CephFS (kernel) goes with 900MB/sec.
>> >
>> >> Also are you using copy, robocopy, the windows explorer?  And which
>> >> version of Windows?
>> >>
>> >
>> > A wide range of Operating Systems. In this case it was a Ubuntu 16.04 desktop, but the clients are also Windows 7, 8 and Windows 10. Just using the Explorer in Windows's case.
>>
>> Were you talking read or write performance before?
>>
>
> All write performance. We don't care that much about read in this environment.

Ok then AIO won't have much impact, nor much of anything.  I'm now much more
curious about what is going on :).

>> Also any chance you could run these tests from a Windows 7+ machine?
>>
>> I know it is an odd request on a Linux list, but for debugging Samba,
>> it helps at times.
>>
>
> I'm currently not at that customer, so I'm not able to run the test. I also don't have remote access.
>
> The hang we saw was from a Windows 7 desktop btw, not the Ubuntu one. We just used the Ubuntu desktop to see if it also happened there.

Alas, the use pattern will be different between the two. :(

SMB 2.1 vs. SMB1 with unix extensions is a major delta.

Cheers,

-Ira
