From: Tommi Virtanen <tv@inktank.com>
Subject: Re: setting up virtual machines with ceph
Date: Thu, 7 Jun 2012 09:55:42 -0700
Message-ID: <CADvuQRG0GbYikc89M+X2nvDb1bhJ3trej8BW+GLN4jEHGu6dkg@mail.gmail.com>
References: <loom.20120607T085432-245@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63343 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2FGQ4D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 12:56:03 -0400
Received: by pbbrp8 with SMTP id rp8so1323257pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 09:56:02 -0700 (PDT)
In-Reply-To: <loom.20120607T085432-245@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jun 6, 2012 at 11:56 PM, udit agarwal <fzdudit@gmail.com> wrote=
:
> =C2=A0I have set up ceph system with a client, mon and mds on one sys=
tem which is
> connected to 2 osds. . The ceph setup worked fine and I did some test=
s on it and
> they too worked fine. Now, I want to set up virtual machines on my sy=
stem and
> want to run multiple virtual machine instances in parallel . But I do=
n=E2=80=99t know
> about what are the exact installation steps that are needed to be don=
e after the
> ceph installation. I guess I need to install rdb and kvm to achieve t=
he same.
> Please correct me if I am wrong.

=46irst off, you need to decide whether you want "just virtualization"
or a "private cloud". For the former, you're looking at something like
just libvirt and kvm; for the latter, OpenStack builds on top of
libvirt and provides a lot of extra functionality (at the cost of
significant complexity).

You should probably study libvirt and/or OpenStack first,
independently of Ceph. Once you are familiar with running virtual
machines on local disks, switching from that to RBD isn't all that
difficult. That said, I am not aware of us having any real
documentation on how to do it, currently :( A guide is being written
as we speak, so hopefully it'll be ready Real Soon Now(tm).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
