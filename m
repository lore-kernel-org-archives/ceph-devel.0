From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How to direct data inject to specific OSDs
Date: Mon, 1 Oct 2012 10:17:47 -0700
Message-ID: <CADvuQRHxaU9LTwda-UUsvECA0C+Mc2Yuf1jBxAwxLj7ZGPXLtg@mail.gmail.com>
References: <CAGfy=6ktXBkVQkZ=Z9ODAmWm9cCVu=7nsGOeDE2CvNEdAGK75w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56430 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab2JARSI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 13:18:08 -0400
Received: by qaas11 with SMTP id s11so1718007qaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 10:18:07 -0700 (PDT)
In-Reply-To: <CAGfy=6ktXBkVQkZ=Z9ODAmWm9cCVu=7nsGOeDE2CvNEdAGK75w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: Dan Mick <dan.mick@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Thu, Sep 27, 2012 at 3:52 AM, hemant surale <hemant.surale@gmail.com> wrote:
> I have upgraded my cluster to Ceph v0.48. and cluster is fine (except
> gceph not working) .

gceph has been broken for a long time, wasn't seen to be worth fixing,
and was removed in 0.48argonaut.

> How can I direct my data inject to specific osds ?
> i tried to edit crushmap & tired to specify ruleset accordingly , But
> its not working ( I did same for Ceph v0.36 it worked )

You really should just describe your failure domains, and desired data
placement in terms of the failure domains, but not try to control data
placement on a server-to-server basis.
