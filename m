From: "Franklin, Armelle S" <armelle.s.franklin@lmco.com>
Subject: RE: EXTERNAL: Re: [ceph-commit] File System Security Labeling and Extended Attributes
Date: Thu, 23 Dec 2010 17:48:55 -0500
Message-ID: <28F38CD608CAC34EB06B28AD2046A57D958993F4@HVXMSP2.us.lmco.com>
References: <28F38CD608CAC34EB06B28AD2046A57D95789028@HVXMSP2.us.lmco.com>
 <AANLkTikvf88Xyjki0c2BZYfLd+p4AsGD7SuEjn=6rk5j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailfo01.lmco.com ([192.31.106.12]:49935 "EHLO
	mailfo01.lmco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab0LWWtF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Dec 2010 17:49:05 -0500
In-reply-to: <AANLkTikvf88Xyjki0c2BZYfLd+p4AsGD7SuEjn=6rk5j@mail.gmail.com>
Content-language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thank you so much for your answers Greg.  That is exactly what I needed=
=2E

 - Armelle

-----Original Message-----
=46rom: gfarnum@gmail.com [mailto:gfarnum@gmail.com] On Behalf Of Grego=
ry Farnum
Sent: Wednesday, December 22, 2010 11:21 PM
To: Franklin, Armelle S
Cc: ceph-devel@vger.kernel.org
Subject: EXTERNAL: Re: [ceph-commit] File System Security Labeling and =
Extended Attributes

On Wed, Dec 22, 2010 at 10:33 AM, Franklin, Armelle S
<armelle.s.franklin@lmco.com> wrote:
> My name is Armelle Franklin.=A0 I am a software engineer with the Cen=
tralized
> Supercomputer Facility.=A0 My team is writing a paper that identifies=
 the
> various current, new and upcoming technologies in the High Performanc=
e
> Computing domain for our customer.=A0 I am focused on Storage Softwar=
e (namely
> File Systems for Supercomputers).=A0 We support a Multi-Level Securit=
y
> infrastructure and would like more information about whether your pro=
duct,
> Ceph, supports the following features:
>
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0 Extended Attributes (What sort of extend=
ed attributes (file
> metadata) does the file system support/offer?)
Yes, it supports Linux xattrs. I think the limits are the same as
btrfs offers, if not they're a superset.
>
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0 POSIX Compliant???
Yep, 100% POSIX-y.
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0 Security Labeling (Can the user/administ=
rator explicitly access
> security labeling for files?)
While the answer is a little complicated, if you're asking for
specific labeling beyond what the kernel does by default (no SELinux)
the answer is basically no.
Depending on use case you can set up certain files to go into pools,
though, and it is possible to deny access on pool granularity. If
you're interested in this I suggest you take a look through the wiki.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
