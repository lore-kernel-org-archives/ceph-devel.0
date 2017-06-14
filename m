From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 11:08:43 +0200
Message-ID: <CA+H5UW2k7ZEJVYJXE4aGvbNkjBsN3mVaDiNpRY585CvyGpOdeA@mail.gmail.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34703 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFNJIp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 05:08:45 -0400
Received: by mail-qk0-f182.google.com with SMTP id d14so31614440qkb.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 02:08:44 -0700 (PDT)
In-Reply-To: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks for the info, Willem. I'm on it.

BTW: it would be nice to have a Clang builder to find out similar
issues as early as possible.

Regards,
Radek

On Wed, Jun 14, 2017 at 10:49 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> I guess that in Clang strlen is not evaluation to a constant.
>
> --WjW
>
> In file included from
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_keystone.cc:22:
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:171:29: error:
> constexpr variable 'META_MAX_SIZE' must be initialized by a constant
> expression
>     static constexpr size_t META_MAX_SIZE = \
>                             ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:172:7: note:
> non-constexpr function 'strlen' cannot be used in a constant expression
>       strlen("\r\nffffffffffffffff;chunk-signature=") + SIG_SIZE +
> strlen("\r\n");
>       ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:175:29: error:
> constexpr variable 'META_MIN_SIZE' must be initialized by a constant
> expression
>     static constexpr size_t META_MIN_SIZE = \
>                             ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:176:7: note:
> non-constexpr function 'strlen' cannot be used in a constant expression
>       strlen("0;chunk-signature=") + SIG_SIZE + strlen("\r\n");
>       ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:204:41: error:
> non-type template argument is not a constant expression
>   boost::container::static_vector<char, ChunkMeta::META_MAX_SIZE>
> parsing_buf;
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:204:41: note:
> initializer of 'META_MAX_SIZE' is not a constant expression
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:171:29: note:
> declared here
>     static constexpr size_t META_MAX_SIZE = \
>                             ^
> 3 errors generated.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
