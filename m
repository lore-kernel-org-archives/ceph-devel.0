From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: How to create nova volumes inside rbd pool .
Date: Thu, 27 Sep 2012 10:32:44 -0400
Message-ID: <CACkq2mpw5BTLo+c1DnsbhLENMwgZgz5VRwt2Uk94kV4HfXd6cQ@mail.gmail.com>
References: <loom.20120927T064251-722@post.gmane.org> <5063DFC9.5030505@inktank.com>
 <loom.20120927T083015-790@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36891 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab2I0OdG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 10:33:06 -0400
Received: by qadc26 with SMTP id c26so3865221qad.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 07:33:04 -0700 (PDT)
In-Reply-To: <loom.20120927T083015-790@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Ramu,

If you are trying to get nova-volume to work with Ceph, I found this
howto extremely useful:
http://www.sebastien-han.fr/blog/2012/06/10/introducing-ceph-to-openstack/

There are a few things I did differently with the ceph.conf file, but
the steps definitely worked (at the time -- it's been a couple months
since I followed them).

 - Travis

On Thu, Sep 27, 2012 at 2:33 AM, ramu eppa <ramu.freesystems@gmail.com> wrote:
>
> Hi Mick,
>
>   Iam creating nova pool using this command,
> rbd --pool nova create --size 1024 testpool.It's creating pool fine,
> but i want to create volume inside this pool(testpool).
>
> Thanks,
> Ramu.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
