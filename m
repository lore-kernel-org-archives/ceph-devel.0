From: Sam Lang <sam.lang@inktank.com>
Subject: Re: python examples for librados
Date: Thu, 24 Jan 2013 14:07:21 -0600
Message-ID: <CAKMAVE-BZ4hk8xrvGvk49DWvFqkT--ZjtVAdgmryzZeRonvHSA@mail.gmail.com>
References: <CAPud5_49XgVGva0J9XJT-pysCo4nxCXJDDUGkT-BmxHNYsNr5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38499 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab3AXUHW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 15:07:22 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc20so9314950obb.8
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 12:07:21 -0800 (PST)
In-Reply-To: <CAPud5_49XgVGva0J9XJT-pysCo4nxCXJDDUGkT-BmxHNYsNr5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 23, 2013 at 3:09 PM, Nick Bartos <nick@pistoncloud.com> wrote:
> I just recently found out that ceph has some python bindings (yay!).
> I see there are a couple of examples for using the rbd bindings here:
> http://ceph.com/docs/master/rbd/librbdpy/
>
> But that doesn't really include much about the librados bindings.  Are
> there any examples for that?  For example I'm interested in converting
> the following commands into python:
>
> rados -p foo put test.tmp test --object-locator test
> rados -p foo clonedata test.tmp test --object-locator test
> rados -p foo rm test.tmp --object-locator test
> rados -p foo get test test.downloaded

Josh has informed me that there are some tests for the python bindings
in src/test/pybind/test_rados.py.  Those could serve as simple
examples of library use.

https://github.com/ceph/ceph/blob/master/src/test/pybind/test_rados.py
-sam


> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
