From: John Spray <jspray@redhat.com>
Subject: Re: Upcoming 10.2.4
Date: Tue, 11 Oct 2016 11:15:41 +0100
Message-ID: <CALe9h7c=doR1DiahZceq2+i-5i=X4rQqXnprwGDTO7mgS8V4Hw@mail.gmail.com>
References: <57FB7494.1010309@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36323 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbcJKKQ1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 06:16:27 -0400
Received: by mail-qt0-f175.google.com with SMTP id m5so8920172qtb.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2016 03:16:02 -0700 (PDT)
In-Reply-To: <57FB7494.1010309@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 10, 2016 at 11:59 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Abhishek,
>
> Since you're now release manager, it is my understanding that we'll be asking you if the release should be cut or not. I updated the issue tracking the progress of 10.2.4 accordingly. This is a heads up to let you know we'll most likely ask that question for 10.2.4 some time next week ;-)

I've just done a test run of the following jewel PRs:
[11389]  mon: don't crash on invalid standby_for_fscid
[10997]  jewel: multimds: allow_multimds not required when max_mds is
set in ceph.conf at startup
[10958]  jewel: client: fix shutdown with open inodes
[10921]  jewel client: add missing client_lock for get_root
[10107]  jewel: client: FAILED assert(root_ancestor->qtree == __null)

http://pulpito.ceph.com/jspray-2016-10-10_15:27:25-fs-wip-jcsp-backports-20161010-distro-basic-mira/

No (real) failures -- can we go ahead and merge all these before 10.2.4?

Cheers,
John

> Cheers
>
> [1] http://tracker.ceph.com/journals/diff/79457?detail_id=76318
> --
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
