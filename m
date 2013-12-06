From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] block I/O when cluster is full
Date: Thu, 05 Dec 2013 17:47:21 -0800
Message-ID: <52A12CA9.3020008@inktank.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:45842 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab3LFBrj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Dec 2013 20:47:39 -0500
Received: by mail-yh0-f41.google.com with SMTP id f11so44550yha.28
        for <ceph-devel@vger.kernel.org>; Thu, 05 Dec 2013 17:47:38 -0800 (PST)
Received: from ?IPv6:2607:f298:a:607:415:62f7:d15c:243f? ([2607:f298:a:607:415:62f7:d15c:243f])
        by mx.google.com with ESMTPSA id s21sm54883078yhk.9.2013.12.05.17.47.37
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 17:47:38 -0800 (PST)
In-Reply-To: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 12/03/2013 03:12 PM, Josh Durgin wrote:
> These patches allow rbd to block writes instead of returning errors
> when OSDs are full enough that the FULL flag is set in the osd map.
> This avoids filesystems on top of rbd getting confused by transient
> EIOs if the cluster oscillates between full and non-full.
>
> These are also available in the wip-full branch of ceph-client.git.
>
> Josh Durgin (3):
>    libceph: block I/O when PAUSE or FULL osd map flags are set
>    libceph: add an option to configure client behavior when osds are
>      full
>    rbd: document rbd-specific options

Due to a race condition between clients and osds in handling maps
marked FULL, it's not feasible to offer the 'error' option, so patches
2 and 3 can be ignored.

http://tracker.ceph.com/issues/6938

