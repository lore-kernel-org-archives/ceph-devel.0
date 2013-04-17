From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 08:04:29 -0700
Message-ID: <CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com>
References: <loom.20130417T164538-81@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:49241 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966461Ab3DQPEa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 11:04:30 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so1530131iad.21
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 08:04:30 -0700 (PDT)
In-Reply-To: <loom.20130417T164538-81@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: proguest <proguest1942@hotmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 17, 2013 at 7:54 AM, proguest <proguest1942@hotmail.com> wrote:
> hi,
> I really need some help for my ceph radosgw.
> stuck on it for a really long time.
>
> I followed by the ceph document
> http://ceph.com/docs/master/start/quick-rgw/
>
> without any error or warnimg.
>
> i can even use radosgw-admin to create user successfully.
>
> But, I cant get into cephfs neither S3 nor swift.
>
> #swift -A http://<radosgw-host>/auth -U <user> -K <key> post test
>
> only responded Auth GET failed: http://<radosgw-host>:80 404 Not Found
>
> How can I solve this problem...? I really need a help
>

Hard to know without additional info. It looks though as you might
have apache config issues (if you're using apache).

Yehuda
