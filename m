From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: [rgw] Multi-tenancy support in radosgw
Date: Mon, 14 Sep 2015 13:57:35 -0700
Message-ID: <CADRKj5QZqKwGm0_kkR1msjxvwdeCEybVfGK0bQ8dO2Z+b-yDSQ@mail.gmail.com>
References: <CA+H5UW0Y2Yc7jSG=iZ5bFpSEFsPpb50tgG1FUxRZFihf904yiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34070 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbbINU5g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 16:57:36 -0400
Received: by obbda8 with SMTP id da8so118654786obb.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2015 13:57:36 -0700 (PDT)
In-Reply-To: <CA+H5UW0Y2Yc7jSG=iZ5bFpSEFsPpb50tgG1FUxRZFihf904yiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Pete Zaitcev <zaitcev@redhat.com>

On Fri, Sep 11, 2015 at 3:24 PM, Radoslaw Zarzynski
<rzarzynski@mirantis.com> wrote:
> Hello,
>
> It's a well-known trait of radosgw that an user cannot create new
> bucket with a given name if the name is already occupied by other
> user's bucket (request to do that will be rejected with 409 Conflict).
> This behaviour is entirely expected in S3. However, when it comes
> to Swift API, it turns into huge limitation.
>
> In my opinion the root cause lies in how radosgw actually handles
> bucket entry points. They might be seen as symlinks which must
> be resolved in order to map bucket names exposed to users into
> concrete bucket instances:
>
>   bucket name -> unique bucket instance ID
>
> It's completely clear we need to preserve backward compatibility.
> Thus we cannot simply append ID of user who owns a given
> bucket to argument list of mapping function. We would have to
> introduce an indirection layer - bucket namespaces:
>
>   bucket namespace, bucket name -> unique bucket instance ID
>
> Each already existing user would obtain empty bucket namespace
> by default. It will be possible to create user  with his own, unique
> namespace.
>
> Generally this looks to me as stupidly simple solution. Of course,
> it has limitations. At the moment I see following things:
>
> 1. We may need to develop a new mechanism for moving buckets
>     between namespaces in radosgw-admin. The already existing
>     one for linking/unlinking might be not enough.


This is a nice to have, not sure we actually need that.

>
> 2. We will always need ID of namespace in order to access proper
>     bucket entry points. This is not a problem for requests authorized
>     through Keystone/TempAuth because user ID is known and thus
>     BNS may be easily calculated.
>     Anonymous access/TempURL for bucket with non-empty namespace
>     is a different story. In this case BNS must be provided explicitly.
>     Swift resolves the problem by having account name as a part of URL.
>     We could go the same way. This would be extended by decoupling
>     rgw_user used for storage access purposes from the one for
>     authorizing a given operation (RGWOp::verify_permission() method).
>
>
> I would like to ask for reviews of the idea and feedback.
>

I think that it's orthogonal to the whole multi-tenancy issue. It
might solve a specific requirement, but doesn't address the entire
scope of multitenancy. But it's probably a good idea to have it
anyway, as it adds a needed layer of abstraction.
I also think that we shouldn't treat this as a swift specific issue.
We should make it configurable and work for both S3 and swift.

Yehuda
