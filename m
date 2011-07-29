From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: userland nfs server
Date: Fri, 29 Jul 2011 11:43:58 -0700
Message-ID: <CAN4=B2n6NyFj1TBU52+4cdwEfh+q_fkZf_rUwUd7c1xZJwFqRQ@mail.gmail.com>
References: <1766745211.75.1311956818895.JavaMail.root@thunderbeast.private.linuxbox.com>
	<1843323934.77.1311957032511.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55210 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1G2Sn7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2011 14:43:59 -0400
Received: by vws1 with SMTP id 1so3182593vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2011 11:43:59 -0700 (PDT)
In-Reply-To: <1843323934.77.1311957032511.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Fri, Jul 29, 2011 at 9:30 AM, Matt W. Benjamin <matt@linuxbox.com> w=
rote:
> Hi Sage,
>
> We (Linux Box) have built and published a native FSAL for Ceph, which=
 is pretty advanced, and we've submitted the FSAL driver code upstream =
for review Philippe Deniel.

Looking at the FSAL_CEPH, is this expecting the filesystem to be
mounted via the ceph kernel client?  Have you considered building out
an FSAL using libceph as opposed as to writing directly to OSDs
(assumedly via libRADOS or librbd).

>
> In addition, we're working on pNFS support in Ganesha and Ceph, and h=
ave a prototype file-based pNFS layout driver for the FSAL that takes a=
dvantage of Ceph OSDs for parallel IO.
>
> We're actively extending these efforts and there should be some publi=
cation forthcoming.
>
> We have an external git repository here:
>
> =A0 =A0git://github.com/aemerson-linuxbox/ganesha.git
>
> We would really appreciate your feedback--and guidance on how to part=
icipate in Ceph, we'd like to.
>
> Matt
>
> ----- "Sage Weil" <sage@newdream.net> wrote:
>
>> Has anyone looked at Genesha?
>>
>> =A0 =A0 =A0 http://sourceforge.net/apps/trac/nfs-ganesha/
>>
>> In principle it would probably be pretty straightforward to wire tha=
t
>> up
>> to libceph and avoid the kernel NFS server for reexporting ceph via
>> NFS...
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
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
