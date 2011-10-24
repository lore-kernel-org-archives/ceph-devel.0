From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: how to run ceph on top of other local file system
Date: Mon, 24 Oct 2011 09:55:05 -0700
Message-ID: <CAORUGqAwJwzOe1g8JMoHduTenau5uQT6fwWJYQ2pixNnLZ3cmw@mail.gmail.com>
References: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
 <CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
 <CAB7xdim9QmtLWSVTrPoZofrwY=0PQEzsxtcBjA=pgS-GzLgzAw@mail.gmail.com>
 <CAF3hT9BwDAnUewrfTeZSWMuJSDHZW765jKF2sgQ2jNa32cLgxw@mail.gmail.com> <CAB7xdin1rNSi6zMQcnOviu2GVwnu3iNX46qh51vSviXZquhiRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49699 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab1JXQz0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2011 12:55:26 -0400
Received: by wyg36 with SMTP id 36so6392512wyg.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2011 09:55:25 -0700 (PDT)
In-Reply-To: <CAB7xdin1rNSi6zMQcnOviu2GVwnu3iNX46qh51vSviXZquhiRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Oct 23, 2011 at 12:22, sheng qiu <herbert1984106@gmail.com> wro=
te:
> does ceph only support ext3 and btrfs? i mean if i have another file
> system, it support xattr, but it does not support journals, can i
> close the journal config and run it with ceph?

Ceph supports OSD storage on POSIX-compliant filesystems with extended
attributes. There are some edge cases that are still problematic, see
the email with subject "ceph on non-btrfs file systems" that Sage just
sent for a better discussion of those.

I'm not sure what you mean by a filesystem "not supporting journals",
the ceph-osd journal is just a file it writes to. I'm not sure what
you mean by "closing the journal config"; you can disable the journal,
but that will likely just make things slower; once again, using a
journal is possible on any filesystem, btrfs just makes it more
effective.

> i tried to do that by modifying the ceph.conf file (close the journal
> on osd). the mkcephfs seems ok, but when i start the service, cosd
> will crash.
> here's the log:
> *** Caught signal (Aborted) **
> =C2=A0in thread 0x7f1845ce6720
> =C2=A0ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f=
6d6)
> =C2=A01: ./cosd() [0x5c6304]
=2E..
> =C2=A09: (CrushWrapper::decode(ceph::buffer::list::iterator&)+0xac) [=
0x5611fc]
> =C2=A010: (OSDMap::decode(ceph::buffer::list&)+0x8aa) [0x5622aa]
> =C2=A011: (OSD::get_map(unsigned int)+0x221) [0x52f441]

That sounds more like the osdmap is corrupt, somehow. Anyone else have
more specific suggestions?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
