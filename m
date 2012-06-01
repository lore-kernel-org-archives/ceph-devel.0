From: Sam Just <sam.just@inktank.com>
Subject: Re: RBD operations, pinging client that serves lingering tid
Date: Thu, 31 May 2012 19:10:13 -0700
Message-ID: <CA+4uBUbTcdA=L2iBU-1TPR_fsOrySjaAZ=bGmwQFyeHGvfygPw@mail.gmail.com>
References: <1909768.2JBkbXqQse@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45698 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751Ab2FACKO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 22:10:14 -0400
Received: by dady13 with SMTP id y13so2098871dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 19:10:13 -0700 (PDT)
In-Reply-To: <1909768.2JBkbXqQse@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Those messages are harmless.  It's just debug output indicating that
the objecter is maintaining a watch on an rbd image header.  I'll tone
down the debug verbosity tomorrow.
-Sam

On Wed, May 30, 2012 at 6:54 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Hi,
>
> Whenever I'm doing any operations on rbd volumes (like import, copy) =
using the
> rbd command line client, I'm getting these messages every couple of s=
econds:
>
> 2012-05-30 15:53:08.010326 7f027aa47700 =A00 client.4159.objecter =A0=
pinging osd
> that serves lingering tid 1 (osd.2)
> 2012-05-30 15:53:08.010344 7f027aa47700 =A00 client.4159.objecter =A0=
pinging osd
> that serves lingering tid 2 (osd.0)
>
> What does this mean? Is that anything to worry about?
>
> Yesterday, these messages were only mentioning osd.2, not osd.0...
>
> =A0 =A0 =A0 =A0Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
