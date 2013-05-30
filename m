From: Noah Watkins <noah.watkins@inktank.com>
Subject: Fwd: Java bindings for RADOS and RBD
Date: Thu, 30 May 2013 13:01:01 -0700
Message-ID: <CA+Hcz5_ZcdbNAXTvOA86L=3_GeLSStnPyeO0f1pVyZ=eVTAGEw@mail.gmail.com>
References: <5187CA7E.2050508@42on.com>
	<CA+Hcz5_6Z2fwHmkKSMOPugh8B5Osu=m7FM1eQkVmvwrn1E4TZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:61180 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030Ab3E3UBD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 16:01:03 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg9so13155bkc.34
        for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 13:01:01 -0700 (PDT)
In-Reply-To: <CA+Hcz5_6Z2fwHmkKSMOPugh8B5Osu=m7FM1eQkVmvwrn1E4TZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Wido den Hollander <wido@42on.com>

Resending. HTML+vger issue.

---------- Forwarded message ----------
From: Noah Watkins <noah.watkins@inktank.com>
Date: Thu, May 30, 2013 at 12:59 PM
Subject: Re: Java bindings for RADOS and RBD
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On Mon, May 6, 2013 at 8:21 AM, Wido den Hollander <wido@42on.com> wrote:
>
>
> The reason to use JNA is that it allows us to simply drop the bindings and run them without having them compiled against the librados or librbd headers.


Nice. The JNA stuff is very easy to use. We originally looked at it
for the CephFS bindings, but there was some concern about dependencies
and licensing w.r.t. Hadoop.

>
> I've chosen to implement both RADOS and RBD into the same package and using com.ceph.rados and com.ceph.rbd for as the package name. It could be splitted into different projects, but I think that won't benefit anybody. Having it all in one package seem easy, since RBD needs a RADOS IoCTX to work anyway.


Cool. We have the com.ceph.fs and com.ceph.crush namespaces right now.

>
> I'd like to get some feedback on the bindings about the way they are now. They are still work-in-progress, but my Unit Testing shows me they are in a reasonable shape already.


They look like a really good start. Here is some feedback in no
particular order.

1. Enforcing rados usage assumptions

Unlike with the C interface where users are expected to behave, we
want to avoid ever crashing the JVM. So, stuff like "what happens if I
create an IoCTX, then destroy the Rados object and use the IoCTX?"
comes to mind. I think this would correspond to the GC running
finalize on an out of scope Rados object.

2. Making IoCTX safer to use

I've used the library now to bring the IoCTX into a completely
separate RADOS project. Designing for that to be common would be
great. For instance, that may be _very_ common for users of
IoCTX.Exec() since they will have completely distinct libraries.

A first step might be to expose a constant/read-only pointer. I'm not
a JNA expert, but after reading a bit, it seems as though we can
subclass IoCTX from Structure or maybe PointerType to make IoCTX
behave.

3. Async

Getting one or two async wrappers put it in the library might help
reveal any challenges early on, even if the API coverage expands
slowly.


> Getting them into Maven Central [2] won't be that easy, so I'd like to request space for that on ceph.com, for example ceph.com/download/maven and users will have to manually add that to their pom.xml configuration.


This would be really nice. I dunno what people expect from Maven
projects that rely on native libraries. At least getting debian
packages would be a good step.
