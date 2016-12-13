From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Cinder doesn't work with the current rados python bindings
Date: Tue, 13 Dec 2016 16:38:28 -0500
Message-ID: <CA+aFP1Bz_=HPVnJTJa29NJMmvzX7_gSA3EEB2n5VZLctBU4tKA@mail.gmail.com>
References: <CA+hcxJS_wKucTUetNxPrHTn2j0V6vDUjCwKUTxp176xoCmSmVw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33759 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932807AbcLMVrO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 16:47:14 -0500
Received: by mail-lf0-f49.google.com with SMTP id c13so220996lfg.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 13:47:13 -0800 (PST)
In-Reply-To: <CA+hcxJS_wKucTUetNxPrHTn2j0V6vDUjCwKUTxp176xoCmSmVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Are you referring to rbd_default_features [1]? If so, that was a
change with unintentional consequences in the master branch that I
will need to fix before the final Kraken release.

[1] https://github.com/openstack/cinder/blob/9fcb3bf1ad00913654872858d0cec839a6a2f0c8/cinder/volume/drivers/rbd.py#L152

On Tue, Dec 13, 2016 at 3:29 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
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



-- 
Jason
