From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: how to run ceph on top of other local file system
Date: Sun, 23 Oct 2011 14:22:20 -0500
Message-ID: <CAB7xdin1rNSi6zMQcnOviu2GVwnu3iNX46qh51vSviXZquhiRA@mail.gmail.com>
References: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
	<CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
	<CAB7xdim9QmtLWSVTrPoZofrwY=0PQEzsxtcBjA=pgS-GzLgzAw@mail.gmail.com>
	<CAF3hT9BwDAnUewrfTeZSWMuJSDHZW765jKF2sgQ2jNa32cLgxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54702 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1JWTWV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Oct 2011 15:22:21 -0400
Received: by iaby12 with SMTP id y12so488073iab.19
        for <ceph-devel@vger.kernel.org>; Sun, 23 Oct 2011 12:22:20 -0700 (PDT)
In-Reply-To: <CAF3hT9BwDAnUewrfTeZSWMuJSDHZW765jKF2sgQ2jNa32cLgxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

hi all,

does ceph only support ext3 and btrfs? i mean if i have another file
system, it support xattr, but it does not support journals, can i
close the journal config and run it with ceph?
i tried to do that by modifying the ceph.conf file (close the journal
on osd). the mkcephfs seems ok, but when i start the service, cosd
will crash.
here's the log:
2011-10-23 13:57:42.224779 7f1845ce6720 ceph version 0.34.commit:
2f039eeeb745622b866d80feda7afa055e15f6d6. process: cosd. pid: 7849
2011-10-23 13:57:42.225679 7f1845ce6720 filestore(/mnt/data/osd.0)
mount FIEMAP ioctl is NOT supported
2011-10-23 13:57:42.225697 7f1845ce6720 filestore(/mnt/data/osd.0)
mount did NOT detect btrfs
2011-10-23 13:57:42.225780 7f1845ce6720 filestore(/mnt/data/osd.0)
mount found snaps <>
2011-10-23 13:57:42.225805 7f1845ce6720 filestore(/mnt/data/osd.0)
mount WARNING: no btrfs, and no journal in writeahead mode; data may
be lost
2011-10-23 13:57:42.225831 7f1845ce6720 filestore(/mnt/data/osd.0)
mount WARNING: not btrfs or ext3; data may be lost
2011-10-23 13:57:42.225836 7f1845ce6720 filestore(/mnt/data/osd.0)
mount WARNING: no journal
*** Caught signal (Aborted) **
 in thread 0x7f1845ce6720
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: ./cosd() [0x5c6304]
 2: (()+0xf8f0) [0x7f18458dc8f0]
 3: (gsignal()+0x35) [0x7f1844307a75]
 4: (abort()+0x180) [0x7f184430b5c0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f1844bbd8e5]
 6: (()+0xcad16) [0x7f1844bbbd16]
 7: (()+0xcad43) [0x7f1844bbbd43]
 8: (()+0xcae3e) [0x7f1844bbbe3e]
 9: (CrushWrapper::decode(ceph::buffer::list::iterator&)+0xac) [0x5611fc]
 10: (OSDMap::decode(ceph::buffer::list&)+0x8aa) [0x5622aa]
 11: (OSD::get_map(unsigned int)+0x221) [0x52f441]
 12: (OSD::init()+0x47e) [0x53792e]
 13: (main()+0x2adc) [0x49d07c]
 14: (__libc_start_main()+0xfd) [0x7f18442f2c4d]
 15: ./cosd() [0x49a179]
2011-10-23 13:58:06.656315 7fcff35c6720 ceph version 0.34.commit:
2f039eeeb745622b866d80feda7afa055e15f6d6. process: cosd. pid: 8596
2011-10-23 13:58:06.657232 7fcff35c6720 filestore(/mnt/data/osd.0)
mount FIEMAP ioctl is NOT supported
2011-10-23 13:58:06.657250 7fcff35c6720 filestore(/mnt/data/osd.0)
mount did NOT detect btrfs
2011-10-23 13:58:06.657285 7fcff35c6720 filestore(/mnt/data/osd.0)
mount found snaps <>
2011-10-23 13:58:06.657302 7fcff35c6720 filestore(/mnt/data/osd.0)
mount WARNING: no btrfs, and no journal in writeahead mode; data may
be lost
2011-10-23 13:58:06.657325 7fcff35c6720 filestore(/mnt/data/osd.0)
mount WARNING: not btrfs or ext3; data may be lost
2011-10-23 13:58:06.657330 7fcff35c6720 filestore(/mnt/data/osd.0)
mount WARNING: no journal
*** Caught signal (Aborted) **
 in thread 0x7fcff35c6720
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: ./cosd() [0x5c6304]
 2: (()+0xf8f0) [0x7fcff31bc8f0]
 3: (gsignal()+0x35) [0x7fcff1be7a75]
 4: (abort()+0x180) [0x7fcff1beb5c0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fcff249d8e5]
 6: (()+0xcad16) [0x7fcff249bd16]
 7: (()+0xcad43) [0x7fcff249bd43]
 8: (()+0xcae3e) [0x7fcff249be3e]
 9: (CrushWrapper::decode(ceph::buffer::list::iterator&)+0xac) [0x5611fc]
 10: (OSDMap::decode(ceph::buffer::list&)+0x8aa) [0x5622aa]
 11: (OSD::get_map(unsigned int)+0x221) [0x52f441]
 12: (OSD::init()+0x47e) [0x53792e]
 13: (main()+0x2adc) [0x49d07c]
 14: (__libc_start_main()+0xfd) [0x7fcff1bd2c4d]
 15: ./cosd() [0x49a179]

does anyone have idea?

Thanks,
Sheng

On Mon, Oct 17, 2011 at 12:31 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Mon, Oct 17, 2011 at 10:20 AM, sheng qiu <herbert1984106@gmail.com> wrote:
>> if my local file system does not support extended attributes, can i
>> use it?
> Unfortunately not. Ceph requires xattr support; it uses xattrs for
> internal bookkeeping as well as for its own xattr support.
>
> Most filesystems do support xattrs these days, though; you probably
> just need to specify it as a mount option. :)
> -Greg
>



-- 
Sheng Qiu
Texas A & M University
Room 302 Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
