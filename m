From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: nfsv41 over AF_VSOCK (nfs-ganesha)
Date: Fri, 23 Oct 2015 14:05:43 -0400 (EDT)
Message-ID: <818466867.37565630.1445623543801.JavaMail.zimbra@redhat.com>
References: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com> <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com> <CALe9h7cGzjgBO=K-p7PF=MQViawh8ZKd6u_u4E5A_JSf5zhMVg@mail.gmail.com> <CALe9h7fTUKJkxTxX4wKYwvJMOUXRneR+jB49p9M1Ji3-DVGuhw@mail.gmail.com> <CAL-2WbGd0t4zxx7nb6CtSGFpL6CznStk0isZZ=BuGdyjxyF1hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:56781 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbbJWSFo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 14:05:44 -0400
In-Reply-To: <CAL-2WbGd0t4zxx7nb6CtSGFpL6CznStk0isZZ=BuGdyjxyF1hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Gryniewicz <dang@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Stefan Hajnoczi <shajnocz@redhat.com>

For hacking around, put  "Graceless = true;" in the NFSV4 block.

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309

----- Original Message -----
> From: "Daniel Gryniewicz" <dang@redhat.com>
> To: "John Spray" <jspray@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Stefan Hajnoczi" <shajnocz@redhat.com>
> Sent: Friday, October 23, 2015 12:34:42 PM
> Subject: Re: nfsv41 over AF_VSOCK (nfs-ganesha)
> 
> On Fri, Oct 23, 2015 at 9:27 AM, John Spray <jspray@redhat.com> wrote:
> >  * NFS writes from the guest are lagging for like a minute before
> > completing, my hunch is that this is something in the NFS client
> > recovery stuff (in ganesha) that's not coping with vsock, the
> > operations seem to complete at the point where the server declares
> > itself "NOT IN GRACE".
> 
> 
> Ganesha always starts in Grace, and will not process new clients until
> it exits Grace.  Existing clients should re-connect fine, and new
> clients work fine after Grace is exited.
> 
> Dan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
