From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Jewel v10.2.10, anyone?
Date: Thu, 31 Aug 2017 13:06:35 +0200
Message-ID: <CABZ+qqmXXJnMok=HgLYhvsNVRtJb5DF22qWP8zUsCnuvnqjqQQ@mail.gmail.com>
References: <7ca238e9-0cd0-d3c6-73c2-76643d7f2ec0@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36008 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdHaLHT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Aug 2017 07:07:19 -0400
Received: by mail-lf0-f49.google.com with SMTP id z12so1395794lfd.3
        for <ceph-devel@vger.kernel.org>; Thu, 31 Aug 2017 04:07:19 -0700 (PDT)
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com. [209.85.215.42])
        by smtp.gmail.com with ESMTPSA id w88sm1387787lfd.94.2017.08.31.04.07.16
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Aug 2017 04:07:16 -0700 (PDT)
Received: by mail-lf0-f42.google.com with SMTP id d202so1349966lfd.5
        for <ceph-devel@vger.kernel.org>; Thu, 31 Aug 2017 04:07:16 -0700 (PDT)
In-Reply-To: <7ca238e9-0cd0-d3c6-73c2-76643d7f2ec0@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Here are the cephfs PR's we patch locally:

https://github.com/ceph/ceph/pull/16150
https://github.com/ceph/ceph/pull/16963
http://tracker.ceph.com/issues/20945 (not yet staged)

Thanks!

Dan


On Wed, Aug 30, 2017 at 10:23 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> It's been 6 weeks since the last Jewel point release and progress is being
> made towards 10.2.10. I'm thinking that the current integration branch might
> be the last, or second-to-last.
>
> Any last-minute requests or must-haves?
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
