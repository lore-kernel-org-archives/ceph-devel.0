From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] stack size limit issues with xen + qemu + rbd
Date: Mon, 19 Sep 2016 15:50:49 -0400
Message-ID: <20160919195049.GA8397@char.us.oracle.com>
References: <CABZSBQef-UvYxD+Yg_G5mNT604pdeH5fb3_xVuautm4YfFc5Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47023 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbcISTu7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 15:50:59 -0400
Content-Disposition: inline
In-Reply-To: <CABZSBQef-UvYxD+Yg_G5mNT604pdeH5fb3_xVuautm4YfFc5Kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Patterson <cjp256@gmail.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On Fri, Sep 16, 2016 at 04:55:17PM -0400, Chris Patterson wrote:
> I have spent some time investigating a case where qemu is failing to
> register xenstore watches for a PV guest once I enable vfb (and
> thereby triggering the creation of a qemu instance).
> 
> The qemu logs show something along the lines of:
> xen be core: xen be core: xen be: watching backend path
> (backend/console/3) failed
> xen be: watching backend path (backend/console/3) failed
> xen be core: xen be core: xen be: watching backend path (backend/vkbd/3) failed
> xen be: watching backend path (backend/vkbd/3) failed
> xen be core: xen be core: xen be: watching backend path (backend/qdisk/3) failed
> xen be: watching backend path (backend/qdisk/3) failed
> xen be core: xen be core: xen be: watching backend path (backend/qusb/3) failed
> xen be: watching backend path (backend/qusb/3) failed
> xen be core: xen be core: xen be: watching backend path (backend/vfb/3) failed
> xen be: watching backend path (backend/vfb/3) failed
> xen be core: xen be core: xen be: watching backend path (backend/qnic/3) failed
> xen be: watching backend path (backend/qnic/3) failed
> 
> I have tested qemu master, qemu-xen in the master xen tree, as well as
> a few tags all with the same issue.
> 
> I came across a similar issue reported by Juergen Gross:
> https://lists.nongnu.org/archive/html/qemu-devel/2016-07/msg03341.html
> 
> Sure enough, the thread stack size was the culprit.  I had been
> testing with qemu with the associated fix "vnc-tight: fix regression
> with libxenstore" as it is in master, so that wasn't it...
> 
> I did some basic analysis of the qemu binary and the libraries it is pulling in:
> 
> for lib in $(ldd /usr/local/bin/qemu-system-i386 | grep -o '/.* '); do
> echo "lib=$lib"; readelf -S "$lib" | grep -e tbss -e tdata -A1 ; done
> 
> The largest consumers were:
> lib=/usr/lib/x86_64-linux-gnu/librbd.so.1
>   [17] .tbss             NOBITS           000000000088fed0  0068fed0
>        0000000000001820  0000000000000000 WAT       0     0     8
> lib=/usr/lib/x86_64-linux-gnu/librados.so.2
>   [17] .tbss             NOBITS           0000000000718600  00518600
>        0000000000000aa0  0000000000000000 WAT       0     0     8
> 
> IIUC, librbd & librados are using nearly 9k of the 16k alone (I am
> assuming this thread-local storage must be consumed as part of the
> thread's stack)?
> 
> I narrowed that down to Ceph's usage of __thread in stringify() in
> src/include/stringify.h.
> 
> To make things functional, the options were either to:
> (a) disable rbd at configure time for qemu
> (b) reduce the level of thread-local storage in dependencies
> (particularly ceph's stringify)
> (c) increase the stack size specified in xenstore's xs.c


I would say c) for now and focus on b) long-term until c) can be
reverted?

> 
> Is there is any precedent/policy with regards to expected TLS and/or
> stack usage for dependencies?  Is the best course of action (b)? Or

No precendent/policy that I know of..

> perhaps reconsider the default size for (c)?
> 
> Thoughts? :)
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> https://lists.xen.org/xen-devel
