From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: [PATCH] AArch64: Detect crc32 extension support from assembler
Date: Mon, 26 Sep 2016 17:09:53 +0200
Message-ID: <a1b0534f-93b4-1684-3abd-559c42148d00@suse.cz>
References: <1474892258-178638-1-git-send-email-agraf@suse.de>
 <CAOi1vP8F26QTRjUe-CUHfMOor61H-wi1KoLmYoeov9shyOUF2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41633 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940933AbcIZPJ5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 11:09:57 -0400
In-Reply-To: <CAOi1vP8F26QTRjUe-CUHfMOor61H-wi1KoLmYoeov9shyOUF2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Alexander Graf <agraf@suse.de>
Cc: Steve Capper <steve.capper@linaro.org>, Yazen Ghannam <yazen.ghannam@linaro.org>, Ceph Development <ceph-devel@vger.kernel.org>

> We've been working on switching to cmake and actually ripped autotools
> out of master a couple of weeks ago, so this won't apply.

Keep it around, though, for the jewel backport ;-)

Nathan
