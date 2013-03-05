From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: When ceph synchronizes journal to disk?
Date: Mon, 04 Mar 2013 21:33:13 -0700
Message-ID: <51357589.6080202@cs.utah.edu>
References: <513343D8.8050402@cs.utah.edu> <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:55289 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758759Ab3CEEdQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 23:33:16 -0500
In-Reply-To: <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Gregory,

Thanks for your reply.

On 03/04/2013 09:55 AM, Gregory Farnum wrote:
> The "journal [min|max] sync interval" values specify how frequently
> the OSD's "FileStore" sends a sync to the disk. However, data is stil=
l
> written into the normal filesystem as it comes in, and the normal
> filesystem continues to schedule normal dirty data writeouts. This is
> good =97 it means that when we do send a sync down you don't need to
> wait for all (30 seconds * 100MB/s) 3GB or whatever of data to go to
> disk before it's completed.

I do not think I understand this well. When the writeahead journal mode=
=20
is in use, would you please explain what happens to a single 4M write=20
request? I assume that an entry in the journal will be created for this=
=20
write request and after this entry is flushed to the journal disk, Ceph=
=20
returns successful. There should be no IO to the osd's disk. All IOs ar=
e=20
supposed to go to the journal disk. At a later time, Ceph will start to=
=20
apply these changes to the normal filesystem by reading from the first=20
entry at which its previous synchronization stops. Finally, it will rea=
d=20
this entry and apply this write change to the normal file system. Could=
=20
you please point out where is wrong in my understanding? Thanks,

>> >I am running 0.48.2. The related configuration is as follows.
> If you're starting up a new cluster I recommend upgrading to the
> bobtail series (.56.3) instead of using Argonaut =97 it's got a numbe=
r
> of enhancements you'll appreciate!

Yeah, I would like to use bobtail series. However, I started to make=20
small changes with Argonaut (0.48) and had ported my changes once to=20
0.48.2 when it was released. I think I am good to continue with it for=20
the moment. I may consider to port my changes to bobtail series at a=20
later time. Thanks,

Xing
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
