From: kefu chai <tchaikov@gmail.com>
Subject: Re: Perhaps a missing dependancy in the makefiles
Date: Fri, 6 May 2016 12:57:42 +0800
Message-ID: <CAJE9aOO5bhVwGwBEDXEz+=uDx_nosV+F=NBmJv5qCcHiTSn8fw@mail.gmail.com>
References: <add58916-4482-936f-53f7-a79573fc9925@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35126 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcEFE5o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 00:57:44 -0400
Received: by mail-yw0-f173.google.com with SMTP id g133so161060587ywb.2
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2016 21:57:43 -0700 (PDT)
In-Reply-To: <add58916-4482-936f-53f7-a79573fc9925@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, May 5, 2016 at 12:27 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> Everytime I run a parallel make on the full tree I get the following
> complaint:
> In file included from db/builder.cc:16:
> In file included from ./db/compaction_iterator.h:14:
> In file included from ./db/compaction.h:13:
> ./util/mutable_cf_options.h:28:21: error: no member named
> 'soft_pending_compaction_bytes_limit' in
>       'rocksdb::Options'; did you mean
> 'hard_pending_compaction_bytes_limit'?
>             options.soft_pending_compaction_bytes_limit),
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                     hard_pending_compaction_bytes_limit
>
> Then I just run along with a single threaded make, and everything
> completes just fine.
>
> So that is probably a missing dependency for either db/builder.cc, or
> ./util/mutable_cf_options.h.
>
> Suggestions on how to fix this?

Willem, not sure what is going on in your tree. but rocksdb::Options does
have this member variables: it is inherited from its parent class
ColumnFamilyOptions.

>
> Thanx,
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
