From: Tommi Virtanen <tv@inktank.com>
Subject: Re: setting up virtual machines with ceph
Date: Mon, 11 Jun 2012 10:12:21 -0700
Message-ID: <CADvuQREgrX3UR3HY2aHUj8LAxoMShP+LnPH9rH4nN3QMkkJJCw@mail.gmail.com>
References: <loom.20120607T085432-245@post.gmane.org> <CADvuQRG0GbYikc89M+X2nvDb1bhJ3trej8BW+GLN4jEHGu6dkg@mail.gmail.com>
 <loom.20120610T125057-110@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46306 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab2FKRMm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 13:12:42 -0400
Received: by pbbrp8 with SMTP id rp8so5851024pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 10:12:41 -0700 (PDT)
In-Reply-To: <loom.20120610T125057-110@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jun 10, 2012 at 3:51 AM, udit agarwal <fzdudit@gmail.com> wrote=
:
> =C2=A0Thanks for your reply. I want just virtualization on my ceph sy=
stem. I will
> explain you the exact implementation that I want in my ceph system. I=
 want to
> run 10 virtual machine instances on my ceph client whilst utilizing t=
he storage
> on the rest of the two systems. I tried to study libvirt but couldn't=
 succeed to
> help my way out to solve this problem. Please help me out with this p=
roblem..

Hi. I'd like to help but I'm not sure what trouble you are really
running into. Can you use libvirt successfully with local storage? If
not, then you probably need to find a good linux admin to help you
out. If you can get libvirt to work locally, but not with rbd, can you
ask a specific question?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
