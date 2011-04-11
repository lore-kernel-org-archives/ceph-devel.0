From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: mds and cpu
Date: Mon, 11 Apr 2011 08:22:04 -0700
Message-ID: <BANLkTi=ZaH1pp0SML8O4d3as_25E44z_Lw@mail.gmail.com>
References: <loom.20110409T012433-939@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60407 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab1DKPWH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 11:22:07 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DBCD2C069
	for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 08:22:06 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8C04CC067
	for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 08:22:06 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1743829ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 08:22:05 -0700 (PDT)
In-Reply-To: <loom.20110409T012433-939@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Fri, Apr 8, 2011 at 4:28 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi.
>
> Looks as if mds uses only 1 cpu on the connection. This is so, or I made a
> mistake somewhere in the settings?

This is basically right. The MDS has a bit of threading but most
operations depend on a global lock so it's unlikely to use more than a
single core.
-Greg
