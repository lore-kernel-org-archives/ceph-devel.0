From: djlee064 <djlee064@gmail.com>
Subject: Re: read and write speed.
Date: Tue, 31 May 2011 15:20:03 +1200
Message-ID: <BANLkTim5m1xN=cAF-jjVpLNb1CJFbu5J6w@mail.gmail.com>
References: <4DE41F34.8020504@ufm.su>
	<BANLkTi=Pew-stDVCxUQoa5t2s5P8pWRomA@mail.gmail.com>
	<BANLkTikOLuHmw-3ijpamDgMdPeU4wqhXRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47390 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab1EaDUE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 May 2011 23:20:04 -0400
Received: by pwi15 with SMTP id 15so1857894pwi.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 May 2011 20:20:03 -0700 (PDT)
In-Reply-To: <BANLkTikOLuHmw-3ijpamDgMdPeU4wqhXRw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

=46rom my (bad) memory, I've tried fsync, and the resulting was still
the same in the end, i.e., write 100gb+ and all will be the same.
Can't test it now as it is already running other tasks..

I think the small bs (4-8k) results to ~ KB/s level using fsync. and
large, 4m+ will get much higher, but at this large bs, eventually,
results to the same as no-fsync when you continuously write stretch to
100gb+
Is this too obvious for anyone? (other than the shortstrkoing effect
which should be at most 20% diff)

how then journal-size (e.g., 1gb, 2gb, etc) set by the ceph actually
effect in performance (other than reliability and latency, etc)
If no reliability is ever needed and, say journal is turned off, how's
the performance effect? from my bad memory again, no-journal worsens
performance or had no effect . But I think this is again, tested 'not
long-enough'
e.g., other than journal flushing to disk (which shouldn't be a major
bottleneck, as Collin said  stuffs in journal gets continuously
flushing out to disk.

so in other words, set journal to 10gb, and dd for just 10gb, i should
get an unbelievable performance, then just change dd to 100gb, how
much drop? I haven't try this,
but from my very long test wrtites/read, testing many ranges up to 5TB
actual content, the disk does about 12.5MB/s at most. For small sets,
yes there I see high performance, etc.

Thanks

On Tue, May 31, 2011 at 14:48, Henry C Chang <henry.cy.chang@gmail.com>=
 wrote:
> 2011/5/31 djlee064 <djlee064@gmail.com>:
>> A bit off, but can you Fyodor, and all of devs run
>>
>> dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D10000 =A0 (10=
gb)
>> dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D50000 =A0 (50=
gb)
>> dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D100000 (100gb=
)
>>
>> and continue to 200gb,... 500gb
>>
>> see the MB/s difference, =A0expecting an enormous difference, e.g.,
>> starts ~200MB/s and drops down to well less than 50MB/s or even less
>> (Depending on the #disk, but about 12MB/s per-disk is what I have
>> analyzed)
>> I feel that Fyodor's and the rest of you are testing only a very sma=
ll
>> part, the high rate at the start is likely to be due to the journal
>> size.
>
> It's client-side caching effect. Without adding the option
> conv=3Dfdatasync (or fsync), dd returns the throughput without flushi=
ng
> the data.
>
> --Henry
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
