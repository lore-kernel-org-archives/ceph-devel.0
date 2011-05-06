From: tsk <aixt2006@gmail.com>
Subject: Re: rbd and Metaserver
Date: Fri, 6 May 2011 11:00:53 +0800
Message-ID: <BANLkTim-7Y5DKQ+O3o4_cUbvjZ9kYghAQA@mail.gmail.com>
References: <4DC2DB6E.9010500@ufm.su>
	<2000619B57A3492DBDFCA82B0843792D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56680 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab1EFDAy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 23:00:54 -0400
Received: by wya21 with SMTP id 21so2081248wya.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2011 20:00:53 -0700 (PDT)
In-Reply-To: <2000619B57A3492DBDFCA82B0843792D@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

2011/5/6 Gregory Farnum <gregory.farnum@dreamhost.com>:
> Nope, the MDS is only required for the POSIX-compliant Ceph layer.
> -Greg

May I know that who will maintain the rbd_image_info if there is no MDS?
From where, the api int rbd_list(rados_ioctx_t io, char *names, size_t
*size)  will get the data it want?

Thx!
