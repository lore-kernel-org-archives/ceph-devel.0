From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Could rados pool support tree view feature ?
Date: Mon, 19 Dec 2011 09:16:59 -0800
Message-ID: <CAORUGqD5yJyzDNmVRa5jaj54hF-JJU1UCqyNw5OAAhE4hHK8pQ@mail.gmail.com>
References: <1324277505.4089.26.camel@cephclient0>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33631 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab1LSRRV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 12:17:21 -0500
Received: by wgbdr13 with SMTP id dr13so11065872wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 09:17:20 -0800 (PST)
In-Reply-To: <1324277505.4089.26.camel@cephclient0>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Dec 18, 2011 at 22:51, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> Could rados pool support tree view feature ?for instance :
>
> $rados lspools -m 172.16.10.10
> data
> metadata
> rbd
> Product:00000001
> =E2=94=9C=E2=94=80=E2=94=80 00011
> =E2=94=82 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 00012
> | =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=94=94=E2=94=80=E2=94=80 00013

What type are the 00011 and 00012 entries? Are they pools or objects,
or what? RADOS pools are flat namespaces of objects, there's no tree
structure there.

You should be able to write that easily, for example less than 100
lines of Python using the "rados" module gets you the listing of the
pools and the objects in them, and then you can use whatever your
custom logic is for creating that tree shape.

The Ceph team pretty much starts with the assumption that your pools
are going to have at least millions of objects, so it's unlikely we'll
write pretty visual navigation apps listing individual objects. The
output would just be too long to be useful.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
