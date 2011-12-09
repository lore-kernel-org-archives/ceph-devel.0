From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Client receives 'connection refused' only after heavy use
Date: Thu, 08 Dec 2011 16:40:08 -0800
Message-ID: <4EE158E8.8030603@cs.ucsc.edu>
References: <4EDC0ECF.60805@cs.ucsc.edu>	<4EDC1853.5080405@cs.ucsc.edu>	<Pine.LNX.4.64.1112042046280.8414@cobra.newdream.net>	<4EDD1437.4030608@cs.ucsc.edu>	<CAORUGqCZy+j3MUry7ut=E7YXNiPHLGSqRw5qyqaOKR2=12mjhA@mail.gmail.com>	<4EDD15EC.1000900@cs.ucsc.edu>	<CAORUGqATJ=xcs3GPQkdqN5q4MjQcEYewj_aJhq2DVa=m95TLww@mail.gmail.com>	<CAF3hT9A=cRttnho5DhF991+UnwCfxGO5sDtvU8AmBXMfEhg_Qg@mail.gmail.com> <CAF3hT9DACT5QMNkPYv8tG2dE=JnnZO-k22-k7SG7htbv6D2YEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:36057 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab1LIAkT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 19:40:19 -0500
In-Reply-To: <CAF3hT9DACT5QMNkPYv8tG2dE=JnnZO-k22-k7SG7htbv6D2YEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org

This patch appears to be working well!

Thanks,
Noah

On 12/07/2011 02:33 PM, Gregory Farnum wrote:
> Noah:
> Branch wip-messenger contains the patch you want (plus one or two
> cleanups), or apply the below. Should handle it, although I'd like to
> do a more thorough cleanup of this problem at a later time.
> -Greg
>
>  From 8c4f4748e8b683f5b4ea939295793421c0ab7b61 Mon Sep 17 00:00:00 2001
> From: Greg Farnum<gregory.farnum@dreamhost.com>
> Date: Wed, 7 Dec 2011 14:19:23 -0800
> Subject: [PATCH] mds: mark_disposable when closing a Client connection.
>
> This is causing issues since the Client's ack of the MClientSession
> is somehow not getting back to the MDS. We should make the
> Client/SimpleMessenger be better-behaved about shutdown, but for
> now this solution matches how we're working elsewhere in our codebase.
>
> Signed-off-by: Greg Farnum<gregory.farnum@dreamhost.com>
> ---
>   src/mds/Server.cc |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index a9ef64f..d44bd7e 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -289,6 +289,7 @@ void Server::_session_logged(Session *session,
> uint64_t state_seq, bool open, ve
>         // reset session
>         mds->send_message_client(new
> MClientSession(CEPH_SESSION_CLOSE), session);
>         mds->sessionmap.set_state(session, Session::STATE_CLOSED);
> +      mds->messenger->mark_disposable(session->connection);
>         session->clear();
>       } else if (session->is_killing()) {
>         // destroy session, close connection
>    

