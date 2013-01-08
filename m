From: Gregory Farnum <greg@inktank.com>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Tue, 8 Jan 2013 09:09:36 -0800
Message-ID: <CAPYLRzhUWYu8vp-Lk6WgyjxLH-GJ08QakTgWqZEKjVSXCbEZ2A@mail.gmail.com>
References: <50E81A3D.5070100@ledeuns.net>
	<50EB0518.9050304@ledeuns.net>
	<E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com>
	<50EBDC5E.3090207@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:48406 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343Ab3AHRJh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 12:09:37 -0500
Received: by mail-qc0-f182.google.com with SMTP id k19so867327qcs.27
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 09:09:36 -0800 (PST)
In-Reply-To: <50EBDC5E.3090207@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 8, 2013 at 12:44 AM, Denis Fondras <ceph@ledeuns.net> wrote:
>> What's wrong with your primary OSD?
>
>
> I don't know what's really wrong. The disk seems fine.

What error message do you get when you try and turn it on? If the
daemon is crashing, what is the backtrace?
-Greg
