From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: librados api cleanup
Date: Fri, 18 Feb 2011 14:49:37 -0800
Message-ID: <AANLkTimPR94_wEGZmvWt=X5kzYnKafDn5sUXfJdOOgKZ@mail.gmail.com>
References: <Pine.LNX.4.64.1102141453450.20210@cobra.newdream.net>
	<AANLkTim0kgb3LfhdpxXzjfxZ55eyhfWg1BtZ7RyzusQN@mail.gmail.com>
	<Pine.LNX.4.64.1102181334100.13848@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49329 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1BRWtj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 17:49:39 -0500
Received: by fxm20 with SMTP id 20so4317553fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 14:49:37 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102181334100.13848@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Feb 18, 2011 at 1:36 PM, Sage Weil <sage@newdream.net> wrote:
> [config example]

Looks good.

> const char *rados_conf_get(rados_t cluster, const char *option);

I would prefer something like
int rados_conf_get(rados_t cluster, const char *option, char **buf, int=
 len);

We have a lot of configuration options that are ints and floats. You
can't really return a const char* pointer to an int-- you need to make
a temporary string somewhere, and that won't be const...

We should also provide some feature like "pass -1 as length, and we'll
malloc it for you."

> I think the (short term) trick will be supporting this immediately be=
fore
> the config refactoring is in place. =A0Should be possible with a hidd=
en
> argv vector and the existing internal framework, I think.

Yeah, it should be do-able.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
