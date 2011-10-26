From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: how to run ceph on top of other local file system
Date: Wed, 26 Oct 2011 09:07:18 -0500
Message-ID: <CAB7xdikHKc_EixAujGpkMzysO_7+0FipKhvyzZz7QELUV2d00A@mail.gmail.com>
References: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
	<CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
	<CAB7xdim9QmtLWSVTrPoZofrwY=0PQEzsxtcBjA=pgS-GzLgzAw@mail.gmail.com>
	<CAF3hT9BwDAnUewrfTeZSWMuJSDHZW765jKF2sgQ2jNa32cLgxw@mail.gmail.com>
	<CAB7xdin1rNSi6zMQcnOviu2GVwnu3iNX46qh51vSviXZquhiRA@mail.gmail.com>
	<CAORUGqAwJwzOe1g8JMoHduTenau5uQT6fwWJYQ2pixNnLZ3cmw@mail.gmail.com>
	<CAB7xdinFBP1r-PuebjEXh1Rdwge-iEYNQpJmhCM88xuyEmqZhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58233 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab1JZOHT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 10:07:19 -0400
Received: by iaby12 with SMTP id y12so1768584iab.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2011 07:07:18 -0700 (PDT)
In-Reply-To: <CAB7xdinFBP1r-PuebjEXh1Rdwge-iEYNQpJmhCM88xuyEmqZhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

hi,

thanks for the reply. i met a new problem. now i can mount the ceph
using cfuse. and write small single file. but it will crash when file
size increased to some number. the osd.log is:
2011-10-26 08:59:20.156983 7febdca06700 journal FileJournal::write_bl
: write_fd failed: error 13: Permission denied
2011-10-26 08:59:20.157000 7febdca06700 journal FileJournal::do_write:
write_bl(pos=3D10481664) failed
os/FileJournal.cc: In function 'void
=46ileJournal::do_write(ceph::bufferlist&)', in thread '0x7febdca06700'
os/FileJournal.cc: 817: FAILED assert(0)
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: (FileJournal::do_write(ceph::buffer::list&)+0x367) [0x6b61f7]
 2: (FileJournal::write_thread_entry()+0x3e6) [0x6b97c6]
 3: (FileJournal::Writer::entry()+0xd) [0x6a50dd]
 4: (()+0x69ca) [0x7febe38119ca]
 5: (clone()+0x6d) [0x7febe22f870d]
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: (FileJournal::do_write(ceph::buffer::list&)+0x367) [0x6b61f7]
 2: (FileJournal::write_thread_entry()+0x3e6) [0x6b97c6]
 3: (FileJournal::Writer::entry()+0xd) [0x6a50dd]
 4: (()+0x69ca) [0x7febe38119ca]
 5: (clone()+0x6d) [0x7febe22f870d]
*** Caught signal (Aborted) **
 in thread 0x7febdca06700
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: ./cosd() [0x5c69d4]
 2: (()+0xf8f0) [0x7febe381a8f0]
 3: (gsignal()+0x35) [0x7febe2245a75]
 4: (abort()+0x180) [0x7febe22495c0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7febe2afb8e5]
 6: (()+0xcad16) [0x7febe2af9d16]
 7: (()+0xcad43) [0x7febe2af9d43]
 8: (()+0xcae3e) [0x7febe2af9e3e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x39f) [0x5cbb1f]
 10: (FileJournal::do_write(ceph::buffer::list&)+0x367) [0x6b61f7]
 11: (FileJournal::write_thread_entry()+0x3e6) [0x6b97c6]
 12: (FileJournal::Writer::entry()+0xd) [0x6a50dd]
 13: (()+0x69ca) [0x7febe38119ca]
 14: (clone()+0x6d) [0x7febe22f870d]

does any one have idea about this?

Thanks,
Sheng

On Mon, Oct 24, 2011 at 2:02 PM, sheng qiu <herbert1984106@gmail.com> w=
rote:
> hi,
>
> is there any way to debug ceph to find out where it crash?
>
> Thanks,
> Sheng
>
> On Mon, Oct 24, 2011 at 11:55 AM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
>> On Sun, Oct 23, 2011 at 12:22, sheng qiu <herbert1984106@gmail.com> =
wrote:
>>> does ceph only support ext3 and btrfs? i mean if i have another fil=
e
>>> system, it support xattr, but it does not support journals, can i
>>> close the journal config and run it with ceph?
>>
>> Ceph supports OSD storage on POSIX-compliant filesystems with extend=
ed
>> attributes. There are some edge cases that are still problematic, se=
e
>> the email with subject "ceph on non-btrfs file systems" that Sage ju=
st
>> sent for a better discussion of those.
>>
>> I'm not sure what you mean by a filesystem "not supporting journals"=
,
>> the ceph-osd journal is just a file it writes to. I'm not sure what
>> you mean by "closing the journal config"; you can disable the journa=
l,
>> but that will likely just make things slower; once again, using a
>> journal is possible on any filesystem, btrfs just makes it more
>> effective.
>>
>>> i tried to do that by modifying the ceph.conf file (close the journ=
al
>>> on osd). the mkcephfs seems ok, but when i start the service, cosd
>>> will crash.
>>> here's the log:
>>> *** Caught signal (Aborted) **
>>> =A0in thread 0x7f1845ce6720
>>> =A0ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6=
d6)
>>> =A01: ./cosd() [0x5c6304]
>> ...
>>> =A09: (CrushWrapper::decode(ceph::buffer::list::iterator&)+0xac) [0=
x5611fc]
>>> =A010: (OSDMap::decode(ceph::buffer::list&)+0x8aa) [0x5622aa]
>>> =A011: (OSD::get_map(unsigned int)+0x221) [0x52f441]
>>
>> That sounds more like the osdmap is corrupt, somehow. Anyone else ha=
ve
>> more specific suggestions?
>>
>
>
>
> --
> Sheng Qiu
> Texas A & M University
> Room 302 Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259
>



--=20
Sheng Qiu
Texas A & M University
Room 302 Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
