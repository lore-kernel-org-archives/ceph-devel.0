From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 0/3] libceph: #7139 fix
Date: Mon, 20 Jan 2014 19:00:27 +0200
Message-ID: <CALFYKtDYs7D5qqYvTMFwD6a3V+kn0XWHL_jnLtwmBDXxhF+K_g@mail.gmail.com>
References: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34061 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaATRA3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jan 2014 12:00:29 -0500
Received: by mail-wi0-f176.google.com with SMTP id hi8so3425219wib.15
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jan 2014 09:00:27 -0800 (PST)
In-Reply-To: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>

On Fri, Jan 17, 2014 at 3:28 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> Hello,
>
> This series fixes #7139 (Linux kernel client, "dead tcp connections
> during connection negotiation may lead to hangs").  1/2 and 2/2 are
> preparatory patches, 3/3 is the actual fix.

Please ignore this, I'm going to have to do it slightly differently.

Thanks,

                Ilya
