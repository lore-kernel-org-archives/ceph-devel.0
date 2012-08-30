From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Ceph + RBD + Xen: Complete collapse -> Network issue in domU /
 Bad data for OSD / OOM Kill
Date: Thu, 30 Aug 2012 16:38:08 +0200
Message-ID: <CAF6-1L694Ug2OcUer=PLczNJpsKhDrwpsjW+Mk-_4y+r+pwagQ@mail.gmail.com>
References: <CAF6-1L5t9CGk_kB08UPKdrOhQeZZXdbr5n+we1Oae+STpodxtg@mail.gmail.com>
	<503F7543.6090309@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40399 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab2H3OiJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 10:38:09 -0400
Received: by vcbfk26 with SMTP id fk26so1979732vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 07:38:09 -0700 (PDT)
In-Reply-To: <503F7543.6090309@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: xen-users@lists.xen.org, ceph-devel@vger.kernel.org

Hi,


> I would suggest trying kvm instead of xen...

There is a lot of different setup that might work, I'm not looking for
a different setup, I want to fix this one.
We already have a complete running infra using Xen and using an iscsi
NAS as backend for the VM image and Lustre as distributed FS and I
want to replace all that and use ceph instead.


>      "net eth0: rx->offset: 0, size: 4294967295"
>
> Seems that there is something wrong with networking code in xen?

The problem doesn't appear with Ceph on its own or Xen on its own, so
it's a weird interaction between them and it could very well be that
the network code of ceph does something unexpected triggering this
behavior in xen. At this point I wouldn't exclude anything ...

Also even if the root fault lies with Xen, I think that the running
away memory issue triggered inside the OSD by this is worth fixing on
its own. A badly behaving client shouldn't be able to DoS the OSD so
easily.


Cheers,

    Sylvain
