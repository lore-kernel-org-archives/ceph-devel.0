From: Steve Taylor <steveftaylor@gmail.com>
Subject: Re: Librbd licensing
Date: Mon, 2 Jun 2014 10:15:19 -0600
Message-ID: <CADXiVcpM8GJcCbDkdOPWzXPoJrDdyiQn0-q4nDH6o0zpg_u8gg@mail.gmail.com>
References: <loom.20140530T192820-478@post.gmane.org> <alpine.DEB.2.00.1405301042200.11044@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:58491 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbaFBQPk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 12:15:40 -0400
Received: by mail-we0-f177.google.com with SMTP id x48so5305267wes.22
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jun 2014 09:15:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1405301042200.11044@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sorry, my previous reply was rejected by the list because it wasn't in
plain text. Let's try again.

librbd.cc:
/*
 * Ceph - scalable distributed file system
 *
 * Copyright (C) 2011 New Dream Network
 *
 * This is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License version 2.1, as published by the Free Software
 * Foundation.  See file COPYING.
 *
 */

librbd.h:
/*
 * Ceph - scalable distributed file system
 *
 * Copyright (C) 2011 New Dream Network
 *
 * This is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License version 2.1, as published by the Free Software
 * Foundation.  See file COPYING.
 *
 */

librbd.hpp:
/*
 * Ceph - scalable distributed file system
 *
 * Copyright (C) 2011 New Dream Network
 *
 * This is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License version 2.1, as published by the Free Software
 * Foundation.  See file COPYING.
 *
 */

These are the three that I've noticed poking around librbd so far. My
understanding from COPYING is that they should be LGPL, but these
copyright headers obviously state GPL instead. I'm just trying to
understand definitely which it is. :)

If a change is in order, of course I'll be happy to make the change
myself and submit a pull request if you like.

Steve

On Fri, May 30, 2014 at 11:43 AM, Sage Weil <sage@inktank.com> wrote:
> Hi Steve,
>
> On Fri, 30 May 2014, Steve Taylor wrote:
>> I am working with a company that wants to utilize librbd in a project to
>> interact with Ceph storage. For the purposes of this integration,
>> LGPL-licensed open source code is acceptable, but GPL-licensed code is not.
>> Well, at least not without other changes to the project, which can be
>> accomplished if necessary.
>>
>> The COPYING file distributed with the Ceph source code seems to indicate
>> that librbd would fall under LGPL 2.1, but some of the source files in
>> librbd reference GPL 2.1 in their copyright headers.
>
> Which files?  If there are disparities we should correct them. To the best
> of my knowledge everything in librbd is LGPL.
>
> Thanks!
> sage
>
>
>>
>> >From what I have found so far, it appears to me that the sources in
>> question were probably originally LGPL, but were switched to GPL a few
>> years back to comply with FUSE licensing, which is GPL. Is my understanding
>> correct that these librbd source files are now GPL? If so and FUSE is the
>> reason behind it, is it possible to dual-license those files so they could
>> be LGPL when not used with FUSE?
>>
>> I just want to make sure I understand the licensing properly. I apologize
>> if this has been discussed previously. I am new to the list and can't seem
>> to get the archive search feature to work.
>>
>> Steve
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
