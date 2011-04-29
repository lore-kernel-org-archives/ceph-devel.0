From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: Ideas on NSS vs fork?
Date: Thu, 28 Apr 2011 23:02:57 -0700
Message-ID: <BANLkTimF1sLvLuw3tztW8Ee6eLV6vP1-8w@mail.gmail.com>
References: <20110428212902.GA3932@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42945 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab1D2GC6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 02:02:58 -0400
Received: by fxm17 with SMTP id 17so2295378fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 23:02:57 -0700 (PDT)
In-Reply-To: <20110428212902.GA3932@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 2:29 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> NSS, the crypto library Red Hat likes to use, cannot tolerate
> forks. NSS_NoDB_Init must be called after daemonization, and there
> seems to be no way around it; for example, calling it again is
> explicitly forbidden.
>
> The code in branch wip-nss-vs-fork adds a common_init_daemonized
> function, that things that (potentially) daemonize must call, after
> the point where they'd daemonize. Non-daemons are handled in
> common_preinit and need nothing special.
>
> Users of libceph/librados cannot fork, and expect to keep using the
> library :(

We already are in a situation where the child process after a fork
can't use librados or libceph. The reason is because the child process
will not have any threads besides the main one.

The question we need to answer is really whether forking somehow
destroys the state of the parent process, even if the child thread
never runs any libNSS code. If the answer is no, which is very likely,
then essentially our situation is unchanged.

>
> The "remove this" comment on libceph_initialized cannot be blindly
> acted on; similar logic could be pushed down into ceph::crypto::init,
> though.
>
> This is ugly, but it's the best I could do. Please go through the cod=
e
> and let me know if you have any ideas on how to make it less painful.

Daemonization should be done in common_init. Obviously, only daemons wi=
ll do it!

Daemonization has nothing to do with the messenger logically, so it
will be good to get that stuff out of there.

Colin.

>
> In the meanwhile, if you need NSS to work, you can always run in
> non-daemonizing mode, with -f.
>
>
> P.S. Please use Crypto++. For my sanity.
>
> --
> :(){ :|:&};:
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
