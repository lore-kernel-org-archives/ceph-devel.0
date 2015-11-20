From: Mike Almateia <mike.almateia@gmail.com>
Subject: Re: All-Flash Ceph cluster and journal
Date: Fri, 20 Nov 2015 13:42:30 +0300
Message-ID: <564EF916.5020101@gmail.com>
References: <564DB2A1.9080603@gmail.com> <564DDDE3.9050409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36075 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757997AbbKTKmg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 05:42:36 -0500
Received: by lbblt2 with SMTP id lt2so59843945lbb.3
        for <ceph-devel@vger.kernel.org>; Fri, 20 Nov 2015 02:42:34 -0800 (PST)
Received: from [127.0.0.1] ([212.34.43.122])
        by smtp.gmail.com with ESMTPSA id xn8sm1838808lbb.41.2015.11.20.02.42.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Nov 2015 02:42:33 -0800 (PST)
In-Reply-To: <564DDDE3.9050409@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

19-Nov-15 17:34, Mark Nelson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> This is actually the direction newstore is heading with the
> newstore_min_alloc_size so that you can configure when to write into =
the
> rocksdb WAL.  By default it's set to 512k, but for SSDs we will almos=
t
> certainly want to go smaller.
>
> On 11/19/2015 05:29 AM, Mike Almateia wrote:
>> Hello.
>>
>> By now we have SSD disks with a great perfomance under O_DIRECT/O_SY=
NC
>> flags (and we recomended to use they for journal).
>>
>> Why in a All-Flash type Ceph clusters we still use journal and them =
put
>> a data into OSD?
>> Why we can't just write a data into OSD with O_DIRECT/O_SYNC flags,
>> without journal?
>>
>> Can we just switch off the journal functional for all-flash ceph
>> clusters?
>>

Thanks for answer!

By now is it resonable to use NVMe Flash for OSD on Ceph? Overpower? Is=
=20
it possible to achive full speed NVMe Flash driver under Ceph?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
