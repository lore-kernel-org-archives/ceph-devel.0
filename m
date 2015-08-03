From: John Spray <jspray@redhat.com>
Subject: Re: Transitioning Ceph from Autotools to CMake
Date: Mon, 3 Aug 2015 11:09:46 +0100
Message-ID: <CALe9h7eUFQ9Ujcc6y_gPatkE=x1psdKMdSaGroav+i8XRzVSnw@mail.gmail.com>
References: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com> <1438457056.20202.29.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34206 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbbHCKKF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 06:10:05 -0400
Received: by pdbbo16 with SMTP id bo16so14751578pdb.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 03:10:05 -0700 (PDT)
In-Reply-To: <1438457056.20202.29.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Ali Maredia <amaredia@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Aug 1, 2015 at 8:24 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>
>
> 3. no vstart.sh , starting working on this too but have less progress
> here. At the moment in order to use vstart I copy the exe and libs to
> src dir.

I just started playing with CMake on Friday, adding some missing cephfs
bits.  I was going to fix (3) as well, but I don't want to duplicate work
-- do you have an existing branch at all?  Presumably this will mostly be a
case of adding appropriate prefixes to commands.

Cheers,
John
