From: Sage Weil <sage@newdream.net>
Subject: Re: about clientreplay with lots of clients
Date: Thu, 14 Jul 2011 09:16:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107140913030.29636@cobra.newdream.net>
References: <CAKbx_ij_vMEfz88UQXHUa5Kyp83ZRG0pjswm-6YL4q4XZU16FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33430 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab1GNQNE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 12:13:04 -0400
In-Reply-To: <CAKbx_ij_vMEfz88UQXHUa5Kyp83ZRG0pjswm-6YL4q4XZU16FQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: na an <luckyfirea@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 14 Jul 2011, na an wrote:
> hi all:
> 
>       when MDS is to restart , it will replay journal, and client will
> replay 'unsafe requests' that have replyed from that MDS while the
> metadata change maybe have not been writen to disk actually.
>       I have a question that if there are many clients, how ceph keeps
> consistence? because multiple clients may operate on the same file,
> just like one to create a file and another to delete it.
>       And how the ceph deal with such a situation that one or more
> clients fail in the process of clientsreplay ? once it happen, the
> whole system may be untrusty.
>       if we have hundreds and thousands of clients , does it may take
> a long time to recover?

The MDS locking operates such that no side-effect of one client's actions 
are exposed to any other client until they have committed to the journal. 
That means you won't have dependent operations being replayed by the 
clients (unless they also committed on the MDS and the client just didn't 
know that yet, in which case the replay is a no-op).

There is currently an annoyance with the clientreplay that forces a log 
flush on each operation due to a subtle interaction with the locking/caps 
code, but it's fixable.  See #90.

sage
