From: Sage Weil <sage@newdream.net>
Subject: [IANA #821110] Application for a Port Number and/or Service Name
 "ceph" (fwd)
Date: Wed, 29 Apr 2015 10:02:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504290959540.24030@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-920729992-1430326979=:24030"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59879 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbbD2RDA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 13:03:00 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B89F98021C
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2015 10:02:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 884348021C
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2015 10:02:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-920729992-1430326979=:24030
Content-Type: TEXT/PLAIN; charset=US-ASCII

So, I picked 6789 way back in commit 
dc38de9b14c5386f9f446124ca6d6673eb8a1e20 because it was unused according 
to nmap-services.  It's there now, in use by smc-https (whatever that is), 
and says it was registered in 2002.  I guess the nmap-services file I 
looked at at the time was out of date?

In any case, if we want an IANA assigned number, we'll need to change it.  

We should be able to make a transition reasonably painless by making 
clients try both ports when none is specified for some period.

I'm assuming it's worth the effort... what do you think?

sage

--557981400-920729992-1430326979=:24030
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1504290959541.24030@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <iana-shared@icann.org>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 491E38021C
	for <sage@cobra.newdream.net>; Wed, 29 Apr 2015 08:54:31 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 15F1B1209D9; Wed, 29 Apr 2015 08:54:31 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from diehard.dreamhost.com (caiajhbdcbfh.dreamhost.com
	[208.97.132.157])
	by destro.newdream.net (Postfix) with ESMTP id 1193C1209C8
	for <sage@newdream.net>; Wed, 29 Apr 2015 08:54:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by diehard.dreamhost.com (Postfix) with ESMTP id 0CA5717BE005
	for <sage@newdream.net>; Wed, 29 Apr 2015 08:54:31 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at diehard.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0.905
X-Spam-Level: 
X-Spam-Status: No, score=0.905 tagged_above=-999 required=999
	tests=[MISSING_HEADERS=0.915, T_RP_MATCHES_RCVD=-0.01]
	autolearn=disabled
Received: from terminator.dreamhost.com ([208.97.132.17])
	by localhost (diehard.dreamhost.com [208.97.132.157]) (amavisd-new,
	port 10024) with ESMTP id rOdgMMnh7U1B for <sage@newdream.net>;
	Wed, 29 Apr 2015 08:54:30 -0700 (PDT)
Received: from smtp1.lax.icann.org (smtp01.icann.org [192.0.33.81])
	by terminator.dreamhost.com (Postfix) with ESMTP id A0F202930011
	for <sage@newdream.net>; Wed, 29 Apr 2015 08:54:30 -0700 (PDT)
Received: from request3.lax.icann.org (request1.lax.icann.org [10.32.11.221])
	by smtp1.lax.icann.org (8.13.8/8.13.8) with ESMTP id t3TFsUXA017813
	for <sage@newdream.net>; Wed, 29 Apr 2015 15:54:30 GMT
Received: by request3.lax.icann.org (Postfix, from userid 48)
	id 60565C205B8; Wed, 29 Apr 2015 15:54:30 +0000 (UTC)
RT-Owner: pearl.liang
Subject: [IANA #821110] Application for a Port Number and/or Service Name
	"ceph"
From: "Pearl Liang via RT" <iana-ports@iana.org>
Reply-To: iana-ports@iana.org
In-Reply-To: <201504272158.t3RLwdEE026988@smtp1.lax.icann.org>
References: <RT-Ticket-821110@icann.org>
	<201504272158.t3RLwdEE026988@smtp1.lax.icann.org>
Message-ID: <rt-4.2.9-5772-1430322870-91.821110-7-0@icann.org>
X-RT-Loop-Prevention: IANA
X-RT-Ticket: IANA #821110
X-Managed-BY: RT 4.2.9 (http://www.bestpractical.com/rt/)
X-RT-Originator: pearl.liang@icann.org
CC: sage@newdream.net
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Precedence: bulk
Date: Wed, 29 Apr 2015 15:54:30 +0000
MIME-Version: 1.0
X-Spambayes-Classification: ham; 0.00
Content-Transfer-Encoding: quoted-printable


Dear Sage Weil:

Thank you for submitting this application.    We have one question regard=
ing
the proposed port number:

Desired Port Number: [6789]

You explained that you've been using the number for years:

8. Please explain the state of development of your protocol.
[The protocol was initially developed in the 2008-2010 timeframe and has =
been deployed in production systems for the last 3-4 years. The existing =
protocol versioning and other features have proven effective to handle al=
l of the protocol and system changes we have dealt with over that period.=
]

This port number has already been assigned to other service, so you need
to pick another number.  As noted in the online template form, unassigned=
=20
service names and port numbers should not be used prior to assignment.=20

When we receive your reply, we can continue the processing of the request=
.

Thank you,

Pearl Liang
ICANN


On Mon Apr 27 21:58:40 2015, sage@newdream.net wrote:
>=20
> Application for a Port Number and/or Service Name
>=20
> Assignee: Sage Weil <sage@newdream.net>
> Contact Person: Sage Weil <sage@newdream.net>
>=20
> Resource Request:
>=20
> [x] Port Number
> [x] Service Name
>=20
> Transport Protocols:
>     [x] TCP
>     [ ] UDP
>     [ ] SCTP
>     [ ] DCCP
>=20
> Service Code:         []
> Service Name:         [ceph]
> Desired Port Number:  [6789]
> Description:          [Ceph monitor]
>=20
> Reference:
> [The Ceph storage cluster monitor daemon runs on a known port and is
> responsible for orchestrating and arbitrating access to Ceph storage
> services.  All other components of the system use dynamically port
> numbers and do not require a fixed assignment.
>=20
> The protocol is a TCP based message passing protocol.]
>=20
> Defined TXT Keys:
>=20
> 1.  If broadcast/multicast is used, how and what for?
> [n/a]
>=20
> 2.  If UDP is requested, please explain how traffic is limited, and
> whether the
>     protocol reacts to congestion.
> [n/a]
>=20
> 3.  If UDP is requested, please indicate whether the service is solely
>     for the discovery of hosts supporting this protocol.
> [n/a]
>=20
> 4.  Please explain how your protocol supports versioning.
> [There is an initial handshake that includes protocol feature bits
> supported.  After the exchange either end can choose to adjust the
> format of subsequent message accordingly (e.g., for backward
> compatibility), adjust its behavior, or opt to disconnect entirely
> with an error message.]
>=20
> 5.  If your request is for more than one transport, please explain in
>     detail how the protocol differs over each transport.
> [n/a]
>=20
> 6.  Please describe how your protocol supports security. Note that
> presently
>     there is no IETF consensus on when it is appropriate to use a
> second port
>     for an insecure version of a protocol.
> [Part of the early handshake with monitors provides for mutual
> authentication of client and server using a shared secret.  The client
> is then provided capabilities that are used when interacting with
> other Ceph services in the system.  The overall model is based on
> Kerberos and uses a similar cryptographic scheme.]
>=20
> 7.  Please explain why a unique port assignment is necessary as
> opposed to a
>    port in range (49152-65535) or existing port.
> [The Ceph monitor is the only service in the system that runs on a
> fixed port as it is used for initial client authentication and to
> learn the addresses of other services in the cluster (which all
> dynamically allocate ports within a range).]
>=20
> 8.  Please explain the state of development of your protocol.
> [The protocol was initially developed in the 2008-2010 timeframe and
> has been deployed in production systems for the last 3-4 years.  The
> existing protocol versioning and other features have proven effective
> to handle all of the protocol and system changes we have dealt with
> over that period.]
>=20
> 9.  If SCTP is requested, is there an existing TCP and/or UDP service
> name or
>     port number assignment? If yes, provide the existing service name
> and port number.
> [n/a]
>=20
> 10.  What specific SCTP capability is used by the application such
> that a
>     user who has the choice of both TCP (and/or UDP) and SCTP ports
> for
>     this application would choose SCTP? See RFC 4960 section 7.1.
> [n/a]
>=20
> 11. Please provide any other information that would be helpful in
>     understanding how this protocol differs from existing assigned
> services.
> []



--557981400-920729992-1430326979=:24030--
