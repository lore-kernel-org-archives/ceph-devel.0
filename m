From: Alexey Sheplyakov <asheplyakov@mirantis.com>
Subject: Re: Cinder doesn't work with the current rados python bindings
Date: Wed, 14 Dec 2016 13:17:00 +0400
Message-ID: <CAC7t81ZDEVmRtJQgKbO0EEpAsUs1z1aauJg-7WcUvXAmazKajg@mail.gmail.com>
References: <CA+hcxJS_wKucTUetNxPrHTn2j0V6vDUjCwKUTxp176xoCmSmVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:35670 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754957AbcLNJRB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2016 04:17:01 -0500
Received: by mail-yb0-f169.google.com with SMTP id d128so10672137ybh.2
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2016 01:17:01 -0800 (PST)
In-Reply-To: <CA+hcxJS_wKucTUetNxPrHTn2j0V6vDUjCwKUTxp176xoCmSmVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Victor,

> Rados.conf_get('features') used to return an integer. It returns a string right now.

The rbd_default_features parameter used to be an integer, which is not
very user friendly.
commit 9b8a2da1902710960a45159172a1f1b8184fa1a2 addressed the issue by changing
rbd_default_features to be a comma separated list of human readable
feature names.

Best regards,
      Alexey


On Wed, Dec 14, 2016 at 12:29 AM, Victor Denisov <vdenisov@mirantis.com> wrote:
> Hello,
>
> Who knows where pybind/rados/rados.pyx came from?
> I talked to a guy in the cinder development team - he tried to build
> his code against the latest python bindings from master.
> It looks like the api's changed. Rados.conf_get('features') used to
> return an integer.
> It returns a string right now.
>
> I looked into the git history and I see that pybind.pyx has been where
> it's right now only since February this year. I presume cinder's using
> an older version.
>
> Can someone advise me on how I can track down the changes in python bindings.
>
> Thank you in advance.
>
> Victor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
