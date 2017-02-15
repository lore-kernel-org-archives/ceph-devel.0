From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: swift slo manifest etag
Date: Wed, 15 Feb 2017 11:21:23 -0800
Message-ID: <CADRKj5ShCpHu-62r0P30Q9E+6zZMHKn=ddyNyCrhh5OJtnCcrA@mail.gmail.com>
References: <868184347.107585548.1487186032181.JavaMail.zimbra@redhat.com> <1625664484.107586782.1487186325410.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33519 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdBOTVZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 14:21:25 -0500
Received: by mail-vk0-f54.google.com with SMTP id k127so105213688vke.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 11:21:24 -0800 (PST)
In-Reply-To: <1625664484.107586782.1487186325410.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Feb 15, 2017 at 11:18 AM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Hi Swift mavens,
>
> Current swift documentation states that slo manifest etag and size_bytes keys are optional [1].  I found [2], which suggests that only recently did Swift object storage actually behave as if the etag is "fully optional."
>
> Currently attempts to fetch an object whose manifest etag is not defined ("") result in ERR_PRECONDITION_FAILED due to the if_match logic in  RGWRados::Object::Read::prepare().  Should this logic permit the if-match to succeed if etag is not defined?
>

We should only fail if the if-match header is specified.

Yehuda

> Thanks,
>
> Matt
>
> [1] http://docs.openstack.org/developer/swift/overview_large_objects.html
> [2] http://git.openstack.org/cgit/openstack/swift/commit/?id=462f91b040ff47b51e5397eed930785590638d69
>
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
