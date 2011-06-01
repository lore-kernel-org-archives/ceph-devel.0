From: Simon Tian <aixt2006@gmail.com>
Subject: Re: compile error for ceph-0.28.*.tar.gz
Date: Wed, 1 Jun 2011 17:46:30 +0800
Message-ID: <BANLkTi=RFMvVLUnuMrm-f_3XTCq+EXyf+A@mail.gmail.com>
References: <BANLkTinCKuhzaRLKaBmJXJJCsNNHeDFuPA@mail.gmail.com>
	<20110531172458.GA12733@dreamer>
	<4DE52AE3.9020900@sandia.gov>
	<20110531184821.GB12733@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56717 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab1FAJqc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 05:46:32 -0400
Received: by wwk4 with SMTP id 4so3263551wwk.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2011 02:46:31 -0700 (PDT)
In-Reply-To: <20110531184821.GB12733@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

I found it is difficult to update boost on all my rhel5.4 hosts, is
there any way to make ceph-0.28.* successfully on rhel5.4 with old
boost?

2011/6/1 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Tue, May 31, 2011 at 11:52:35AM -0600, Jim Schutt wrote:
>> FWIW, I believe I saw such errors on RHEL 5 due to it having
>> boost v1.33.1, while Ceph needs v1.34 or newer to get statechart.
>
> It seems we don't have a versioned dependency on libboost. I created a
> ticket to make it so. Like a captain.
>
> http://tracker.newdream.net/issues/1124
>
> --
> :(){ :|:&};:
>
