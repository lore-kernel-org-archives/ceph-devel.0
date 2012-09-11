From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Access Dienied for bucket upload - 403 code
Date: Tue, 11 Sep 2012 09:45:10 -0700
Message-ID: <CAC-hyiGYPJpMCLhW6t00ysxXYovAnsnztaxO8LL-dQLtgfbYUQ@mail.gmail.com>
References: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53915 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947Ab2IKQpL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 12:45:11 -0400
Received: by eaac11 with SMTP id c11so376042eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 09:45:10 -0700 (PDT)
In-Reply-To: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 11, 2012 at 7:28 AM, S=C5=82awomir Skowron <szibis@gmail.co=
m> wrote:
> Every acl operation ending with 403 in PUT.
>
> ~# s3 -u test oc
>                          Bucket                                  Stat=
us
> --------------------------------------------------------  -----------=
---------
> oc                                                        Access Deni=
ed
>
> Anyone know why, and how to enable this bucket ?? Now i have problems
> with cluster, because there is no way to upload new file
>
> ~# s3 -u getacl oc
>
> ERROR: ErrorAccessDenied
>

User somehow lost bucket ownership (was it actually the owner?). Do
you know how to reproduce the issue? any remaining logs?

Try getting bucket info:

# radosgw-admin bucket stats --bucket=3Doc

If that doesn't fail and actually shows relevant info, try checking
whether the user credentials match the s3 tool credentials.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
