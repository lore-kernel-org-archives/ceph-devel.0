From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Using RADOS
Date: Wed, 21 Sep 2011 16:35:28 +0200
Message-ID: <1316615728.2660.0.camel@wido-laptop>
References: <CAMiHsJ+XqtaBJVAzf3NBPTp3Con-5R0tneyadKB9Nvb9wvWJVQ@mail.gmail.com>
	 <1316508609.2671.4.camel@wido-desktop>
	 <CAMiHsJJ6T=MbE2vBa0X+UKeDv1CKQfdVaU95PwQ5oH5wgCGRzQ@mail.gmail.com>
	 <CAMiHsJKpvKXG+_ToCXUSkzNiEB4L=kXtWPKpVKNP4Yk3qnXCKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:38028 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab1IUOfb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2011 10:35:31 -0400
In-Reply-To: <CAMiHsJKpvKXG+_ToCXUSkzNiEB4L=kXtWPKpVKNP4Yk3qnXCKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Wed, 2011-09-21 at 18:30 +0530, Atish Kathpal wrote:
> I am referring to the "rados" command line tool in my question.
> 
> Regards
> Atish
> 
> On Wed, Sep 21, 2011 at 3:14 PM, Atish Kathpal <atish.kathpal@gmail.com> wrote:
> > On Tue, Sep 20, 2011 at 2:20 PM, Wido den Hollander <wido@widodh.nl> wrote:
> >>
> >> Hi,
> >>
> >> On Tue, 2011-09-20 at 13:14 +0530, Atish Kathpal wrote:
> >> > Hello friends
> >> >
> >> > Since there is no Ceph User's mailing list, I am posting my doubt here.
> >> >
> >> > I want to use the Ceph object store capabilities. I have already
> >> > installed and setup a Ceph cluster.
> >> >
> >> > As a first step, I want to be able to GET/PUT or read/write to the
> >> > object store of my cluster. I would prefer a HTTP/REST interface but
> >> > please let me know of other interfaces that exist for performing
> >> > read/writes to ceph object store/RADOS.
> >>
> >> You mean the radosgw? See: http://ceph.newdream.net/wiki/RADOS_Gateway
> >>
> >> That should give you a nice HTTP interface to your RADOS objects. Almost
> >> fully S3 compatible.
> >>
> >> There is also a command-line tool "rados" which you could use, but you
> >> can also write something against librados (C/C++).
> >>
> >
> > I tried using rados. But it does not seem to work.
> >
> > atish@atish-virtual-machine:/etc/ceph$ rados ls
> > 2011-09-21 15:13:32.030505 b7795b50 monclient(hunting):
> > MonClient::init(): Failed to create keyring

Does the user atish have read access on the ceph.conf? And does it also
have access to the keyring.bin file?

I assume you have cephx enabled?

Wido

> >
> > Any fixes?
> >
> > Thanks
> > Atish
> >
> >
> >
> >> >
> >> > Final goal: Besides normal read/writes, I also want to be able to have
> >> > some objects, which point to no data. That is, I want to have a
> >> > special flag, which if set, would mean there is no data pointed to by
> >> > this Object ID. If its unset, it means its like a normal object
> >> > pointing to some data file(s). I want to have the freedom to be able
> >> > to set/unset this flag and hence be able to delete/re-insert the
> >> > corresponding data file(s) against the same object ID. Do we have an
> >> > API which could allow me such functionality?
> >>
> >> No, RADOS is a pretty straight forward API. You have pools where you
> >> place objects in. Objects can have xattrs and that's about it.
> >>
> >> If you want these kinds of logic you'd have to write your own layer over
> >> librados.
> >>
> >> You could set xattr telling a object is empty.
> >>
> >> RADOS is pretty low-level and straight forward. There is not much logic
> >> in it, no locking or other fancy stuff. Just store objects in pools and
> >> make sure they are safe.
> >>
> >> Any other logic should be done by yourself.
> >>
> >> Wido
> >>
> >> >
> >> > Please point me to suitable links/starting points.
> >> >
> >> > Thanks
> >> > Atish
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >


