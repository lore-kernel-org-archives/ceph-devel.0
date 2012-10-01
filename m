From: hemant surale <hemant.surale@gmail.com>
Subject: Re: How to direct data inject to specific OSDs
Date: Mon, 1 Oct 2012 23:21:18 +0530
Message-ID: <CAGfy=6kcbXz6n-x13bm_7mGmMnTo96wLvkBZpRNnw2aEL1afoA@mail.gmail.com>
References: <CAGfy=6ktXBkVQkZ=Z9ODAmWm9cCVu=7nsGOeDE2CvNEdAGK75w@mail.gmail.com>
	<CADvuQRHxaU9LTwda-UUsvECA0C+Mc2Yuf1jBxAwxLj7ZGPXLtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51453 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab2JARvT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 13:51:19 -0400
Received: by vcbfo13 with SMTP id fo13so5930988vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 10:51:18 -0700 (PDT)
In-Reply-To: <CADvuQRHxaU9LTwda-UUsvECA0C+Mc2Yuf1jBxAwxLj7ZGPXLtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

It is experiment I am carrying out to check possibilities of data
injection to specific osds. I tried it in Ceph v 0.36 it was working
fine but as of now in v0.48 (latest installation) it has some problem
such as "ceph goes unresponsive" when I tried to modify crushmap as
shared in prev. mail and to use them in new rados pool.
I am unable to achieve desired experiment till now. Please help me out .


-
Hemant Surale.

On Mon, Oct 1, 2012 at 10:47 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Thu, Sep 27, 2012 at 3:52 AM, hemant surale <hemant.surale@gmail.com> wrote:
>> I have upgraded my cluster to Ceph v0.48. and cluster is fine (except
>> gceph not working) .
>
> gceph has been broken for a long time, wasn't seen to be worth fixing,
> and was removed in 0.48argonaut.
>
>> How can I direct my data inject to specific osds ?
>> i tried to edit crushmap & tired to specify ruleset accordingly , But
>> its not working ( I did same for Ceph v0.36 it worked )
>
> You really should just describe your failure domains, and desired data
> placement in terms of the failure domains, but not try to control data
> placement on a server-to-server basis.
