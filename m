From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: blueprint: consistency groups
Date: Fri, 25 Mar 2016 09:19:34 +0200
Message-ID: <20160325071933.GA14634@gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
 <CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35886 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbcCYHTh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2016 03:19:37 -0400
Received: by mail-lf0-f44.google.com with SMTP id d82so50313112lfe.3
        for <ceph-devel@vger.kernel.org>; Fri, 25 Mar 2016 00:19:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Victor Denisov <vdenisov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>

On Thu, Mar 24, 2016 at 03:38:25PM -0700, Gregory Farnum wrote:

> Just to be clear, you know that you can use the same snapid for all
> the images, right? (...although not if you're trying to allow CGs
> across pools. Those will be a little harder.)

I think not allowing CGs across pools would be annoying limitation for
users. If a VM has several volumes for different purposes (e.g. small
but fast volume for applicatin data, and large but slow one for
backups) it is logical to have different pools for those.

-- 
Mykola Golub
