From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: feedback on supporting libc++
Date: Fri, 27 Dec 2013 17:34:44 -0600
Message-ID: <CA+Hcz5_pOdrHyYq9xbn=09S6jFh9enRWq1uKxHSQKS3u2qiXQw@mail.gmail.com>
References: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>
	<527157C0.40802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:49471 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab3L0Xep (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Dec 2013 18:34:45 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so9096831qac.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Dec 2013 15:34:44 -0800 (PST)
In-Reply-To: <527157C0.40802@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>

On Wed, Oct 30, 2013 at 2:02 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 10/29/2013 03:51 PM, Noah Watkins wrote:
>
> unsafe to me. Could you check whether you can run 'rados ls' compiled
> against an old librados, but dynamically loading librados from this
> branch compiled in c++98 mode?

I'm still working on this, but my understanding so far from libc++
documentation is that libc++ and libstdc++ are API but not ABI
compatible, so there shouldn't be an expectation that librados binary
library built against libstc++ will work if dynamically linked against
libc++.
