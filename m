From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS and the next giant release v0.87.2
Date: Thu, 16 Apr 2015 15:44:54 -0700
Message-ID: <CAC6JEv8iAOHb2+R9TXFwQ0BnmaY-zYfq4E7MzZsK_Doa7LN5gA@mail.gmail.com>
References: <552E316D.5060703@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33893 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbDPWo4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 18:44:56 -0400
Received: by iget9 with SMTP id t9so17865185ige.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 15:44:55 -0700 (PDT)
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com. [209.85.223.173])
        by mx.google.com with ESMTPSA id q10sm83326ige.16.2015.04.16.15.44.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 15:44:55 -0700 (PDT)
Received: by iebrs15 with SMTP id rs15so63071213ieb.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 15:44:54 -0700 (PDT)
In-Reply-To: <552E316D.5060703@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

On Wed, Apr 15, 2015 at 2:37 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> The next giant release as found at https://github.com/ceph/ceph/tree/giant passed the fs suite (http://tracker.ceph.com/issues/11153#fs). Do you think it is ready for QE to start their own round of testing ?
>
> Note that it will be the last giant release.
>
> Cheers
>
> P.S. http://tracker.ceph.com/issues/11153#Release-information has direct links to the pull requests merged into giant since v0.87.1 in case you need more context about one of them.

All those PRs look like fine ones to release.

I remember you went through a big purge of giant-tagged backports at
one point though (when we thought we weren't going to do any more
releases at all). Did that get somehow undone and all of those dealt
with? Some of them were more important than others and it would be
some work for me to reconstruct the list, but I'll need to do that if
you haven't already. :/
-Greg
