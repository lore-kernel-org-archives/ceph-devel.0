From: Haomai Wang <haomai@xsky.com>
Subject: Re: fun with seastar
Date: Tue, 24 Oct 2017 10:23:30 +0800
Message-ID: <CACJqLyZ0rAZX3_9iGX9MVkR=PJ9BMF6n2f0yb_PHqWLiqN++Tg@mail.gmail.com>
References: <91a5fd79-ff50-53f7-d187-97d024cee8ba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0125.outbound.protection.outlook.com ([104.47.124.125]:23877
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751220AbdJXCXn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Oct 2017 22:23:43 -0400
Received: by mail-vk0-f44.google.com with SMTP id k123so12404719vkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 23 Oct 2017 19:23:37 -0700 (PDT)
In-Reply-To: <91a5fd79-ff50-53f7-d187-97d024cee8ba@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, Oct 24, 2017 at 4:17 AM, Casey Bodley <cbodley@redhat.com> wrote:
> Hi folks,
>
> I mentioned in last week's perf call that I've been experimenting with the
> Seastar library [1] to see how well it can integrate with the ceph codebase.
> So far I've managed to add bufferlist conversions to/from the seastar buffer
> types, and build up a seastar messenger that can send/receive ceph Messages.
> The branch [2] includes a simple echo server unit test and a README with
> build instructions.
>
> This follows some prototype work a couple years ago by Adam Emerson and
> myself, dubbed Project Crimson [3], to evaluate Seastar as the basis for a
> low-latency OSD. Interesting parts of this project include a Cap'n
> Proto-based messenger and an async ObjectStore interface with Memstore
> implementation.

I'm also interested on seastar, but how we get benefit from it to
ceph? rewrite lots of codes is needed to fit seastar framework..... I
think a rough integration can't see much benefit

>
> -Casey
>
> [1] https://github.com/scylladb/seastar
> [2] https://github.com/cbodley/ceph/commits/wip-seastar-msg
> [3] https://github.com/cohortfsllc/crimson
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
