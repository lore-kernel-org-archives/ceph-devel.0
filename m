From: John Spray <john.spray@redhat.com>
Subject: Re: [ceph-users] the state of cephfs in giant
Date: Thu, 30 Oct 2014 14:36:57 +0000
Message-ID: <CAGd4Wr0kJCwT4u6L8uMnbPCmrCxwyW33FOrOKKBqpRe+nyPgng@mail.gmail.com>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
	<CAPUexz_+jD7RMNSZEgy3h6WqKS4PSMj1fbyRgLKxQWHvctviNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:38902 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759946AbaJ3Og7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 10:36:59 -0400
Received: by mail-lb0-f176.google.com with SMTP id z11so2387179lbi.7
        for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 07:36:58 -0700 (PDT)
In-Reply-To: <CAPUexz_+jD7RMNSZEgy3h6WqKS4PSMj1fbyRgLKxQWHvctviNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Thu, Oct 30, 2014 at 10:55 AM, Florian Haas <florian@hastexo.com> wr=
ote:
>> * ganesha NFS integration: implemented, no test coverage.
>
> I understood from a conversation I had with John in London that
> flock() and fcntl() support had recently been added to ceph-fuse, can
> this be expected to Just Work=E2=84=A2 in Ganesha as well?

To clarify this comment: flock in ceph-fuse was recently implemented
(by Yan Zheng) in *master* rather than giant, so it's in line for
hammer.

Cheers,
John
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
