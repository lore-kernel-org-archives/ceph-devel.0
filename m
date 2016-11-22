From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Questions about profiling ceph
Date: Tue, 22 Nov 2016 21:00:37 +0100
Message-ID: <20161122200037.GD26997@predictor>
References: <CA+hcxJQQHfhGBHZkfcwn4m3Zfxwh7dPXK=tyVg1d5rw26WNp3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:53201 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755807AbcKVT6Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 14:58:24 -0500
Content-Disposition: inline
In-Reply-To: <CA+hcxJQQHfhGBHZkfcwn4m3Zfxwh7dPXK=tyVg1d5rw26WNp3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 22, 2016 at 11:42:48AM -0800, Victor Denisov wrote:
> Hello ceph developers,
> 
> I'm learning how to profile ceph and came across this page:
> http://docs.ceph.com/docs/giant/rados/troubleshooting/cpu-profiling/
> 
> The page suggests to use oprofile. I compiled oprofile version
> 1.1.0(http://oprofile.sourceforge.net/faq/), but it doesn't have
> opcontrol binary.
> 
> Am I doing something wrong? Is it an outdated procedure for profiling?
> Is there a newer one?

Well, they actually noted (in the faq you linked) that opcontrol is a
legacy tool. And the cpu profiling guide is for "Giant" Ceph release
(also quite legacy).
Anyway, operf + opreport tandem is sufficient for me and I'm sure it
will be enough for you.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
