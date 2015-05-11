From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS and the next hammer release v0.94.2
Date: Mon, 11 May 2015 09:37:22 -0700
Message-ID: <CAC6JEv9H2kDvA7VVjJk7Pwx+26hohim2B0rZ1g0m6qPwESqWeQ@mail.gmail.com>
References: <55509EC6.2060503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35860 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbbEKQoH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 12:44:07 -0400
Received: by iecmd7 with SMTP id md7so35067682iec.3
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 09:44:06 -0700 (PDT)
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com. [209.85.213.173])
        by mx.google.com with ESMTPSA id s5sm224442igh.6.2015.05.11.09.37.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 09:37:22 -0700 (PDT)
Received: by igbpi8 with SMTP id pi8so74910441igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 09:37:22 -0700 (PDT)
In-Reply-To: <55509EC6.2060503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

On Mon, May 11, 2015 at 5:21 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> The next hammer release as found at https://github.com/ceph/ceph/tree/hammer passed the fs suite (http://tracker.ceph.com/issues/11492#fs), which also includes your last minute addition https://github.com/ceph/ceph/pull/4629. Do you think it is ready for QE to start their own round of testing ?
>
> Cheers
>
> P.S. http://tracker.ceph.com/issues/11492#Release-information has direct links to the pull requests merged into hammer since v0.94.1 in case you need more context about one of them.

Yep, should be good!
-Greg
