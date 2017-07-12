From: John Spray <jspray@redhat.com>
Subject: Re: new ceph-mgr Python module notification types
Date: Wed, 12 Jul 2017 11:02:08 +0100
Message-ID: <CALe9h7eQHjNOYO95_71a_bLhne=0psZSg2dCwyq7vdbSzs65Cw@mail.gmail.com>
References: <66c05f35-b618-e490-a365-281aade8a755@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:32883 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbdGLKCa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 06:02:30 -0400
Received: by mail-wr0-f174.google.com with SMTP id r103so26550982wrb.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 03:02:29 -0700 (PDT)
In-Reply-To: <66c05f35-b618-e490-a365-281aade8a755@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 12, 2017 at 5:54 AM, Dan Mick <dmick@redhat.com> wrote:
> I'm considering adding a new notification type ("perf_schema_update"),
> to be called from DaemonServer.cc.  The existing notify types are all
> defined in Mgr.cc.  Should we try to collect them somewhere more global,
> if only for reference's sake?

You mean define a set of string constants somewhere and then use them
(instead of bare strings) when sending notifications?  Sounds good to
me.

John

>
> --
> Dan Mick
> Red Hat, Inc.
> Ceph docs: http://ceph.com/docs
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
