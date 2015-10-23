From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: nfsv41 over AF_VSOCK (nfs-ganesha)
Date: Fri, 23 Oct 2015 12:34:42 -0400
Message-ID: <CAL-2WbGd0t4zxx7nb6CtSGFpL6CznStk0isZZ=BuGdyjxyF1hw@mail.gmail.com>
References: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com>
 <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com>
 <CALe9h7cGzjgBO=K-p7PF=MQViawh8ZKd6u_u4E5A_JSf5zhMVg@mail.gmail.com> <CALe9h7fTUKJkxTxX4wKYwvJMOUXRneR+jB49p9M1Ji3-DVGuhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37974 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbJWQfD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 12:35:03 -0400
Received: by wicll6 with SMTP id ll6so39128013wic.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 09:35:02 -0700 (PDT)
In-Reply-To: <CALe9h7fTUKJkxTxX4wKYwvJMOUXRneR+jB49p9M1Ji3-DVGuhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Stefan Hajnoczi <shajnocz@redhat.com>

On Fri, Oct 23, 2015 at 9:27 AM, John Spray <jspray@redhat.com> wrote:
>  * NFS writes from the guest are lagging for like a minute before
> completing, my hunch is that this is something in the NFS client
> recovery stuff (in ganesha) that's not coping with vsock, the
> operations seem to complete at the point where the server declares
> itself "NOT IN GRACE".


Ganesha always starts in Grace, and will not process new clients until
it exits Grace.  Existing clients should re-connect fine, and new
clients work fine after Grace is exited.

Dan
