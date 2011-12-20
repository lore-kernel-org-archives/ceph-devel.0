From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Could rados pool support tree view feature ?
Date: Tue, 20 Dec 2011 09:47:58 +0800
Message-ID: <1324345678.4089.35.camel@cephclient0>
References: <1324277505.4089.26.camel@cephclient0>
	 <CAORUGqD5yJyzDNmVRa5jaj54hF-JJU1UCqyNw5OAAhE4hHK8pQ@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:19700 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753039Ab1LTBsF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 20:48:05 -0500
In-Reply-To: <CAORUGqD5yJyzDNmVRa5jaj54hF-JJU1UCqyNw5OAAhE4hHK8pQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi ,Tommi
Thank you very much.

00011 and 00012 are sub-pools ,we want to map our iaas devices topology
view meta data to these these sub-pools as a reference model.=20

On Tue, 2011-12-20 at 01:16 +0800, Tommi Virtanen wrote:
> On Sun, Dec 18, 2011 at 22:51, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > Could rados pool support tree view feature ?for instance :
> >
> > $rados lspools -m 172.16.10.10
> > data
> > metadata
> > rbd
> > Product:00000001
> > =E2=94=9C=E2=94=80=E2=94=80 00011
> > =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 00012
> > |        =E2=94=94=E2=94=80=E2=94=80 00013
>=20
> What type are the 00011 and 00012 entries? Are they pools or objects,
> or what? RADOS pools are flat namespaces of objects, there's no tree
> structure there.
>=20
> You should be able to write that easily, for example less than 100
> lines of Python using the "rados" module gets you the listing of the
> pools and the objects in them, and then you can use whatever your
> custom logic is for creating that tree shape.
>=20
> The Ceph team pretty much starts with the assumption that your pools
> are going to have at least millions of objects, so it's unlikely we'l=
l
> write pretty visual navigation apps listing individual objects. The
> output would just be too long to be useful.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
