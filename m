From: John Spray <jspray@redhat.com>
Subject: Re: Transitioning Ceph from Autotools to CMake
Date: Tue, 4 Aug 2015 00:38:44 +0100
Message-ID: <CALe9h7fuhp5ZSinJ9URnTn+x1nF+89BHYYRZhfPv5bRxG7wQKQ@mail.gmail.com>
References: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
 <1438457056.20202.29.camel@redhat.com> <CALe9h7eUFQ9Ujcc6y_gPatkE=x1psdKMdSaGroav+i8XRzVSnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36366 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbHCXjF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 19:39:05 -0400
Received: by pacgq8 with SMTP id gq8so35475909pac.3
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 16:39:04 -0700 (PDT)
In-Reply-To: <CALe9h7eUFQ9Ujcc6y_gPatkE=x1psdKMdSaGroav+i8XRzVSnw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Ali Maredia <amaredia@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

OK, here are vstart+ceph.in changes that work well enough in my out of
tree build:
https://github.com/ceph/ceph/pull/5457

John

On Mon, Aug 3, 2015 at 11:09 AM, John Spray <jspray@redhat.com> wrote:
> On Sat, Aug 1, 2015 at 8:24 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>>
>>
>> 3. no vstart.sh , starting working on this too but have less progress
>> here. At the moment in order to use vstart I copy the exe and libs to
>> src dir.
>
> I just started playing with CMake on Friday, adding some missing cephfs
> bits.  I was going to fix (3) as well, but I don't want to duplicate work
> -- do you have an existing branch at all?  Presumably this will mostly be a
> case of adding appropriate prefixes to commands.
>
> Cheers,
> John
