From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [ceph-commit] File System Security Labeling and Extended Attributes
Date: Wed, 22 Dec 2010 20:21:27 -0800
Message-ID: <AANLkTikvf88Xyjki0c2BZYfLd+p4AsGD7SuEjn=6rk5j@mail.gmail.com>
References: <28F38CD608CAC34EB06B28AD2046A57D95789028@HVXMSP2.us.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61184 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0LWEV3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Dec 2010 23:21:29 -0500
Received: by ewy5 with SMTP id 5so2942457ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Dec 2010 20:21:28 -0800 (PST)
In-Reply-To: <28F38CD608CAC34EB06B28AD2046A57D95789028@HVXMSP2.us.lmco.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Franklin, Armelle S" <armelle.s.franklin@lmco.com>
Cc: ceph-devel@vger.kernel.org

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
