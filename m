From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v4] Ceph-fuse: Fallocate and punch hole support
Date: Wed, 14 Aug 2013 15:42:04 +0800
Message-ID: <CAAM7YA=zfpvO5SQJ7u_HTRabJJYNWdNrjDODom3f8Pk0VZKOww@mail.gmail.com>
References: <1376450637-15567-1-git-send-email-liwang@ubuntukylin.com>
	<alpine.DEB.2.00.1308132119310.1479@cobra.newdream.net>
	<520B2C64.3050002@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:52277 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759199Ab3HNHmG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 03:42:06 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so6512126lab.40
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 00:42:04 -0700 (PDT)
In-Reply-To: <520B2C64.3050002@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 14, 2013 at 3:06 PM, Li Wang <liwang@ubuntukylin.com> wrote:
> Ok, regarding the very 'FIRST' object, what does 'FIRST' refer to?
> Suppose the object size is 4MB, we open an empty file, write at [6MB, 7MB],
> then an object named something like 0001 generated. Is it the first object?
> Then next time, if we write at [0MB, 1MB], then the object named 0000
> exists, at this time, who is the first? The order is file location or
> generating time?

first object is the object with offset 0. If client does not write to
the object, MDS
will create it.
