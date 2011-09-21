From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Re: Using RADOS
Date: Wed, 21 Sep 2011 15:14:43 +0530
Message-ID: <CAMiHsJJ6T=MbE2vBa0X+UKeDv1CKQfdVaU95PwQ5oH5wgCGRzQ@mail.gmail.com>
References: <CAMiHsJ+XqtaBJVAzf3NBPTp3Con-5R0tneyadKB9Nvb9wvWJVQ@mail.gmail.com>
 <1316508609.2671.4.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48357 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab1IUJpE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2011 05:45:04 -0400
Received: by bkbzt4 with SMTP id zt4so1278515bkb.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2011 02:45:03 -0700 (PDT)
In-Reply-To: <1316508609.2671.4.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 20, 2011 at 2:20 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
> Hi,
>
> On Tue, 2011-09-20 at 13:14 +0530, Atish Kathpal wrote:
> > Hello friends
> >
> > Since there is no Ceph User's mailing list, I am posting my doubt h=
ere.
> >
> > I want to use the Ceph object store capabilities. I have already
> > installed and setup a Ceph cluster.
> >
> > As a first step, I want to be able to GET/PUT or read/write to the
> > object store of my cluster. I would prefer a HTTP/REST interface bu=
t
> > please let me know of other interfaces that exist for performing
> > read/writes to ceph object store/RADOS.
>
> You mean the radosgw? See: http://ceph.newdream.net/wiki/RADOS_Gatewa=
y
>
> That should give you a nice HTTP interface to your RADOS objects. Alm=
ost
> fully S3 compatible.
>
> There is also a command-line tool "rados" which you could use, but yo=
u
> can also write something against librados (C/C++).
>

I tried using rados. But it does not seem to work.

atish@atish-virtual-machine:/etc/ceph$ rados ls
2011-09-21 15:13:32.030505 b7795b50 monclient(hunting):
MonClient::init(): Failed to create keyring

Any fixes?

Thanks
Atish



> >
> > Final goal: Besides normal read/writes, I also want to be able to h=
ave
> > some objects, which point to no data. That is, I want to have a
> > special flag, which if set, would mean there is no data pointed to =
by
> > this Object ID. If its unset, it means its like a normal object
> > pointing to some data file(s). I want to have the freedom to be abl=
e
> > to set/unset this flag and hence be able to delete/re-insert the
> > corresponding data file(s) against the same object ID. Do we have a=
n
> > API which could allow me such functionality?
>
> No, RADOS is a pretty straight forward API. You have pools where you
> place objects in. Objects can have xattrs and that's about it.
>
> If you want these kinds of logic you'd have to write your own layer o=
ver
> librados.
>
> You could set xattr telling a object is empty.
>
> RADOS is pretty low-level and straight forward. There is not much log=
ic
> in it, no locking or other fancy stuff. Just store objects in pools a=
nd
> make sure they are safe.
>
> Any other logic should be done by yourself.
>
> Wido
>
> >
> > Please point me to suitable links/starting points.
> >
> > Thanks
> > Atish
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
