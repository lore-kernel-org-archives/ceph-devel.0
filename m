From: Sage Weil <sage@newdream.net>
Subject: Re: [GSoC 2016] ON-THE-WIRE ENCRYPTION SUPPORT
Date: Fri, 11 Mar 2016 09:20:08 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603110908280.14377@cpach.fuggernut.com>
References: <CAEG8a3KgxDHU03JDccrU_h7S8GksO8hfM2tcxLak=R1tKBXfMA@mail.gmail.com> <CACJqLyYKhqGg6du8Z_HL7Lfemj_W3RMOBxE4C23khb9mKWEy+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34166 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbcCKOU3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2016 09:20:29 -0500
In-Reply-To: <CACJqLyYKhqGg6du8Z_HL7Lfemj_W3RMOBxE4C23khb9mKWEy+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: John Hunter <zhjwpku@gmail.com>, mwatts@redhat.com, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 11 Mar 2016, Haomai Wang wrote:
> On Fri, Mar 11, 2016 at 1:38 PM, John Hunter <zhjwpku@gmail.com> wrote:
> 
> > Hi sage,
> >
> > At a quick look at the ceph codebase, the cryptographic handshake is
> > handled
> > by the Pipe class(I might be wrong), it not using the openssl handshake
> > and not
> > using the openssl crypto library. I am wondering when we encrypt the actual
> > data, are we going to implement our own encrypt functions?
>
> We could define a new feature in connection handshake, init side could take
> a enanble/disable flag to make server side decided. If both side agreed
> with encrypt, the connection can encrypt each message later or we need to
> have a new encrypt  info exchange step into original handshake process.

Take a look at 

	https://github.com/ceph/ceph/blob/master/src/msg/simple/Pipe.cc

The initial exchange is a ceph_msg_connect sent from client->server, and a 
ceph_msg_connect_reply response.  The request includes the 
cephx authorizer, and by the time we get the response, both client and 
server share a session key (derived from the shared secret and a nonce) 
that we can use to encrypt.

The features aren't encrypted, so in theory at MITM could twiddle those, 
*but* they can't tamper with the cephx authorizer and response without 
breaking the security handshake.  I think this may be broken in the 
current handshake, actually, since we use the connection features to 
decide whether to sign messages.  The features probably need to go in the 
authorizer, or in something signed by the authorizer.

Anyway, both sides know that the other supports encryption, if one of 
them wants to encrypt, they can send a tag

	https://github.com/ceph/ceph/blob/master/src/include/msgr.h#L77

indicating that all further messages sent are encrypted.  A similar tag 
(or the same tag) could request that the other end do the same.
The bit I worry about here is that the other end may have already started 
sending other messages before it gets the 'please encrypt outgoing 
messages' tag.  So maybe we need to incorportate the request into the 
authorizer itself so that it's part of the initial cephx handshake..

What do you think?

sage
