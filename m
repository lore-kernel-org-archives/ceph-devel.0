From: Wido den Hollander <wido@42on.com>
Subject: Re: CephFS and Samba hang on copy of large file
Date: Tue, 16 Aug 2016 12:44:02 +0200 (CEST)
Message-ID: <1252645494.2536.1471344242365@ox.pcextreme.nl>
References: <1423426743.2483.1471267435085@ox.pcextreme.nl>
 <CAAPGDwLxomxLJMZNsW7qs9vqjnxH9zbBkUjBok7tsHXA_rt3yA@mail.gmail.com>
 <1197956778.2488.1471268140723@ox.pcextreme.nl>
 <CAAPGDwKx6w3s5gG9FHu91kLz4kurPD+B1cQNdo8oKYmGu2L-Qg@mail.gmail.com>
 <1951857528.2492.1471269515710@ox.pcextreme.nl>
 <CANP1eJHBW4e2wYKV0z0fRMVaGu_tmn+KewACsupnhoB4uGeTHg@mail.gmail.com>
 <1229560418.2529.1471343525435@ox.pcextreme.nl>
 <CAAPGDwJ_B8kC3ye1G54dDRO_7yUhDN67PswYLZb1EL6GQtRjKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:54838 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbcHPKoI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2016 06:44:08 -0400
In-Reply-To: <CAAPGDwJ_B8kC3ye1G54dDRO_7yUhDN67PswYLZb1EL6GQtRjKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ira Cooper <ira@wakeful.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Milosz Tanski <milosz@adfin.com>


> Op 16 augustus 2016 om 12:38 schreef Ira Cooper <ira@wakeful.net>:
> 
> 
> On Tue, Aug 16, 2016 at 6:32 AM, Wido den Hollander <wido@42on.com> wrote:
> >
> >> Op 15 augustus 2016 om 23:36 schreef Milosz Tanski <milosz@adfin.com>:
> >>
> >>
> >> On Mon, Aug 15, 2016 at 9:58 AM, Wido den Hollander <wido@42on.com> wrote:
> >> >
> >> >> Op 15 augustus 2016 om 15:43 schreef Ira Cooper <ira@wakeful.net>:
> >> >>
> >> >>
> >> >> On Mon, Aug 15, 2016 at 9:35 AM, Wido den Hollander <wido@42on.com> wrote:
> >> >> >
> >> >> >> Op 15 augustus 2016 om 15:27 schreef Ira Cooper <ira@wakeful.net>:
> >> >> >>
> >> >> >>
> >> >> >> Have you tried the ceph VFS module in Samba yet?
> >> >> >>
> >> >> >
> >> >> > Yes. That works, but the performance is a lot lower. So for that we are testing/using the CephFS kernel client.
> >> >> >
> >> >> > I would also like to see the VFS module upstream in Samba, you still need to manually patch it in.
> >> >>
> >> >> It is in upstream Samba.
> >> >>
> >> >> https://git.samba.org/?p=samba.git;a=blob;f=source3/modules/vfs_ceph.c;h=59e9b9cf9b3e8e5313a20823994fcacf9e4b4168;hb=f1b42ec778e08875e076df7fdf67dd69bf9b2757
> >> >>
> >> >> It's been there a while now.
> >> >>
> >> >> I'm curious what you are patching in, and what the performance numbers are. :)
> >> >
> >> > No, sorry for that confusion. I meant DEB and/or RPM packages. You have to compile manually which not all companies like.
> >> >
> >> > With the kernel client we see about 200MB/sec and with VFS about 50MB/sec.
> >>
> >> I'm willing to bet that at lest some of it is page cache & read ahead.
> >>
> >
> > Probably indeed. Tested with Jewel and VFS and we see a much higher throughput right now.
> >
> > We had to disable sendfile in Samba though.
> >
> > Still, it's not good that Samba locked up and stayed in status D. That should not happen.
> 
> Sendfile doesn't make much sense with a userspace filesystem like vfs_ceph.
> 

True, but it was still in the config. Had to debug that.

> You said performance improved, how much?
> 

We went from 50MB/sec to 150 ~ 200MB/sec write speed.

Writing directly to CephFS (kernel) goes with 900MB/sec.

> Also are you using copy, robocopy, the windows explorer?  And which
> version of Windows?
> 

A wide range of Operating Systems. In this case it was a Ubuntu 16.04 desktop, but the clients are also Windows 7, 8 and Windows 10. Just using the Explorer in Windows's case.

Wido

> Thanks,
> 
> -Ira
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
