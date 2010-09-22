From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Several patches for CEPH
Date: Wed, 22 Sep 2010 10:14:30 -0700
Message-ID: <AANLkTimSQKsa60B1i1FyxDQDu91SKCPLF9yAEARY3nks@mail.gmail.com>
References: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36959 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0IVROb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 13:14:31 -0400
Received: by qwh6 with SMTP id 6so572642qwh.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 10:14:30 -0700 (PDT)
In-Reply-To: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Sep 22, 2010 at 8:29 AM, Henry C Chang
<henry_c_chang@tcloudcomputing.com> wrote:
> 1. http://github.com/tcloud/ceph/commit/3c91d0c0e20425f94eaa374f39b2a1f398270255
>
> This fixed a monitor bug we hit several times. When some osds report
> that other osds are down,
> there is a chance that the leading monitor would enter an infinite loop (you can
> see the CPU usage of cmon is 100% from "top").
You diagnosed the problem correctly, but it looks like your patch can
make the monitor discard the wrong report! Fixed this by sticking an
"&& i != fail_notes.end()" into the while loop, in
commit:2c5a3d99aa3be5ce114072e84f73a0a6426e63fd.

> ps. I found that the master branch does not contain this piece of
> code. Is there any concern?
Counting of failure notes, and the ability to discard them, is a new
feature to help prevent flapping that didn't get into .21 but will go
into the next release.
-Greg
