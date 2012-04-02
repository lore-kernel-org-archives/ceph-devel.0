From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: RBD attach via libvirt to kvm vm - VM kernel hang
Date: Mon, 2 Apr 2012 09:33:28 -0700
Message-ID: <CAORUGqCpGQU9VxJnCpu1WtX-jCb0hMwvCxqx0dOy6G4f5dOkCw@mail.gmail.com>
References: <CAMwB3Tj4F1H_TnYsJVDELnod5z=DKwtdGiZExiVrMaJDycKvEw@mail.gmail.com>
 <CAORUGqAWnFz5uMOH=SAXb+n=ysMF9vvgGK-fqn0gdm5eDo9woA@mail.gmail.com>
 <4F733B2A.7050902@dreamhost.com> <6656798785653552046@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63502 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab2DBQdt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Apr 2012 12:33:49 -0400
Received: by vcqp1 with SMTP id p1so1788348vcq.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Apr 2012 09:33:49 -0700 (PDT)
In-Reply-To: <6656798785653552046@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/3/28 S=C5=82awomir Skowron <szibis@gmail.com>:
> With same kernel as used now on Guest, and with this 1.0.0-rc2 kvm rb=
d
> attaching goes smooth, but after some time, when rbd was mounted in
> VM, network goes down.
> Only with console/vnc we can go into VM, and then reload network.

=46rankly, I don't see a way how the QEmu RBD driver could cause
problems for your vm networking, barring just memory corruption. I
think your setup has problems outside of RBD. Sorry. Do let us know if
you find out more.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
