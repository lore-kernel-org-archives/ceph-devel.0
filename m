From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: How to easily determine what version of Ceph is included in a kernel?
Date: Tue, 21 Feb 2012 17:59:49 -0800
Message-ID: <CAF3hT9Cec6d4rg1ZdBLovfcpkDQ+14OuqvZquOZ5Ee9L2_94VQ@mail.gmail.com>
References: <81C477727102DA4E9B2605AC748C495407E36DF7EF@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49311 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995Ab2BVB7t convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 20:59:49 -0500
Received: by iacb35 with SMTP id b35so9677250iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 17:59:49 -0800 (PST)
In-Reply-To: <81C477727102DA4E9B2605AC748C495407E36DF7EF@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 21, 2012 at 5:29 PM, Paul Pettigrew
<Paul.Pettigrew@mach.com.au> wrote:
> G'day all
>
> We wish to document a simple way to determine what version of ceph/rb=
d is included with a given kernel on a Client machine, i.e. not the Cep=
h Cluster nodes themselves (which we are running v0.42 on). "modinfo ce=
ph" (per below) gives a "srcversion" value, but I do not know how to co=
rrelate that value to an equivalent v0.40, v0.41, etc version tag value=
=2E
>
> Ideas?

There isn't a precise correlation between kernelspace and userspace
packages =97=A0the kernel stuff is entirely upstream, and is versioned =
by
the kernel. If you're doing bug reports the kernel version is the
correct version to report. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
