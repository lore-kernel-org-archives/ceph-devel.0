From: Chris Patterson <cjp256@gmail.com>
Subject: stack size limit issues with xen + qemu + rbd
Date: Fri, 16 Sep 2016 16:55:17 -0400
Message-ID: <CABZSBQef-UvYxD+Yg_G5mNT604pdeH5fb3_xVuautm4YfFc5Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35343 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756724AbcIPUzj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2016 16:55:39 -0400
Received: by mail-vk0-f52.google.com with SMTP id b133so43358547vka.2
        for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2016 13:55:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

I have spent some time investigating a case where qemu is failing to
register xenstore watches for a PV guest once I enable vfb (and
thereby triggering the creation of a qemu instance).

The qemu logs show something along the lines of:
xen be core: xen be core: xen be: watching backend path
(backend/console/3) failed
xen be: watching backend path (backend/console/3) failed
xen be core: xen be core: xen be: watching backend path (backend/vkbd/3) failed
xen be: watching backend path (backend/vkbd/3) failed
xen be core: xen be core: xen be: watching backend path (backend/qdisk/3) failed
xen be: watching backend path (backend/qdisk/3) failed
xen be core: xen be core: xen be: watching backend path (backend/qusb/3) failed
xen be: watching backend path (backend/qusb/3) failed
xen be core: xen be core: xen be: watching backend path (backend/vfb/3) failed
xen be: watching backend path (backend/vfb/3) failed
xen be core: xen be core: xen be: watching backend path (backend/qnic/3) failed
xen be: watching backend path (backend/qnic/3) failed

I have tested qemu master, qemu-xen in the master xen tree, as well as
a few tags all with the same issue.

I came across a similar issue reported by Juergen Gross:
https://lists.nongnu.org/archive/html/qemu-devel/2016-07/msg03341.html

Sure enough, the thread stack size was the culprit.  I had been
testing with qemu with the associated fix "vnc-tight: fix regression
with libxenstore" as it is in master, so that wasn't it...

I did some basic analysis of the qemu binary and the libraries it is pulling in:

for lib in $(ldd /usr/local/bin/qemu-system-i386 | grep -o '/.* '); do
echo "lib=$lib"; readelf -S "$lib" | grep -e tbss -e tdata -A1 ; done

The largest consumers were:
lib=/usr/lib/x86_64-linux-gnu/librbd.so.1
  [17] .tbss             NOBITS           000000000088fed0  0068fed0
       0000000000001820  0000000000000000 WAT       0     0     8
lib=/usr/lib/x86_64-linux-gnu/librados.so.2
  [17] .tbss             NOBITS           0000000000718600  00518600
       0000000000000aa0  0000000000000000 WAT       0     0     8

IIUC, librbd & librados are using nearly 9k of the 16k alone (I am
assuming this thread-local storage must be consumed as part of the
thread's stack)?

I narrowed that down to Ceph's usage of __thread in stringify() in
src/include/stringify.h.

To make things functional, the options were either to:
(a) disable rbd at configure time for qemu
(b) reduce the level of thread-local storage in dependencies
(particularly ceph's stringify)
(c) increase the stack size specified in xenstore's xs.c

Is there is any precedent/policy with regards to expected TLS and/or
stack usage for dependencies?  Is the best course of action (b)? Or
perhaps reconsider the default size for (c)?

Thoughts? :)
