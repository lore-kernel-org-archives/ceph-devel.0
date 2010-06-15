From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: setup ceph cluster failed
Date: Tue, 15 Jun 2010 14:19:14 -0700
Message-ID: <AANLkTikUSPzXJ2rWJp1oBaJbGfz2NW_gJalhIA2eNrIz@mail.gmail.com>
References: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
	<AANLkTikuhGLl59papaPJPvfN584gPi-B10xiXIZNrS-O@mail.gmail.com>
	<AANLkTimknLJUt0GetPjwA7ZV9t_DWb1btOFMtd8XXY80@mail.gmail.com>
	<AANLkTik8gRPzwBzzI8rJGp2b-o6dpoFzRcGJZORC81sY@mail.gmail.com>
	<AANLkTinreVMIcxZAUuKWDjYbh2cvLi025d0QWYD8SSJs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37300 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758471Ab0FOVTP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jun 2010 17:19:15 -0400
Received: by vws13 with SMTP id 13so1740591vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jun 2010 14:19:15 -0700 (PDT)
In-Reply-To: <AANLkTinreVMIcxZAUuKWDjYbh2cvLi025d0QWYD8SSJs@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Min Zhou <coderplay@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 15, 2010 at 1:54 PM, Min Zhou <coderplay@gmail.com> wrote:
>
>
> Still two questions:
> 1. Why it prompted the need of all osd's root passwords?
You specified --allhosts in the mkcephfs script command line. The
script uses ssh to run commands on the remote hosts, so you'd probably
need to setup your environment so that it doesn't prompt for password
when you login there (e.g., one way to do it is to create a
private/public keys pair, put the copy of your public key in the
remote host under ~/.ssh/authorized_keys).

> 2. Why it still has warning that tell me no keyring specified for each osd.

Probably because there wasn't any keyring specified in your ceph.conf.
As you don't setup your ceph cluster with authentication it doesn't
really matter.

Yehuda
