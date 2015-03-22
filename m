From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: OPW Contribution
Date: Sun, 22 Mar 2015 22:44:13 +0300
Message-ID: <CAOi1vP8+S-iKs6m205Oaj7EDFDY+H0Qa1HQ6ssHU3Pw=p5p+aw@mail.gmail.com>
References: <CAGRfJqhRNMGYBh6pS0Ln0fYYX0RdSxS+mQxMNdKN+gd7CxCY9g@mail.gmail.com>
	<550DC8DE.5020207@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35838 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbbCVToO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Mar 2015 15:44:14 -0400
Received: by wgdm6 with SMTP id m6so130335998wgd.2
        for <ceph-devel@vger.kernel.org>; Sun, 22 Mar 2015 12:44:13 -0700 (PDT)
In-Reply-To: <550DC8DE.5020207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: kuna fomboh <fombohkuna@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Mar 21, 2015 at 10:39 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> The simplest contribution is to pick a low hanging fruit from the tracker[1]. Alternatively you can browse the documentation at http://ceph.com/docs/master/ and file a bug at http://tracker.ceph.com/projects/ceph/issues/new when you find a typo. Then you can fix it by modifying the corresponding file at https://github.com/ceph/ceph/tree/master/doc and submitting a pull request. You will find more information about contributions at http://ceph.com/community/contribute/

In addition to typos, there are a lot of places with formatting gone
wrong, especially in man pages (the reason being that man pages are
generated from .rst files and there seems to be a number of gotchas to
that).  Fixing those up would be a great help!

Thanks,

                Ilya
