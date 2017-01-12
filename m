From: John Spray <jspray@redhat.com>
Subject: Re: Question about Logging Level
Date: Thu, 12 Jan 2017 10:36:29 +0000
Message-ID: <CALe9h7eF77h5RA8UYGv6ryC5rLwHJewZjVf8d_eKqNoMnPg6wQ@mail.gmail.com>
References: <CACKY0b-_ZaLCVUwdW4-p6BtPeaAHQ10B-KqjmxuM+Nh5h_xj5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34707 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdALKhH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 05:37:07 -0500
Received: by mail-oi0-f47.google.com with SMTP id 3so18050318oih.1
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2017 02:37:00 -0800 (PST)
In-Reply-To: <CACKY0b-_ZaLCVUwdW4-p6BtPeaAHQ10B-KqjmxuM+Nh5h_xj5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 12, 2017 at 8:12 AM, liuchang0812 <liuchang0812@gmail.com> wrote:
> Hi, all
>
> In our documentation, it says that:
>
>         Ceph’s logging levels operate on a scale of 1 to 20, where 1
> is terse and 20 is verbose.
>
> http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/#subsystem-log-and-debug-settings
>
>
> But, it seems that there are some logging levels 25 :
>
>
> mds/MDBalancer.cc:276:  dout(25) << "=== got heartbeat " <<
> m->get_beat() << " from " << m->get_source().num() << " " <<
> m->get_load() << dendl;
> mds/CInode.cc:4189:  dout(25) << __func__ << dendl;
> mds/MDCache.cc:11656:    //dout(25) << "saw depth " << d << " " <<
> *dir << dendl;
> mds/MDCache.cc:11666:   //dout(25) << " saw sub " << **p << dendl;
> mds/journal.cc:373:      dout(25) << "EMetaBlob::add_dir_context(" <<
> dir << ")      maybe " <<
>
>
> So, shoud we update our documentation, or update logging level to 20?

Probably neither -- the >20 log messages are intentionally obscure
things (although I do accept that there is a reasonable argument that
if we would never turn something on in a real system then we perhaps
should not have it in the code...)

John

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
