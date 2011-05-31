From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: read and write speed.
Date: Tue, 31 May 2011 15:06:25 +0800
Message-ID: <BANLkTikSN836svxj7R19CbmGzTn4sUgwcw@mail.gmail.com>
References: <4DE41F34.8020504@ufm.su>
	<BANLkTi=Pew-stDVCxUQoa5t2s5P8pWRomA@mail.gmail.com>
	<BANLkTikOLuHmw-3ijpamDgMdPeU4wqhXRw@mail.gmail.com>
	<BANLkTim5m1xN=cAF-jjVpLNb1CJFbu5J6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61685 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab1EaHG0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 03:06:26 -0400
Received: by fxm17 with SMTP id 17so2828857fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 00:06:25 -0700 (PDT)
In-Reply-To: <BANLkTim5m1xN=cAF-jjVpLNb1CJFbu5J6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: djlee064 <djlee064@gmail.com>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

2011/5/31 djlee064 <djlee064@gmail.com>:
> From my (bad) memory, I've tried fsync, and the resulting was still
> the same in the end, i.e., write 100gb+ and all will be the same.
> Can't test it now as it is already running other tasks..
>
> I think the small bs (4-8k) results to ~ KB/s level using fsync. and
> large, 4m+ will get much higher, but at this large bs, eventually,
> results to the same as no-fsync when you continuously write stretch t=
o
> 100gb+
> Is this too obvious for anyone? (other than the shortstrkoing effect
> which should be at most 20% diff)

Caching effect decreases as the writing size increases. Sure, when you
write 100GB+ data, the difference may be subtle. (It still depends on
your RAM size.)

>
> how then journal-size (e.g., 1gb, 2gb, etc) set by the ceph actually
> effect in performance (other than reliability and latency, etc)
> If no reliability is ever needed and, say journal is turned off, how'=
s
> the performance effect? from my bad memory again, no-journal worsens
> performance or had no effect . But I think this is again, tested 'not
> long-enough'
> e.g., other than journal flushing to disk (which shouldn't be a major
> bottleneck, as Collin said =C2=A0stuffs in journal gets continuously
> flushing out to disk.
>
> so in other words, set journal to 10gb, and dd for just 10gb, i shoul=
d
> get an unbelievable performance, then just change dd to 100gb, how
> much drop? I haven't try this,
> but from my very long test wrtites/read, testing many ranges up to 5T=
B
> actual content, the disk does about 12.5MB/s at most. For small sets,
> yes there I see high performance, etc.

I am not sure what you mean here. Perhaps somebody can answer it. Sorry=
=2E

--Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
