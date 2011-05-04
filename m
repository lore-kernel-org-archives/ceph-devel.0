From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Document and example for libceph, librbd and librados
Date: Wed, 04 May 2011 15:13:23 +0200
Message-ID: <1304514803.4036.104.camel@wido-laptop.pcextreme.nl>
References: <BANLkTinSe6i7TVY7gsncqxJQ_+p_yTz13A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49975 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1EDNN0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 09:13:26 -0400
In-Reply-To: <BANLkTinSe6i7TVY7gsncqxJQ_+p_yTz13A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Wed, 2011-05-04 at 20:36 +0800, tsk wrote:
> Hi folks,
> 
>      Is there any document for libceph, librbd and librados, and where
> could I get some example for them?

What kind of examples are you looking for? In the Ceph git repository
there is:

* rados.cc (The rados tool)
* testradospp.cpp
* testrbdpp.cpp

Those might give you some examples of the libraries?

Wido

> 
> Thx!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


