From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Can we mount cephfs in centos 5.7 ?
Date: Wed, 6 Jun 2012 13:23:27 -0400
Message-ID: <CACkq2mrgFguqCEdc=-K63C3w3i6J04E2R1NJswpYeqxeprG+BA@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D01790CEA@WHQBEMAIL1.whq.wistron>
 <CAAs1YtF5UkoG1O6yKBZq0KY4Z-MDsQ2K9VxneySpr5+JHFcA=g@mail.gmail.com>
 <CACkq2mpduy_6g=jUmXjwAHciuc+wsw41C231fpaENfmfZMp8yQ@mail.gmail.com>
 <CACkq2mrVkfGfAO4WJJA5DJ+TW-nt_1JC2M4Q6MZb8bMe_k-gCA@mail.gmail.com> <Pine.LNX.4.64.1206060924500.5397@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35140 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932097Ab2FFRXt convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jun 2012 13:23:49 -0400
Received: by lahd3 with SMTP id d3so4838293lah.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 10:23:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206060924500.5397@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, sam.zaydel@inktank.com

Thanks folks.

> * 2.6.18 is crazy-old.
Certainly.    I'm hoping I only need to work with CentOS6, then I at
least get 2.6.32.  I wouldn't try to do RBD with these kernels,
though.  I would be more likely to have an Ubuntu 12.04 node mount an
RBD and export with NFS.  But as you mention, that has it's own
issues.

> Your other options are re-exporting NFS or CIFS, or trying to use cep=
h-fuse.
ceph-fuse would only be for use with cephfs, no?  Or can ceph-fuse
interface to RBD or radosgw?

I'm probably just slightly ahead of the curve here.  I am trying to
shoehorn ceph into my scenario (exporting a single filesystem to lots
of cluster nodes) without using cephfs since it's not quite ready.
Even though I lose parallel file access when using NFS (all traffic
would go through that one NFS node), I was hoping that mounting an
RBD, formatting it, and exporting it with NFS would avoid the ESTALE
issues (as opposed to using cephfs, mounting via ceph-fuse, and then
exporting _that_ with NFS).

I actually have a phone call with inktank tomorrow.  I'll ask some
more questions then.

 - Travis

On Wed, Jun 6, 2012 at 12:27 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 6 Jun 2012, Travis Rhoden wrote:
>> Sorry for the re-post.=A0 First attempt got eaten by the mailing lis=
t
>> because it wasn't plain text.=A0 My first attempt!
>>
>> > With CephFS not quite ready for production, what would be the
>> > recommended way for sharing Ceph to older operating systems?
>> > Specifically, I want to share a file system (i.e. mount a common
>> > directory) on several CentOS5 and CentOS6 nodes.=A0 I don't think =
I can
>> > mount an RBD from more than one node, so what is my best bet?
>> >
>> > Mount an RBD on a file "head" and export it via NFS?
>> >
>> > I feel like that is the only sane choice, but wanted to ask in cas=
e I
>> > am missing something better.
>
> Two things:
>
> * 2.6.18 is crazy-old. =A0It's possible the libceph and rbd bits coul=
d be
> merged in, but getting the fs to work with ancient VFS will be a worl=
d of
> pain.
>
> * NFS reexport works in basic scenarios, but should not be used in
> production as there are various conditions that can lead to ESTALE.
> Making it work is somewhere on the mid-term roadmap, but it'll be a w=
hile.
>
> Your best bet is to run cephfs on a modern kernel. =A0But be warned, =
we
> aren't ready to support the fs just yet. =A0Soon!
>
> sage
>
>
>>
>> =A0=A0- Travis
>> >
>> >
>> > On Wed, Jun 6, 2012 at 9:58 AM, Sam Zaydel <sam.zaydel@inktank.com=
> wrote:
>> >>
>> >> I think you will be able to build from source the client bits tha=
t you
>> >> need, but I saw this from an earlier similar discussion mentionin=
g
>> >> Python version, so I would make sure that python > 2.5 is used,
>> >> realistically 2.6 should be the norm today.
>> >>
>> >> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/5717
>> >>
>> >> On Tue, Jun 5, 2012 at 6:16 PM, =A0<Eric_YH_Chen@wiwynn.com> wrot=
e:
>> >> > Dear All:
>> >> >
>> >> >=FF=FF=FF=FF My ceph cluster is installed on Ubuntu 12.04 with k=
ernel 3.2.0.
>> >> >
>> >> >=FF=FF=FF=FF =A0=A0But I have a situation that I may need to mou=
nt cephfs on centos 5.7, which with kernel 2.6.18.
>> >> >
>> >> > =A0 =A0(that is to say , I only need to execute mount.ceph on t=
he centos 5.7, not the whole ceph system)
>> >> >
>> >> > =A0 =A0I want to find a solution that can provide reliable and =
high availability share file system.
>> >> >
>> >> > =A0 =A0Is it possible to do this? Or any other recommend way? =A0=
Ex: =A0export NFS=FF=FF
>> >> >
>> >> > =A0 =A0Thanks!
>> >> >
>> >> >
>> >> > --
>> >> > To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>> >> > the body of a message to majordomo@vger.kernel.org
>> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>> >>
>> >>
>> >>
>> >> --
>> >> Inked by Sam Zaydel
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
