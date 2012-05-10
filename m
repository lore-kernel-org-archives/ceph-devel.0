From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/2] Ceph tracepoints
Date: Thu, 10 May 2012 10:39:36 -0500
Message-ID: <4FABE138.6030809@inktank.com>
References: <1336660556-6943-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59656 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2EJPjk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 11:39:40 -0400
Received: by yenm10 with SMTP id m10so1600611yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 08:39:39 -0700 (PDT)
In-Reply-To: <1336660556-6943-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: elder@dreamhost.com, ceph-devel@vger.kernel.org

On 05/10/2012 09:35 AM, Jim Schutt wrote:
> Hi Alex,
>
> I ran across tracker #2374 today - I've been carrying these two
> tracepoint patches for a while.  Perhaps you'll find them useful.

GREAT!

I haven't looked at them but I will as soon as I get the chance.
I don't expect there's any reason not to use this as the foundation
I was looking for.

Thanks a lot.

					-Alex

> Jim Schutt (2):
>    ceph: add tracepoints for message submission on read/write requests
>    ceph: add tracepoints for message send queueing and completion, reply
>      handling
>
>   fs/ceph/addr.c              |    8 +++
>   fs/ceph/file.c              |    6 ++
>   include/trace/events/ceph.h |  144 +++++++++++++++++++++++++++++++++++++++++++
>   net/ceph/messenger.c        |    9 +++-
>   net/ceph/osd_client.c       |    8 +++
>   5 files changed, 174 insertions(+), 1 deletions(-)
>   create mode 100644 include/trace/events/ceph.h
>

