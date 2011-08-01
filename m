From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: userland nfs server
Date: Mon, 1 Aug 2011 11:15:17 -0700
Message-ID: <CAN4=B2=Ej3bkL9DD4Zxen36pZqYeLgD2Gh8L5TKZTnWi-_qeWQ@mail.gmail.com>
References: <CAN4=B2n6NyFj1TBU52+4cdwEfh+q_fkZf_rUwUd7c1xZJwFqRQ@mail.gmail.com>
	<1459789254.140.1311966346661.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64319 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab1HASPS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 14:15:18 -0400
Received: by mail-vx0-f174.google.com with SMTP id 35so4365885vxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 11:15:17 -0700 (PDT)
In-Reply-To: <1459789254.140.1311966346661.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

vinodeno_t is not accessible via libceph (was it previously?) though
it's still used and it's in mdstypes.h, though it doesn't look like
it'll include in a straight C compile.  Is there a missing include?

[bchrisman (aemerson): src] $ find . -name '*.c' -o -name '*.h' |
xargs grep inodeno
=2E/include/FSAL/FSAL_CEPH/fsal_types.h:   vinodeno_t vi;
=2E/include/FSAL/FSAL_CEPH/fsal_types.h:  vinodeno_t vi;
=2E/include/FSAL/FSAL_CEPH/fsal_types.h:  vinodeno_t vi;
[bchrisman (aemerson): src] $

=2E./../include/FSAL/FSAL_CEPH/fsal_types.h:73: error: expected
specifier-qualifier-list before =91vinodeno_t=92

from mdstypes:

struct vinodeno_t {
  inodeno_t ino;
  snapid_t snapid;
  vinodeno_t() {}
  vinodeno_t(inodeno_t i, snapid_t s) : ino(i), snapid(s) {}

  void encode(bufferlist& bl) const {
    ::encode(ino, bl);
    ::encode(snapid, bl);
  }
  void decode(bufferlist::iterator& p) {
    ::decode(ino, p);
    ::decode(snapid, p);
  }
};
WRITE_CLASS_ENCODER(vinodeno_t)

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
