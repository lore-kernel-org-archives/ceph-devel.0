From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How to write data to rbd pool.
Date: Wed, 3 Oct 2012 13:18:32 -0700
Message-ID: <CADvuQRF2M+fqY7daFRpC6wmjTouB5EecZKpDBTxa21qq=9zSDw@mail.gmail.com>
References: <loom.20121001T173732-275@post.gmane.org> <loom.20121003T065313-927@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:33906 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab2JCUSx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 16:18:53 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so2041051qad.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 13:18:53 -0700 (PDT)
In-Reply-To: <loom.20121003T065313-927@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 2, 2012 at 9:55 PM, ramu eppa <ramu.freesystems@gmail.com> wrote:
>    When map rbd to /dev it's giving error,
> "rbd map /dev/mypool/mytest "

The syntax is "rbd map mypool/mytest".

http://ceph.com/docs/master/man/8/rbd/
