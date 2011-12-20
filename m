From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Could rados pool support tree view feature ?
Date: Tue, 20 Dec 2011 16:57:49 +0800
Message-ID: <1324371469.4089.40.camel@cephclient0>
References: <1324277505.4089.26.camel@cephclient0>
	 <CAORUGqD5yJyzDNmVRa5jaj54hF-JJU1UCqyNw5OAAhE4hHK8pQ@mail.gmail.com>
	 <1324345678.4089.35.camel@cephclient0>
	 <CAF3hT9Am_untCjpreygVd4TuUx6m=0+gb7BNXEMRD_tonPkFTg@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:60142 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752559Ab1LTI5x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 03:57:53 -0500
In-Reply-To: <CAF3hT9Am_untCjpreygVd4TuUx6m=0+gb7BNXEMRD_tonPkFTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Greg ,

Thanks!

Jeff

On Tue, 2011-12-20 at 14:38 +0800, Gregory Farnum wrote:
> Unfortunately pools are completely flat namespaces, and there's no
> hierarchical relationship between pools (well, really it's a feature,
> not something unfortunate). So any tree structure would need to be a
> completely external thing, which I guess you would probably do with
> naming conventions and some wrapper scripts.
> -Greg
>=20
> On Mon, Dec 19, 2011 at 5:47 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > Hi ,Tommi
> > Thank you very much.
> >
> > 00011 and 00012 are sub-pools ,we want to map our iaas devices topo=
logy
> > view meta data to these these sub-pools as a reference model.
> >
> > On Tue, 2011-12-20 at 01:16 +0800, Tommi Virtanen wrote:
> >> On Sun, Dec 18, 2011 at 22:51, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> >> > Could rados pool support tree view feature ?for instance :
> >> >
> >> > $rados lspools -m 172.16.10.10
> >> > data
> >> > metadata
> >> > rbd
> >> > Product:00000001
> >> > =E2=94=9C=E2=94=80=E2=94=80 00011
> >> > =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 00012
> >> > |        =E2=94=94=E2=94=80=E2=94=80 00013
> >>
> >> What type are the 00011 and 00012 entries? Are they pools or objec=
ts,
> >> or what? RADOS pools are flat namespaces of objects, there's no tr=
ee
> >> structure there.
> >>
> >> You should be able to write that easily, for example less than 100
> >> lines of Python using the "rados" module gets you the listing of t=
he
> >> pools and the objects in them, and then you can use whatever your
> >> custom logic is for creating that tree shape.
> >>
> >> The Ceph team pretty much starts with the assumption that your poo=
ls
> >> are going to have at least millions of objects, so it's unlikely w=
e'll
> >> write pretty visual navigation apps listing individual objects. Th=
e
> >> output would just be too long to be useful.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
