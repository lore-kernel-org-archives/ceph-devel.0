From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: OSD rebind connects to ports of other OSDs
Date: Tue, 20 Dec 2016 17:06:38 +0200
Message-ID: <20161220150636.GA1510@gmail.com>
References: <2b061067-e839-054e-5166-619deecfae5e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35219 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935856AbcLTPGq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 10:06:46 -0500
Received: by mail-lf0-f46.google.com with SMTP id b14so77934960lfg.2
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 07:06:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2b061067-e839-054e-5166-619deecfae5e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is due to SO_REUSEADDR (not SO_REUSEPORT) socket option set. You
should have mentioned that you were talking about FreeBSD.

Note, although osd-0 and osd-1 processes are bound to the same port,
they have different addresses: wildcard (*) for osd-1, and 127.0.0.1
for rebound osd-0. On FreeBSD if SO_REUSEADDR is set, it fails to bind
only when both address and port are the same, and wildcard is
considered as a different address here. On Linux bind fails in such
case.

See, for example this for more details:

http://stackoverflow.com/questions/14388706/socket-options-so-reuseaddr-and-so-reuseport-how-do-they-differ-do-they-mean-t

The question is though why it rebinds to 127.0.0.1, and not to '*'? I
suppose this is wrong. How does it behave on Linux?

On Tue, Dec 20, 2016 at 11:21:19AM +0100, Willem Jan Withagen wrote:
> Hi,
> 
> I've been banging my head against the wall for some time now.
> But rebinding OSD.0 (in cephtool-test-mon.sh) does not quite work.
> 
> When rebinding it connects to the ports of OSD.1 because those ports are
> the first not in the avoid_list. That should be refused since these
> sockets belong to a different process.
> UNLESS SO_REUSEPORT is set:
>  SO_REUSEPORT allows completely duplicate bindings by multiple processes
>  if they all set SO_REUSEPORT before binding the port.  This option
>  permits multiple instances of a program to each receive UDP/IP
>  multicast or broadcast datagrams destined for the bound port.
> 
> Which seems that that happens.
> Output from sockstat in this state:
> wjw      ceph-osd-0   43305 14 tcp4   *:6800                *:*
> wjw      ceph-osd-0   43305 15 tcp4   127.0.0.1:6804        *:*
> wjw      ceph-osd-0   43305 16 tcp4   127.0.0.1:6805        *:*
> wjw      ceph-osd-0   43305 45 tcp4   127.0.0.1:6806        *:*
> wjw      ceph-osd-1   43318 14 tcp4   *:6804                *:*
> wjw      ceph-osd-1   43318 15 tcp4   *:6805                *:*
> wjw      ceph-osd-1   43318 16 tcp4   *:6806                *:*
> wjw      ceph-osd-1   43318 17 tcp4   *:6807                *:*
> 
> Which clearly demonstrates the mess.
> How ever that option is nowhere set in the ceph-code, neither is it a
> setting that "just" gets set.
> 
> Any suggestions where to look for this option to get set in an
> incidental/bug way would be much appreciated.
> Or a suggestion on how to easily debug this.
> 
> Thanx,
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
