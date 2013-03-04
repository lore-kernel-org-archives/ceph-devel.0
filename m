From: Gregory Farnum <greg@inktank.com>
Subject: Re: When ceph synchronizes journal to disk?
Date: Mon, 4 Mar 2013 08:55:09 -0800
Message-ID: <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
References: <513343D8.8050402@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:57505 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866Ab3CDQzK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 11:55:10 -0500
Received: by mail-qa0-f46.google.com with SMTP id o13so1297328qaj.12
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 08:55:09 -0800 (PST)
In-Reply-To: <513343D8.8050402@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Mar 3, 2013 at 4:36 AM, Xing Lin <xinglin@cs.utah.edu> wrote:
> Hi,
>
> There were some discussions about this before on the mailing list but=
 I am
> still confused with this. I thought Ceph would flush data from the jo=
urnal
> to disk when either the journal is full or when the time to do
> synchronization is due. In my test experiment, I used 24 osds(one osd=
 for
> each disk). I used a 10 GB tmpfs file as the journal disk for each os=
d. Then
> for testing, I delayed the synchronization between the journal and di=
sk on
> purpose. I increased the 'journal min sync interval' to be 60 s and '=
journal
> max sync interval' to be 300 s. Then I created a rbd and then started=
 a 4M
> sequential write workload with fio for 30 seconds. I was expecting th=
at no
> IO should happen to disks, unless we have filled 240 GB data (10G*24)=
=2E
> However, 'iostat' showed there was data
> started to be written into disks (at about 20 MB/s per disk), right a=
fter I
> started the sequential workload. Could someone help to explain this
> situation?

The "journal [min|max] sync interval" values specify how frequently
the OSD's "FileStore" sends a sync to the disk. However, data is still
written into the normal filesystem as it comes in, and the normal
filesystem continues to schedule normal dirty data writeouts. This is
good =97 it means that when we do send a sync down you don't need to
wait for all (30 seconds * 100MB/s) 3GB or whatever of data to go to
disk before it's completed.


> I am running 0.48.2. The related configuration is as follows.
If you're starting up a new cluster I recommend upgrading to the
bobtail series (.56.3) instead of using Argonaut =97 it's got a number
of enhancements you'll appreciate!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
