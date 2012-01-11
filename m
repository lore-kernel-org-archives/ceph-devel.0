From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: towards a user-mode diagnostic log mechanism
Date: Tue, 10 Jan 2012 17:04:26 -0800
Message-ID: <CAORUGqDmT86qdvpba1EYo6_D7KjAm7eHa_hReRgnw0uOU=8HQQ@mail.gmail.com>
References: <4EEFF614.8040207@dreamhost.com> <CA+qbEUNvLL0pui+XOr5W2m6dmBCxg8d4ZobrAnXV=wTQ=7YCFw@mail.gmail.com>
 <CAORUGqDCBaOA_N2+Lw+tyhDc3wjGBjEnnBYZO-=aMaNoRycoPw@mail.gmail.com> <4F0CDA9A.4070500@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40299 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756929Ab2AKBEs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2012 20:04:48 -0500
Received: by wgbdt14 with SMTP id dt14so3287437wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2012 17:04:47 -0800 (PST)
In-Reply-To: <4F0CDA9A.4070500@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Mark Kampe <mark.kampe@dreamhost.com>, ceph-devel@vger.kernel.org

On Tue, Jan 10, 2012 at 16:40, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> The cost of reading the software clock via gettimeofday is dependent on the
> OS implementation, and can vary by as much as 2 orders of magnitude (see
> attached slide: 1.6us vs 60ns per clock read).
>
> Older Linux kernels force a thread into the kernel when calling gettimeofday
> adding enormous overhead relative to the newer vsyscall implementations that
> evaluate gettimeofday within userspace.

So turning debug to full blast on older kernels will be painful. I'm
personally ok with that, especially when the alternative is
implementing all of the TSC logic myself. This is really complex code,
and somebody went through the effort of solving the hard problems for
us -- let's use their code!
