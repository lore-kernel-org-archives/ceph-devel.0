From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Patch for rados tool to allow listomapvals to list all k/v pairs
Date: Mon, 30 Dec 2013 17:25:31 -0800
Message-ID: <52C21D0B.3080209@inktank.com>
References: <CAJO99Tmj3itMZWpjoO6tmjk7Tz9WJSjDtKwwF-BE9W1iWODkdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:35009 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365Ab3LaB0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 20:26:20 -0500
Received: by mail-yh0-f54.google.com with SMTP id z12so2508181yhz.13
        for <ceph-devel@vger.kernel.org>; Mon, 30 Dec 2013 17:26:19 -0800 (PST)
In-Reply-To: <CAJO99Tmj3itMZWpjoO6tmjk7Tz9WJSjDtKwwF-BE9W1iWODkdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Bj=F8rnar_Ness?= <bjornar.ness@gmail.com>, ceph-devel@vger.kernel.org

On 12/28/2013 05:59 AM, Bj=F8rnar Ness wrote:
> Current code only lists first 512 k/v pairs, attached patch.

Thanks for looking into this!
I moved the last_read assignment out of the conditional so it applies
to nonprintable values too, and added a simple test case:

https://github.com/ceph/ceph/pull/1022

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
