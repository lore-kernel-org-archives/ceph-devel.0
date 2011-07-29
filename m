From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: userland nfs server
Date: Fri, 29 Jul 2011 14:48:56 -0700
Message-ID: <CAN4=B2kg0S16=mHKQ+VJxSnKu4hzsJ=1G_Qz=HU9BFJxaPGH3A@mail.gmail.com>
References: <CAN4=B2n6NyFj1TBU52+4cdwEfh+q_fkZf_rUwUd7c1xZJwFqRQ@mail.gmail.com>
	<1459789254.140.1311966346661.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38199 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab1G2Vs5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2011 17:48:57 -0400
Received: by vxh35 with SMTP id 35so3001856vxh.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2011 14:48:57 -0700 (PDT)
In-Reply-To: <1459789254.140.1311966346661.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Not sure why this is failing:
AC_CHECK_HEADERS([ceph/libceph.h], [], [AC_MSG_ERROR( missing ceph
include files)])

$ ls -l /usr/include/ceph/libceph.h
-rw-r--r-- 1 root root 7543 Jul 26 10:57 /usr/include/ceph/libceph.h

=2E..
checking for ceph/libceph.h... no
configure: error: missing ceph include files


(I can move this discussion to another ml if preferred.)

On Fri, Jul 29, 2011 at 12:05 PM, Matt W. Benjamin <matt@linuxbox.com> =
wrote:
> Hi Brian,
>
> FSAL_CEPH doesn't involve the kernel client, rather an incidentally m=
odified libceph and libRADOS--it's linked into Ganesha, not using POSIX=
=2E =A0Writing directly to OSDs is part of the pNFS parallel access str=
ategy.
>
> Matt
>
> ----- "Brian Chrisman" <brchrisman@gmail.com> wrote:
>
>> On Fri, Jul 29, 2011 at 9:30 AM, Matt W. Benjamin <matt@linuxbox.com=
>
>> wrote:
>> > Hi Sage,
>> >
>> > We (Linux Box) have built and published a native FSAL for Ceph,
>> which is pretty advanced, and we've submitted the FSAL driver code
>> upstream for review Philippe Deniel.
>>
>> Looking at the FSAL_CEPH, is this expecting the filesystem to be
>> mounted via the ceph kernel client? =A0Have you considered building =
out
>> an FSAL using libceph as opposed as to writing directly to OSDs
>> (assumedly via libRADOS or librbd).
>>
>> >
>> > In addition, we're working on pNFS support in Ganesha and Ceph, an=
d
>> have a prototype file-based pNFS layout driver for the FSAL that tak=
es
>> advantage of Ceph OSDs for parallel IO.
>> >
>> > We're actively extending these efforts and there should be some
>> publication forthcoming.
>> >
>> > We have an external git repository here:
>> >
>> > =A0 =A0git://github.com/aemerson-linuxbox/ganesha.git
>> >
>> > We would really appreciate your feedback--and guidance on how to
>> participate in Ceph, we'd like to.
>> >
>> > Matt
>> >
>> > ----- "Sage Weil" <sage@newdream.net> wrote:
>> >
>> >> Has anyone looked at Genesha?
>> >>
>> >> =A0 =A0 =A0 http://sourceforge.net/apps/trac/nfs-ganesha/
>> >>
>> >> In principle it would probably be pretty straightforward to wire
>> that
>> >> up
>> >> to libceph and avoid the kernel NFS server for reexporting ceph
>> via
>> >> NFS...
>> >>
>> >> sage
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel"
>> >> in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >
>> > --
>> >
>> > Matt Benjamin
>> >
>> > The Linux Box
>> > 206 South Fifth Ave. Suite 150
>> > Ann Arbor, MI =A048104
>> >
>> > http://linuxbox.com
>> >
>> > tel. 734-761-4689
>> > fax. 734-769-8938
>> > cel. 734-216-5309
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>
> --
>
> Matt Benjamin
>
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI =A048104
>
> http://linuxbox.com
>
> tel. 734-761-4689
> fax. 734-769-8938
> cel. 734-216-5309
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
