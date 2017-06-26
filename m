From: John Spray <jspray@redhat.com>
Subject: Remote execution in ceph-medic
Date: Mon, 26 Jun 2017 16:52:44 +0100
Message-ID: <CALe9h7f7TtnFmc68xr2ayjEA8vyvnN7FPUoys=ea4HW_5JOKXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38172 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdFZPxH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jun 2017 11:53:07 -0400
Received: by mail-wm0-f53.google.com with SMTP id b184so1616074wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jun 2017 08:53:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Andrew Schoen <aschoen@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi guys,

I was pondering this and wondered if you had any existing plans...

For doing network testing between two remote nodes, we'll need to be
able to spin up some sort of listener on one end, presumably via SSH
from a third party node.

I guess the choice here is whether to depend on having ceph-medic
already installed on all the nodes (and invoke it with a special
--receiver type argument) or whether the tool should inject its code
over SSH (e.g. run a big fat python command line with a script in it
over SSH).

I lean towards the latter in the interests of making the deployment
simple, but I'm not sure what the story is with e.g. selinux in
situations like this, whether a server is going to get unhappy about
an SSH session that tries to open ports.

John
