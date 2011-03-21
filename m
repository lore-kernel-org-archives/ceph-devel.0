From: Ben De Luca <bdeluca@gmail.com>
Subject: Re: Disk allocation
Date: Mon, 21 Mar 2011 17:32:46 +0000
Message-ID: <AANLkTi=Jji78-otu2NFTCe9g9fE7LbiOUQOxeiwx5evq@mail.gmail.com>
References: <1449881494.12831.1300600065210.JavaMail.root@mail.linserv.se>
	<51655650.12833.1300603409038.JavaMail.root@mail.linserv.se>
	<AANLkTimo+LohYdZdF4SSEar3HHfuHf8tqn5FCvee620B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63297 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1CURfe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 13:35:34 -0400
Received: by bwz15 with SMTP id 15so5210609bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 10:35:32 -0700 (PDT)
In-Reply-To: <AANLkTimo+LohYdZdF4SSEar3HHfuHf8tqn5FCvee620B@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Martin Wilderoth <martin.wilderoth@linserv.se>, ceph-devel@vger.kernel.org

Sorry to jump into the converstation, how slow can the deletion of
files actually be?

One of the tests I ran a few weeks ago had me generating files,
deleting them and then writing them again from a number of clients. I
noticed that the space would never freed up again. I have my OSD's and
their journals  on dedicated partions.

I had planned on asking more on this once I had a stable system again.



On Mon, Mar 21, 2011 at 3:17 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Sat, Mar 19, 2011 at 11:43 PM, Martin Wilderoth
> <martin.wilderoth@linserv.se> wrote:
>> I have a small ceph cluster with 4 osd ( 2 disks on 2 hosts).
>>
>> I have been adding and removing files from the file system, mounted =
as ceph on an other host.
>>
>> Now I have removed most of the data on the file system, so I only ha=
ve 300 MB left plus two snapshots.
>>
>> The problem is that looking at the disks the are allocating 88G of d=
ata
>> on the ceph filesystem.
> There are a few possibilities:
> 1) You've hosted your OSDs on a partition that's shared with the rest
> of the computer. In that case the reported used space will include
> whatever else is on the partition, not just the Ceph files. (This can
> include Ceph debug logs, so even if nothing used to be there but you
> were logging on that partition that can build up pretty quickly.)
> 2) You deleted the files quickly and just haven't given enough time
> for the file deletion to propagate to the OSDs. Because the POSIX
> filesystem is layered over an object store, this can take some time.
> 3) Your snapshots contain a lot of files, so nothing (or very little)
> actually got deleted. Snapshots are pretty cool but they aren't
> miraculous disk space!
> Given the uneven distribution of disk space I suspect option #2, but =
I
> could be mistaken. :) Let us know!
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
