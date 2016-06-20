From: Sage Weil <sage@newdream.net>
Subject: Re: determining client and server on a connection
Date: Mon, 20 Jun 2016 12:21:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606201219360.21827@piezo.us.to>
References: <1466421669.4297.13.camel@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from batalion.com ([64.111.99.127]:55138 "EHLO localhost.localdomain"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751792AbcFTM3h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jun 2016 08:29:37 -0400
In-Reply-To: <1466421669.4297.13.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 20 Jun 2016, Jeff Layton wrote:
> Hi! I'm just getting started working with ceph, and decided to tackle
> fixing up the wireshark dissector which isn't working properly when you
> use the kernel's fs client.
> 
> This page says that the server always sends its banner first:
> 
>     http://docs.ceph.com/docs/master/dev/network-protocol/?highlight=protocol
> 
> ...but that's not true with the Linux kernel client. The client and
> server send their banners and addresses concurrently, and the client
> often gets there first. The wireshark dissector relies on the server
> sending its banner first however, so it quickly mixes the two up and
> things go south from there.
> 
> Given the way the protocol works, the only way I can see to reliably
> determine client and server is to read enough bytes to get to the
> client's address when the server sends it, and see whether it matches
> the receiver's address/port.

I'm not sure I follow.  The client is the one initiating the connection 
and the server is the one accepting.  Does wireshark not let you tell 
that?

The addrs are exchanged so that each end can learn what their 
effective address is, but this is a bit of a hack and not really 
ideal--hoping to reduce our reliance on this (or drop it entirely) 
with msgr2.

> Is there a simpler way to do this that I'm missing?
> 
> Also, it looks like this shouldn't be a problem for the msgr2 protocol
> since the initial exchange doesn't involve sending addresses. Is that
> the case?

It's true that it doesn't include the addr exchange.  It doesn't have any 
other explicit indication in the data flow that tells you who is the 
client vs server, though, either...

sage

