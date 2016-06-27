From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: RDS - for stateless messenger
Date: Mon, 27 Jun 2016 13:20:47 -0700
Message-ID: <CAJ4mKGbKyHxvbX-d9wYCSFEeLhAL8StL2pvMafSMAgAU9D5xCA@mail.gmail.com>
References: <DB5PR05MB1607E175D8ACBE9CE2B8DC0EA9200@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35840 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbcF0UUs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 16:20:48 -0400
Received: by mail-vk0-f54.google.com with SMTP id u64so247359583vkf.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 13:20:48 -0700 (PDT)
In-Reply-To: <DB5PR05MB1607E175D8ACBE9CE2B8DC0EA9200@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Jun 26, 2016 at 10:08 AM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
> Hi All,
>
> *Background:*
> As I wrote once I am considering messenger based on RDS protocol.
> RDS protocol is datagram oriented like UDP; however, it is reliable and in-order like TCP and it is much more efficient than both (in case the underlying is RDMA).
> See about RDS here - https://oss.oracle.com/pipermail/rds-devel/2007-November/000228.html
>
> I am trying to convert AsyncMessenger to RDS.  The challenge is to convert from statefull connection to stateless connection (programmatically RDS is very much similar to UDP)
>
> *Question:*
> Async messenger starts each accepted socket with state=STATE_ACCEPTING and then it expects handshake.
> Unfortunately, stateless connections don't have the concept of "accept"; hence, I see two ways to recognize "accept" situations:
> 1. In case I am getting message from an address that doesn't exist in conns/accepting_conns collections.
> 2. By adding special message that will indicate that this is an "accept request" from a new client
>
> I prefer option #2 if it is possible - the question is which message I can use for indicating "Accept request"? - I thought of sending an empty datagram (without payload) for that purpose.  Do you think this idea will work?

Well, if you look through the connection startup in AsyncMessenger,
you should see that it makes use of several different tags and things.
And even if the underlying RDS protocol doesn't have a concept of
connections, your Messenger will need to implement one (at least, if
it's going to work anything like the AsyncMessenger does).

So, probably you just need to create a new "OPEN_CON" tag (or adjust
one of the existing ones that might be rendered obsolete by use of
RDS?) that gets sent before diving into the handshake pieces.

But if you're working on this you'll want to make sure you're also
following the discussions about a msgr2 protocol that have been
happening on the lists. That changes a few things and adds support for
new features that you'll want to be aware of.
-Greg
