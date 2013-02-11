From: Sage Weil <sage@inktank.com>
Subject: Re: Client can't reboot when rbd volume is mounted.
Date: Mon, 11 Feb 2013 05:52:57 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302110550530.5429@cobra.newdream.net>
References: <511880D8.1000306@gmail.com> <alpine.DEB.2.00.1302102133260.5429@cobra.newdream.net> <5118E2EA.2050407@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35408 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab3BKNw5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 08:52:57 -0500
In-Reply-To: <5118E2EA.2050407@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 11 Feb 2013, Roman Alekseev wrote:
> On 11.02.2013 09:36, Sage Weil wrote:
> > On Mon, 11 Feb 2013, Roman Alekseev wrote:
> > > Hi,
> > > 
> > > When I try to reboot a client server  without unmounting of rbd volume
> > > manually
> > > its services stop working but server doesn't reboot completely and show
> > > the
> > > following logs in KVM console:
> > > 
> > > [235618.0202207] libceph: connect 192.168.0.19:6789 error -101
> > That is
> > 
> > #define        ENETUNREACH     101     /* Network is unreachable */
> > 
> > Note that that (or any other) socket error is not necessarily fatal; the
> > kernel client will retry and eventually connect to that or another OSD
> > to complete the IO.  Are you observing that the RBD image hangs or
> > something?
> > 
> > You can peek at in-flight IO (and other state) with
> > 
> >   cat /sys/kernel/debug/ceph/*/osdc
> > 
> > unmount/unmap should not be necessarily in any case unless there is a bug.
> > We backported a bunch of stuff to 3.6.6, so 3.6.10 ought to be okay.  You
> > might try a newer 3.6.x kernel too; I forget if there was a second batch
> > of fixes..
> > 
> > sage
> 
> Hi Sage,
> 
> > #define ENETUNREACH 101 /* Network is unreachable */
> 
> The reason of this error is that networking stop working after performing
> server reset request.
> 
> > Are you observing that the RBD image hangs or something?
> 
> the RBD works properly. It is just mapped and mounted on the client server.
> 
> # /dev/rbd1              99G  616M   93G   1% /home/test

I think I'm confused about what you mean by 'server'.  Do you mean the 
host that rbd is mapped on, or the host(s) where the ceph-osd's are 
running?

By 'the RBD works properly' do you mean the client where it is mapped?  In 
which case, what exactly is the problem?

> The "/sys/kernel/debug" folder is empty, how to put 'ceph/*/osdc' content into
> it?

'mount -t debugfs none /sys/kernel/debug' and it will appear (along with 
other fun stuff)...

sage


> 
> I've update kernel to 3.7.4 version but problem is still persist.
> 
> Thanks
> 
> -- 
> Kind regards,
> 
> R. Alekseev
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
